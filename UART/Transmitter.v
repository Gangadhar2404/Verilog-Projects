module transmitter(
input clk,
input rst,
input load,
input tick,
input [7:0]data_in,
output reg tx,
output reg busy
);

parameter IDLE=2'b00;
parameter START=2'b01;
parameter DATA=2'b10;
parameter STOP=2'b11;

reg [1:0]state;
reg [7:0]tx_shift;
reg [2:0]bit_index;

always @(posedge clk) begin
  if(rst) begin
  state<=IDLE;
  tx<=1'b1;
  busy<=1'b0;
  bit_index<=3'b000;
  tx_shift<=8'd0;
  end
  else begin
  case(state)
  IDLE:begin
    tx<=1'b1;
    busy<=1'b0;
    if(load) begin
      tx_shift<=data_in;
      bit_index<=3'd0;
      state<=START;
      busy<=1'b1;
    end
  end
  START:begin
    if(tick) begin
      tx<=1'b0;
      state<=DATA;
    end 
  end
  DATA:begin
    if(tick) begin
      tx<=tx_shift[0];
      tx_shift<=tx_shift>>1;
      bit_index<=bit_index+1;
      if(bit_index==3'd7) begin
        state<=STOP;
      end
    end
  end
  STOP:begin
    if(tick) begin
      tx<=1'b1;
      busy<=1'b0;
      state<=IDLE;
    end
  end
  endcase
  end
  end
  endmodule 
    
    
  
  

