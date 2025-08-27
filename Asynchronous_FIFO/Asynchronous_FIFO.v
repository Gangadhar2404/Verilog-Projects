module asynchronous_FIFO #(
parameter depth=8,
parameter width=8
)(
input r_clk,
input w_clk,
input rst,
input w_en,
input r_en,
input [width-1:0]data_in,
output reg [width-1:0]data_out,
output full,
output empty
);

localparam addr_width=$clog2(depth);

reg [width-1:0] FIFO [depth-1:0];


reg [addr_width:0]wb_ptr,rb_ptr;
wire [addr_width:0]rg_ptr,wg_ptr;
reg [addr_width:0]wg_ptr_sync1,wg_ptr_sync2;
reg [addr_width:0]rg_ptr_sync1,rg_ptr_sync2;
//////////Write Operation ////////////////
always @(posedge w_clk or posedge rst) begin
  if(rst)begin
    wb_ptr<=0;
  end
  else 
  if(w_en && !full) begin
    FIFO[wb_ptr[addr_width-1:0]]<=data_in;
    wb_ptr<=wb_ptr+1;
  end
end
assign wg_ptr=(wb_ptr>>1)^wb_ptr;


//////////read Operation ////////////////
always @(posedge r_clk or posedge rst) begin
  if(rst)begin
    rb_ptr<=0;
    data_out<=0;
  end
  else 
  if(r_en && !empty) begin
    data_out<=FIFO[rb_ptr[addr_width-1:0]];
    rb_ptr<=rb_ptr+1;
  end
end  
assign rg_ptr=(rb_ptr>>1)^rb_ptr;


/////////////2 flop Synchronizer for write logic to read logic ///////////////////
always @(posedge r_clk or posedge rst)begin
  if(rst)begin
    wg_ptr_sync1<=0;
    wg_ptr_sync2<=0;
  end
  else begin
    wg_ptr_sync1<=wg_ptr;
    wg_ptr_sync2<=wg_ptr_sync1;
  end
end
    
/////////////2 flop Synchronizer for read logic to write logic ///////////////////
always @(posedge w_clk or posedge rst)begin
  if(rst)begin
    rg_ptr_sync1<=0;
    rg_ptr_sync2<=0;
  end
  else begin
    rg_ptr_sync1<=rg_ptr;
    rg_ptr_sync2<=rg_ptr_sync1;
  end
end

assign empty=rg_ptr==wg_ptr_sync2;
wire [addr_width:0] wb_ptr_next = wb_ptr + 1;
wire [addr_width:0] wg_ptr_next = (wb_ptr_next >> 1) ^ wb_ptr_next; 
// Full check before writing 
assign full = (wg_ptr_next == {~rg_ptr_sync2[addr_width:addr_width-1], rg_ptr_sync2[addr_width-2:0]});
endmodule
