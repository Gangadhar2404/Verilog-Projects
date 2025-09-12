module ALU_Decoder(
  input [1:0] ALUOp,
  input func7, op5,
  input [2:0] func3,
  output reg [2:0] ALUControl
);
  always @(*) begin
    case (ALUOp)
      2'b00: ALUControl = 3'b000; // add
      2'b01: ALUControl = 3'b001; // sub (branch compare)
      2'b10: begin
        case (func3)
          3'b000: ALUControl = (func7) ? 3'b001 : 3'b000; // SUB / ADD
          3'b111: ALUControl = 3'b010; // AND
          3'b110: ALUControl = 3'b011; // OR
          3'b010: ALUControl = 3'b101; // SLT
          default: ALUControl = 3'b000;
        endcase
      end
      default: ALUControl = 3'b000;
    endcase
  end
endmodule
