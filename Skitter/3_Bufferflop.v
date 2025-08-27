module bufflop(in,clk,rst,bout,qout);
output bout,qout;
input clk,rst,in;
  buffer dut(.in(in),.out(bout));
  flipflop uut(.d(bout),.clk(clk),.rst(rst),.q(qout));
endmodule