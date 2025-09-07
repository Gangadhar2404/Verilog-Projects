module RISC_V(
  input  wire CLK1,
  input  wire CLK2,   // two-phase clock
  input  wire RST,    // synchronous reset (active-high)
  output wire pc_out    
);

  // PIPELINE REGISTERS
  reg [31:0] PC;
  reg [31:0] IF_ID_IR, IF_ID_NPC;
  reg [31:0] ID_EX_IR, ID_EX_NPC, ID_EX_A, ID_EX_B, ID_EX_IMM;
  reg [31:0] EX_MEM_IR, EX_MEM_ALUOUT, EX_MEM_B;
  reg [31:0] MEM_WB_IR, MEM_WB_ALUOUT, MEM_WB_LMD;
  reg        EX_MEM_COND;
  reg [2:0]  ID_EX_type, EX_MEM_type, MEM_WB_type;

  // CONTROL SIGNALS
  reg TAKEN_BRANCH;
  reg HALTED;

  // REGISTER BANK AND MEMORY
  reg [31:0] REG_FILE [0:31];   // 32 x 32
  reg [31:0] MEM [0:1023];      // 1024 x 32 (instruction + data)

  // OPCODES
  localparam ADD    = 6'b000000,
             SUB    = 6'b000001,
             AND    = 6'b000010,
             OR     = 6'b000011,
             SLT    = 6'b000100,
             MUL    = 6'b000101,
             LW     = 6'b001000,
             SW     = 6'b001001,
             ADDI   = 6'b001010,
             SUBI   = 6'b001011,
             SLTI   = 6'b001100,
             BNEQZ  = 6'b001101,
             BEQZ   = 6'b001110,
             HLT    = 6'b111111;

  // INSTRUCTION TYPE ENCODING
  localparam RR_ALU = 3'b000,
             RM_ALU = 3'b001,
             LOAD   = 3'b010,
             STORE  = 3'b011,
             BRANCH = 3'b100,
             HALT   = 3'b101,
             NOP    = 3'b110; // added NOP

  integer i;

  
  // --------------------------
  // INSTRUCTION FETCH (IF) - on CLK1
  // --------------------------
  always @(posedge CLK1) begin
    if (RST) begin
      PC <= 0;
      IF_ID_IR <= 0;
      IF_ID_NPC <= 0;
      TAKEN_BRANCH <= 1'b0;
    end else if (!HALTED) begin
      // Branch taken from EX/MEM stage: redirect fetch
      if (((EX_MEM_IR[31:26] == BEQZ)  && (EX_MEM_COND == 1'b1)) ||
          ((EX_MEM_IR[31:26] == BNEQZ) && (EX_MEM_COND == 1'b0))) begin
        // EX_MEM_ALUOUT contains target PC (word-addressed)
        IF_ID_IR  <= 32'd0;
        IF_ID_NPC <= EX_MEM_ALUOUT + 1;
        PC        <= EX_MEM_ALUOUT;
        TAKEN_BRANCH <= 1'b1;
      end else begin
        IF_ID_IR  <= MEM[PC];
        IF_ID_NPC <= PC + 1;
        PC        <= PC + 1;
        TAKEN_BRANCH <= 1'b0;
      end
    end
  end

  // --------------------------
  // INSTRUCTION DECODE (ID) - on CLK2
  // --------------------------
  always @(posedge CLK2) begin
    if (RST) begin
      ID_EX_A <= 0;
      ID_EX_B <= 0;
      ID_EX_NPC <= 0;
      ID_EX_IR <= 0;
      ID_EX_IMM <= 0;
      ID_EX_type <= NOP;
    end else if (!HALTED) begin
      // If a branch was just taken, squash this instruction (simple flush)
      if (TAKEN_BRANCH) begin
        ID_EX_A <= 0;
        ID_EX_B <= 0;
        ID_EX_NPC <= 0;
        ID_EX_IR <= 0;
        ID_EX_IMM <= 0;
        ID_EX_type <= NOP;
      end else begin
        // SOURCE REGISTER A (rs)
        if (IF_ID_IR[25:21] == 5'b00000)
          ID_EX_A <= 32'd0;
        else
          ID_EX_A <= REG_FILE[IF_ID_IR[25:21]];

        // SOURCE REGISTER B (rt)
        if (IF_ID_IR[20:16] == 5'b00000)
          ID_EX_B <= 32'd0;
        else
          ID_EX_B <= REG_FILE[IF_ID_IR[20:16]];

        ID_EX_NPC <= IF_ID_NPC;
        ID_EX_IR  <= IF_ID_IR;
        ID_EX_IMM <= {{16{IF_ID_IR[15]}}, IF_ID_IR[15:0]};

        case (IF_ID_IR[31:26])
          ADD,SUB,AND,OR,SLT,MUL : ID_EX_type <= RR_ALU;
          ADDI,SUBI,SLTI         : ID_EX_type <= RM_ALU;
          LW                     : ID_EX_type <= LOAD;
          SW                     : ID_EX_type <= STORE;
          BNEQZ,BEQZ             : ID_EX_type <= BRANCH;
          HLT                    : ID_EX_type <= HALT;
          default                : ID_EX_type <= NOP; // treat unknown as NOP
        endcase
      end
    end
  end

  // --------------------------
  // EXECUTE (EX) - on CLK1
  // --------------------------
  always @(posedge CLK1) begin
    if (RST) begin
      EX_MEM_type <= NOP;
      EX_MEM_IR <= 0;
      EX_MEM_ALUOUT <= 0;
      EX_MEM_B <= 0;
      EX_MEM_COND <= 1'b0;
      TAKEN_BRANCH <= 1'b0;
    end else if (!HALTED) begin
      EX_MEM_type <= ID_EX_type;
      EX_MEM_IR <= ID_EX_IR;
      TAKEN_BRANCH <= 1'b0;

      // default clear condition to avoid stale value
      EX_MEM_COND <= 1'b0;

      case (ID_EX_type)
        RR_ALU: begin
          case (ID_EX_IR[31:26])
            ADD: EX_MEM_ALUOUT <= ID_EX_A + ID_EX_B;
            SUB: EX_MEM_ALUOUT <= ID_EX_A - ID_EX_B;
            AND: EX_MEM_ALUOUT <= ID_EX_A & ID_EX_B;
            OR : EX_MEM_ALUOUT <= ID_EX_A | ID_EX_B;
            SLT: EX_MEM_ALUOUT <= (ID_EX_A < ID_EX_B) ? 32'd1 : 32'd0;
            MUL: EX_MEM_ALUOUT <= ID_EX_A * ID_EX_B;
            default: EX_MEM_ALUOUT <= 32'd0;
          endcase
        end
        RM_ALU: begin
          case (ID_EX_IR[31:26])
            ADDI: EX_MEM_ALUOUT <= ID_EX_A + ID_EX_IMM;
            SUBI: EX_MEM_ALUOUT <= ID_EX_A - ID_EX_IMM;
            SLTI: EX_MEM_ALUOUT <= (ID_EX_A < ID_EX_IMM) ? 32'd1 : 32'd0;
            default: EX_MEM_ALUOUT <= 32'd0;
          endcase
        end
        LOAD, STORE: begin
          EX_MEM_ALUOUT <= ID_EX_A + ID_EX_IMM; // effective address (word addressed)
          EX_MEM_B <= ID_EX_B;
        end
        BRANCH: begin
          EX_MEM_ALUOUT <= ID_EX_NPC + ID_EX_IMM; // branch target PC (word)
          EX_MEM_COND <= (ID_EX_A == 32'd0) ? 1'b1 : 1'b0;
        end
        default: begin
          EX_MEM_ALUOUT <= 32'd0;
        end
      endcase
    end
  end

  // --------------------------
  // MEMORY (MEM) - on CLK2
  // --------------------------
  always @(posedge CLK2) begin
    if (RST) begin
      MEM_WB_type <= NOP;
      MEM_WB_IR <= 0;
      MEM_WB_ALUOUT <= 0;
      MEM_WB_LMD <= 0;
    end else begin
      MEM_WB_type <= EX_MEM_type;
      MEM_WB_IR   <= EX_MEM_IR;

      case (EX_MEM_type)
        RR_ALU, RM_ALU: MEM_WB_ALUOUT <= EX_MEM_ALUOUT;
        LOAD:          MEM_WB_LMD     <= MEM[EX_MEM_ALUOUT];
        STORE: begin
          // write only when branch not taken (simple control)
          if (!TAKEN_BRANCH) begin
            MEM[EX_MEM_ALUOUT] <= EX_MEM_B;
          end
        end
        default: begin
          MEM_WB_ALUOUT <= 32'd0;
          MEM_WB_LMD <= 32'd0;
        end
      endcase
    end
  end

  // --------------------------
  // WRITE-BACK (WB) - on CLK1
  // --------------------------
  always @(posedge CLK1) begin
    if (RST) begin
      HALTED <= 1'b0;
    end else begin
      if (!TAKEN_BRANCH) begin
        case (MEM_WB_type)
          RR_ALU: begin
            if (MEM_WB_IR[15:11] != 5'd0) // prevent write to x0
              REG_FILE[MEM_WB_IR[15:11]] <= MEM_WB_ALUOUT;
          end
          RM_ALU: begin
            if (MEM_WB_IR[20:16] != 5'd0)
              REG_FILE[MEM_WB_IR[20:16]] <= MEM_WB_ALUOUT;
          end
          LOAD: begin
            if (MEM_WB_IR[20:16] != 5'd0)
              REG_FILE[MEM_WB_IR[20:16]] <= MEM_WB_LMD;
          end
          HALT: begin
            HALTED <= 1'b1;
          end
          default: begin
            // NOP or other types: do nothing
          end
        endcase
      end
    end
  end
assign pc_out=PC;
endmodule
