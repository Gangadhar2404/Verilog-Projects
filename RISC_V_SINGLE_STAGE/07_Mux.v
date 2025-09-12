module mux1(
  input wire [31:0]in0,in1,
  input sel,
  output [31:0]out
  );
  
  assign out = (sel==1'b1) ? in1 : in0;
  
  endmodule