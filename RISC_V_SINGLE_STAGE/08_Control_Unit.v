module Control_unit(
  input [6:0]op,
  input Zero,
  output RegWrite,ALUSrc,MemWrite,PcSrc,ResultSrc,
  output [1:0]ImmSrc,ALUOp
  );
  wire Branch;
  
  assign RegWrite = (op==7'b0000011) | (op==7'b0110011);
  
  assign MemWrite = (op==7'b0100011);
  
  assign ALUSrc = (op==7'b0000011) | (op==7'b0100011);
  
  assign ResultSrc = (op==7'b0000011);
  
  assign Branch = (op==7'b1100011);
  
  assign ImmSrc = (op==7'b0000011) ? 2'b00 :
                  (op==7'b0100011) ? 2'b01 :
                  (op==7'b0110011) ? 2'bx  :
                  (op==7'b1100011) ? 2'b10 : 2'bxx;
                  
  assign ALUOp = (op==7'b0000011) ? 2'b00 :
                  (op==7'b0100011) ? 2'b00 :
                  (op==7'b0110011) ? 2'b10 :
                  (op==7'b1100011) ? 2'b01 : 2'bxx;
 
 
  assign PcSrc = Zero & Branch;       
  endmodule
                                  
  
  
  
  