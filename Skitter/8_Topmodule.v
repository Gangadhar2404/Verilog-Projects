module top(bout,clk,rst,qout,en_out,bin17_18,bin19_20,bin21_22,bin23_24,bin25_26,bin27_28,bin29_30,bin31_32,bin33_34,bin35_36,bin37_38);
input clk,rst;
output bout;
output[21:0]qout;
output [6:1]en_out;
output [4:0]bin17_18,bin19_20,bin21_22,bin23_24,bin25_26,bin27_28,bin29_30,bin31_32,bin33_34,bin35_36,bin37_38;
wire dbowire;
integer i;
wire s1,s2,s3,s4,s5,s6,s7,s8,s9,s10,s11,s12,s13,s14,s15,s16,s17,s18,s19,s20,s21,s22;
///////Tflipflop /////////////////////
tff dut(.in(clk),.out(twire),.clk(clk),.rst(rst));

dummybuffer uut(.in(twire),.out(dbowire));
////buffer///////////////////////////
bufflop st1(.in(dbowire),.clk(clk),.rst(rst),.bout(s1),.qout(qout[0]));
bufflop st2(.in(s1),.clk(clk),.rst(rst),.bout(s2),.qout(qout[1]));
bufflop st3(.in(s2),.clk(clk),.rst(rst),.bout(s3),.qout(qout[2]));
bufflop st4(.in(s3),.clk(clk),.rst(rst),.bout(s4),.qout(qout[3]));
bufflop st5(.in(s4),.clk(clk),.rst(rst),.bout(s5),.qout(qout[4]));

bufflop st6(.in(s5),.clk(clk),.rst(rst),.bout(s6),.qout(qout[5]));
bufflop st7(.in(s6),.clk(clk),.rst(rst),.bout(s7),.qout(qout[6]));
bufflop st8(.in(s7),.clk(clk),.rst(rst),.bout(s8),.qout(qout[7]));
bufflop st9(.in(s8),.clk(clk),.rst(rst),.bout(s9),.qout(qout[8]));
bufflop st10(.in(s9),.clk(clk),.rst(rst),.bout(s10),.qout(qout[9]));

bufflop st11(.in(s10),.clk(clk),.rst(rst),.bout(s11),.qout(qout[10]));
bufflop st12(.in(s11),.clk(clk),.rst(rst),.bout(s12),.qout(qout[11]));
bufflop st13(.in(s12),.clk(clk),.rst(rst),.bout(s13),.qout(qout[12]));
bufflop st14(.in(s13),.clk(clk),.rst(rst),.bout(s14),.qout(qout[13]));
bufflop st15(.in(s14),.clk(clk),.rst(rst),.bout(s15),.qout(qout[14]));

bufflop st16(.in(s15),.clk(clk),.rst(rst),.bout(s16),.qout(qout[15]));
bufflop st17(.in(s16),.clk(clk),.rst(rst),.bout(s17),.qout(qout[16]));
bufflop st18(.in(s17),.clk(clk),.rst(rst),.bout(s18),.qout(qout[17]));
bufflop st19(.in(s18),.clk(clk),.rst(rst),.bout(s19),.qout(qout[18]));
bufflop st20(.in(s19),.clk(clk),.rst(rst),.bout(s20),.qout(qout[19]));

bufflop st21(.in(s20),.clk(clk),.rst(rst),.bout(s21),.qout(qout[20]));
bufflop st22(.in(s21),.clk(clk),.rst(rst),.bout(bout),.qout(qout[21]));
/////////////////

encoder e1(.a(qout),.en_out(en_out));

/////////////////

histogram h1(.in(en_out),.clk(clk),.bin17_18(bin17_18),.bin19_20(bin19_20),.bin21_22(bin21_22),.bin23_24(bin23_24),.bin25_26(bin25_26),.bin27_28(bin27_28),.bin29_30(bin29_30),.bin31_32(bin31_32),.bin33_34(bin33_34),.bin35_36(bin35_36),.bin37_38(bin37_38));

/////////////////
endmodule