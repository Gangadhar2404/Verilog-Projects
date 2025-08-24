module uart_top(
    input clk,
    input rst,
    input load,
    input [7:0] data_in,
    output tx,
    output [7:0] data_out,
    output rx_done
);

wire tick;
wire busy_tx;
wire busy_rx;

// Baud rate generator
baudrate #( 
    .freq(5000),
    .baud(100)
) baud_inst (
    .clk(clk),
    .rst(rst),
    .tick(tick)
);

// Transmitter
transmitter tx_inst (
    .clk(clk),
    .rst(rst),
    .load(load),
    .tick(tick),
    .data_in(data_in),
    .tx(tx),
    .busy(busy_tx)
);

// Receiver
receiver rx_inst (
    .clk(clk),
    .rst(rst),
    .tick(tick),
    .rx(tx),               // Loopback: tx connected to rx
    .rx_done(rx_done),
    .data_out(data_out),
    .busy(busy_rx)
);

endmodule
