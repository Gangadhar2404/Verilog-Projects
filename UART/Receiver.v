module receiver(
input clk,
input rst,
input tick,
input rx,
output reg rx_done,
output reg [7:0]data_out,
output reg busy
);
parameter IDLE=2'b00;
parameter START=2'b01;
parameter DATA=2'b10;
parameter STOP=2'b11;

reg [2:0]bit_index;
reg [7:0]rx_shift;
reg [1:0]state;
always @(posedge clk)begin
  if (rst) begin
    state<=IDLE;
    bit_index<=3'd0;
    rx_shift<=8'd0;
    busy<=1'd0;
    rx_done<=1'b0;
    data_out<=8'd0;
    end
  else begin
    rx_done<=0;
     case(state)
       IDLE:begin
         busy<=1'b0;
         if(~rx) begin
           state <= START;
           busy<=1'b1;
         end
       end
       START:begin
         if(tick) begin
           if(~rx) begin
             state<=DATA;
             bit_index<=0;
           end else begin
             state<=IDLE;
            end
           end
         end
       DATA: begin
         if(tick) begin
           rx_shift<={rx,rx_shift[7:1]};
           bit_index<=bit_index+1;
           
           if(bit_index==7) begin
             state<=STOP;
            end
          end
        end
        STOP:begin
          if(tick)begin
            if(rx) begin
              data_out<=rx_shift;
              rx_done<=1'b1;
            end
            state<=IDLE;
          end 
        end
      endcase
    end
  end
endmodule
         
       
       
  
  
