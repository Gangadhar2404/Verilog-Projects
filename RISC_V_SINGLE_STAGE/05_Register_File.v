module Register_file(
  input [4:0] RS1, RS2, RS3,
  input [31:0] W_Data,
  input rst, clk, W_en,
  output [31:0] RD1, RD2
);

  reg [31:0] Register_Bank [31:0];
  integer i;

  // Reset / Write
  always @(posedge clk or posedge rst) begin
    if (rst) begin
      for (i = 0; i < 32; i = i + 1)
        Register_Bank[i] <= 32'd0;
    end else if (W_en && (RS3 != 5'd0)) begin
      Register_Bank[RS3] <= W_Data;  // prevent writing into x0
    end
  end

  // Asynchronous read
  assign RD1 = Register_Bank[RS1];
  assign RD2 = Register_Bank[RS2];

endmodule
