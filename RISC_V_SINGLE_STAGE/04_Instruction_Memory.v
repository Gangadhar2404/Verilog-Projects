module Instruction_Memory(
  input [31:0] A,
  input rst,
  output [31:0] Rd
);
   reg [31:0] I_Mem [1023:0];


  assign Rd = (rst==1) ? 32'd0 : I_Mem[A[31:2]];

endmodule
