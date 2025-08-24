`timescale 1ns/1ps

module uart_tb;

reg clk;
reg rst;
reg load;
reg [7:0] data_in;
wire tx;
wire [7:0] data_out;
wire rx_done;

// Instantiate top module
uart_top uut (
    .clk(clk),
    .rst(rst),
    .load(load),
    .data_in(data_in),
    .tx(tx),
    .data_out(data_out),
    .rx_done(rx_done)
);

// Clock generation: 20ns period => 50 MHz
always #10 clk = ~clk;

initial begin
    // Initialize
    clk = 0;
    rst = 1;
    load = 0;
    data_in = 8'b0;

    // Reset pulse
    #100;
    rst = 0;

    // Send first byte
    @(posedge clk);
    data_in = 8'hA5;  // Example data
    load = 1;

    @(posedge clk);
    load = 0;

    // Wait for reception to complete
    wait(rx_done);
    $display("Received Data = %h", data_out);

    // Send another byte
    #200; // Wait enough time for transmission to complete
    @(posedge clk);
    data_in = 8'h3C;
    load = 1;

    @(posedge clk);
    load = 0;

    wait(rx_done);
    $display("Received Data = %h", data_out);

    #10000;
    $finish;
end

endmodule
