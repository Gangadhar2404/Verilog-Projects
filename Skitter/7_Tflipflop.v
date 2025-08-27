module tff(in,out,clk,rst);
input in,clk,rst;
output reg out;
initial 
begin
out=0;
end
always @(posedge clk)
begin
if(rst)
begin
out<=1'b0;
end
else if(in==0)
begin
out<=out;
end
else
begin
out<=~out;
end
end
endmodule