module tb;
//defparam buffer.N=(1);
//defparam dummybuffer.DN=(1*116);

logic rst,clk;
logic bout;
logic [21:0]qout;
logic [6:1]en_out;
logic [4:0]bin17_18,bin19_20,bin21_22,bin23_24,bin25_26,bin27_28,bin29_30,bin31_32,bin33_34,bin35_36,bin37_38;
top dut(.clk(clk),.rst(rst),.bout(bout),.qout(qout),.en_out(en_out),.bin17_18(bin17_18),.bin19_20(bin19_20),.bin21_22(bin21_22),.bin23_24(bin23_24),.bin25_26(bin25_26),.bin27_28(bin27_28),.bin29_30(bin29_30),.bin31_32(bin31_32),.bin33_34(bin33_34),.bin35_36(bin35_36),.bin37_38(bin37_38));
always #1 clk=~clk;
initial begin
clk=0;
rst=0;

#40 $finish;
end 



endmodule