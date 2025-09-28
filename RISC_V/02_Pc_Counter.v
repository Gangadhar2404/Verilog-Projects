module Pc_Counter (
  input clk,rst,
  input [31:0]Pc_in,
  output reg [31:0] PcF
  );
  always @(posedge clk) begin
    if(rst) begin
      PcF =  32'd0;
    end
    else  begin
      PcF = Pc_in;
    end
  end
 
endmodule