module Data_Memory (
  input clk,rst,
  input [31:0]data,
  input [31:0]addr,
  input mem_write,
  output [31:0]out
  );
  
  reg [31:0] Data_Memory [0:1024];
  
  always @(posedge clk) begin
    if((mem_write==1'b1) && (rst==1'b0)) begin
      Data_Memory[addr] <= data;
    end
  end
  
  assign out = (rst==1'b1) ? 32'b0 : Data_Memory[addr];
  
endmodule
      