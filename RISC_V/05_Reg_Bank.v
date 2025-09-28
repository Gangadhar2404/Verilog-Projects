module Reg_Bank (
  input clk,rst,
  input [31:0]data,
  input reg_write,
  input [4:0]RS1,RS2,RS3,
  output [31:0]RD1,RD2
  );
  
  integer i;
  reg [31:0] Reg_Bank [31:0];
  
  always @(posedge clk) begin
    if(((rst==1'b0) && reg_write == 1'b1) && (RS3 != 5'b00000))begin
        Reg_Bank[RS3] <= data;
    end
  end
  
  assign RD1 = (rst==1'b1) ? 32'd0 : Reg_Bank[RS1];
  assign RD2 = (rst==1'b1) ? 32'd0 : Reg_Bank[RS2];
  
  initial begin
    Reg_Bank[0] = 32'd0;
  end
endmodule
      
      
  