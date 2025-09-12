module Program_Counter(
  input rst,clk,
  input [31:0]pc_next,
  output reg [31:0]pc
  );
  
  always @(posedge clk) begin
    if(rst) begin
      pc<=32'd0;
    end
    else begin
      pc<=pc_next;
    end
  end
endmodule