module Sign_Extend(
  input  [31:0] in,
  input  [1:0]  ImmSrc,
  output reg [31:0] imm_ex
);
  always @(*) begin
    case (ImmSrc)
      2'b00: imm_ex = {{20{in[31]}}, in[31:20]}; // I-type
      2'b01: imm_ex = {{20{in[31]}}, in[31:25], in[11:7]}; // S-type
      2'b10: imm_ex = {{19{in[31]}}, in[31], in[7], in[30:25], in[11:8], 1'b0}; // B-type
      default: imm_ex = 32'd0;
    endcase
  end
endmodule
