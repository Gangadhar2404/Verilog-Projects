`timescale 1ns/1ps

module tb_FIFO;

  // Parameters
  parameter WIDTH = 8;
  parameter DEPTH = 8;

  // Signals
  reg clk, rst;
  reg w_en, r_en;
  reg [WIDTH-1:0] data_in;
  wire [WIDTH-1:0] data_out;
  wire full, empty;

  // Instantiate the FIFO
  FIFO #(.width(WIDTH), .depth(DEPTH)) uut (
    .clk(clk),
    .rst(rst),
    .w_en(w_en),
    .r_en(r_en),
    .data_in(data_in),
    .data_out(data_out),
    .full(full),
    .empty(empty)
  );

  // Clock Generation: 10ns period (100MHz)
  always #5 clk = ~clk;

  integer i;

  initial begin
    // Initialize
    clk = 0;
    rst = 1;
    w_en = 0;
    r_en = 0;
    data_in = 0;

    // Apply reset
    #12 rst = 0;

    // Write until FIFO is full
    $display("---- Writing to FIFO ----");
    for (i = 0; i < DEPTH; i = i + 1) begin
      @(negedge clk);
      if (!full) begin
        w_en <= 1;
        data_in <= i + 1;
        $display("[%0t] Writing Data: %0d (full=%b)", $time, data_in, full);
      end
    end
    @(negedge clk) w_en <= 0; // Stop writing

    // Small delay
    #20;

    // Read until FIFO is empty
    $display("---- Reading from FIFO ----");
    for (i = 0; i < DEPTH; i = i + 1) begin
      @(negedge clk);
      if (!empty) begin
        r_en <= 1;
        $display("[%0t] Reading Data: %0d (empty=%b)", $time, data_out, empty);
      end
    end
    @(negedge clk) r_en <= 0; // Stop reading

    // Finish simulation
    #50;
    $finish;
  end

endmodule