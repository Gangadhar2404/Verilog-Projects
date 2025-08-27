module histogram(
  input [6:1] in,
  input clk,
  output reg [4:0] bin17_18 = 0,
  output reg [4:0] bin19_20 = 0,
  output reg [4:0] bin21_22 = 0,
  output reg [4:0] bin23_24 = 0,
  output reg [4:0] bin25_26 = 0,
  output reg [4:0] bin27_28 = 0,
  output reg [4:0] bin29_30 = 0,
  output reg [4:0] bin31_32 = 0,
  output reg [4:0] bin33_34 = 0,
  output reg [4:0] bin35_36 = 0,
  output reg [4:0] bin37_38 = 0
);

  always @(posedge clk) begin
    if(in == 6'd17 || in == 6'd18)
      bin17_18 <= bin17_18 + 1;
    else if(in == 6'd19 || in == 6'd20)
      bin19_20 <= bin19_20 + 1;
    else if(in == 6'd21 || in == 6'd22)
      bin21_22 <= bin21_22 + 1;
    else if(in == 6'd23 || in == 6'd24)
      bin23_24 <= bin23_24 + 1;
    else if(in == 6'd25 || in == 6'd26)
      bin25_26 <= bin25_26 + 1;
    else if(in == 6'd27 || in == 6'd28)
      bin27_28 <= bin27_28 + 1;
    else if(in == 6'd29 || in == 6'd30)
      bin29_30 <= bin29_30 + 1;
    else if(in == 6'd31 || in == 6'd32)
      bin31_32 <= bin31_32 + 1;
    else if(in == 6'd33 || in == 6'd34)
      bin33_34 <= bin33_34 + 1;
    else if(in == 6'd35 || in == 6'd36)
      bin35_36 <= bin35_36 + 1;
    else if(in == 6'd37 || in == 6'd38)
      bin37_38 <= bin37_38 + 1;
  end

endmodule