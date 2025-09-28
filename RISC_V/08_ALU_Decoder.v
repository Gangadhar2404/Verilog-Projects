module ALU_Decoder(
  input [6:0]Opcode,
  input [2:0]func3,
  input func7,
  input [1:0] ALU_Op,
  output [2:0] ALU_Control
  );
  
  assign ALU_Control = (ALU_Op == 2'b00) ? 3'b000 : // ADD For LW and SW
                     (ALU_Op == 2'b01) ? 3'b001 : // SUB for Branch
                     (((ALU_Op == 2'b10) || (ALU_Op == 2'b11)) && (func3==3'b000) && (func7 == 1'b0)) ? 3'b000 :  // ADD For R Type/I Type
                     (((ALU_Op == 2'b10) || (ALU_Op == 2'b11)) && (func3==3'b000)&& (func7 == 1'b1)) ? 3'b001 :  // SUB
                     (((ALU_Op == 2'b10) || (ALU_Op == 2'b11)) && (func3==3'b100)) ? 3'b100 : // XOR
                     (((ALU_Op == 2'b10) || (ALU_Op == 2'b11)) && (func3==3'b110)) ? 3'b011 : // OR
                     (((ALU_Op == 2'b10) || (ALU_Op == 2'b11)) && (func3==3'b111)) ? 3'b010 : // AND
                     (((ALU_Op == 2'b10) || (ALU_Op == 2'b11)) && (func3==3'b001)) ? 3'b101 : // SLL / SLLI
                     (((ALU_Op == 2'b10) || (ALU_Op == 2'b11)) && (func3==3'b101)) ? 3'b110 : // SRL / SRLI
                     3'b000 ; // default

                                                                                      
endmodule  