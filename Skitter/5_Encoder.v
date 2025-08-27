module encoder(
input [21:0]a,
output reg [6:1]en_out
    );
    reg [20:0]y;
    integer i;
    always @(*)
      begin
       for (i=1;i<=22;i=i+1)
         begin
         y[i]<=a[i]^a[i-1];
         if (y[i]==1)
           begin
           en_out=i+5'd16;
           end
         end
    
      end
endmodule
