
module FIFO #(
parameter width=8,
parameter depth=8
    )(
input clk,
input rst,
input w_en,
input r_en,
input [width-1:0]data_in,
output reg [width-1:0]data_out,
output full,
output empty
);

localparam addr_width=$clog2(depth);

reg [width-1:0] FIFO [0:depth-1];
reg [addr_width:0]w_ptr,r_ptr;


//////////// Write Operations //////////////
always @(posedge clk)
  begin
    if(rst) begin
      w_ptr<=0;
    end
    else 
      if(w_en && !full) begin
        FIFO[w_ptr[addr_width-1:0]] <=data_in;
        w_ptr<=w_ptr+1;
      end
   end
   
   
/////////Read Operation /////////////////////
always @(posedge clk) begin
  if(rst) begin
    r_ptr<=0;
    data_out<=0;
  end
  else if(r_en && !empty) begin
    data_out<= FIFO[r_ptr[addr_width-1:0]];
    r_ptr<=r_ptr+1;
    end
 end
 assign full={~w_ptr[addr_width],w_ptr[addr_width-1:0]}==r_ptr;
 assign empty= w_ptr==r_ptr;
endmodule
