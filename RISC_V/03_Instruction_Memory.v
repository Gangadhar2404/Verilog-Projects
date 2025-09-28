module Instruction_Memory(
  input rst,
  input [31:0]addr,
  output [31:0]RD
  );
  
  reg [31:0] I_Mem [0:1023];
  
  initial begin
    I_Mem[0]=32'd0; 
  end
  
  assign RD = (rst==1) ? 32'd0 : I_Mem[addr[11:2]];
  
endmodule