module Data_Memory(
  input [31:0] Data,
  input W_en, rst, clk,
  input [9:0] A,
  output [31:0] RD
);

  reg [31:0] Data_Memory [1023:0];
  integer j;

  // Reset / Write
  always @(posedge clk or posedge rst) begin
    if (rst) begin
      for (j = 0; j < 1024; j = j + 1)
        Data_Memory[j] <= 32'd0;
    end else if (W_en) begin
      Data_Memory[A] <= Data;
    end
  end

  // Asynchronous read
  assign RD = Data_Memory[A];

endmodule
