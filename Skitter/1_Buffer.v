`timescale 1ns / 1ps 

module buffer # (parameter N= 0.0701)(in,out);
input in;
output out;
wire w1;

    assign   w1=~in;
    assign  #N out=~w1;
endmodule