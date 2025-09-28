module Sign_Extend (
  input [1:0]imm_src,
  input [31:0]in,
  output [31:0]data_out
  );
  
  
  assign data_out = (imm_src == 2'b00) ? {{20{in[31]}}, in[31:20]} :  ///Imm Type
                    (imm_src == 2'b01) ? {{20{in[31]}}, in[31:25], in[11:7]} : /// S-Type 
                    (imm_src == 2'b10) ? {{20{in[31]}}, in[31:20]} :  /// LW Type
                    (imm_src == 2'b11) ? {{19{in[31]}}, in[31], in[7], in[30:25], in[11:8], 1'b0} : /// B-type
                                         32'd0;
  endmodule