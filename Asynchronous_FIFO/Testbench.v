`timescale 1ns/1ps

module tb_async_fifo;

  parameter DEPTH = 8;
  parameter WIDTH = 8;

  reg w_clk, r_clk, rst;
  reg w_en, r_en;
  reg [WIDTH-1:0] data_in;
  wire [WIDTH-1:0] data_out;
  wire full, empty;

  // Instantiate DUT
  asynchronous_FIFO #(
    .depth(DEPTH),
    .width(WIDTH)
  ) dut (
    .r_clk(r_clk),
    .w_clk(w_clk),
    .rst(rst),
    .w_en(w_en),
    .r_en(r_en),
    .data_in(data_in),
    .data_out(data_out),
    .full(full),
    .empty(empty)
  );

  // Generate write clock (fast)
  initial w_clk = 0;
  always #5 w_clk = ~w_clk;   // 100 MHz

  // Generate read clock (slow)
  initial r_clk = 0;
  always #12 r_clk = ~r_clk;  // ~41.6 MHz

  // Stimulus
  integer i;
  initial begin
    // Initialize signals
    rst = 1;
    w_en = 0;
    r_en = 0;
    data_in = 0;

    // Apply reset
    #20;
    rst = 0;

    // Write data into FIFO
    $display("---- Writing Data ----");
    for (i = 1; i < 12; i = i + 1) begin
      @(posedge w_clk);
      if (!full) begin
        w_en <= 1;
        data_in <= i;
        $display($time, " ns : WRITE data_in=%0d (full=%b)", i, full);
      end else begin
        w_en <= 0;
        $display($time, " ns : FIFO FULL, cannot write");
      end
    end
    w_en <= 0;

    // Wait a little before reading
    #50;

    // Read data from FIFO
    $display("---- Reading Data ----");
    for (i =1 ; i < 12; i = i + 1) begin
      @(posedge r_clk);
      if (!empty) begin
        r_en <= 1;
        $display($time, " ns : READ data_out=%0d (empty=%b)", data_out, empty);
      end else begin
        r_en <= 0;
        $display($time, " ns : FIFO EMPTY, cannot read");
      end
    end
    r_en <= 0;

    #100;
    $finish;
  end

endmodule
