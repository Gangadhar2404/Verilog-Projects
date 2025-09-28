module Write_Back (
  input Reg_WriteW,Result_SrcW,
  input [31:0] ReadDataW,PcPlusW,ALU_ResultW,
  input [4:0]RDW,
  output [31:0]ResultW
  );
  
  MUX M3(
          .in0(ALU_ResultW),
          .in1(ReadDataW),
          .sel(Result_SrcW),
          .out(ResultW)
         ); 
 endmodule        
         