module baudrate #(
    parameter freq = 5000,      // System clock frequency
    parameter baud = 100           // UART baud rate
)(
    input wire clk,
    input wire rst,
    output reg tick
);

    localparam integer ccpt = freq / (baud * 16);  // Oversampling by 16
    localparam integer WIDTH = $clog2(ccpt);       // Bits needed for counter

    reg [WIDTH-1:0] count;

    always @(posedge clk) begin
        if (rst) begin
            count <= 0;
            tick  <= 0;
        end else if (count == ccpt - 1) begin
            tick  <= 1;
            count <= 0;
        end else begin
            tick  <= 0;
            count <= count + 1;
        end
    end

endmodule
