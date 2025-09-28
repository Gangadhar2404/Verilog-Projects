module Main_Decoder (
  input [6:0]Opcode,
  output Reg_Write,Mem_Write,Result_Src,Branch,ALU_Src,
  output [1:0] ALU_Op,Imm_Src
  );
  
  assign Reg_Write = ((Opcode == 7'b0110011) || (Opcode == 7'b0000011) || (Opcode == 7'b0010011)); //R Type Load Type I Type
  
  assign Mem_Write = (Opcode == 7'b0100011); // S Type
  
  assign Result_Src = (Opcode == 7'b0000011); // Load Type
  
  assign Branch = (Opcode == 7'b1100011); // B Type
  
  assign ALU_Src = ((Opcode == 7'b0100011) || (Opcode == 7'b0000011) || (Opcode == 7'b0010011)); //S Type Load Type I Type
  
  assign ALU_Op = (Opcode == 7'b0000011 || Opcode == 7'b0100011) ? 2'b00 : //LW SW Type
                  (Opcode == 7'b0110011) ? 2'b10 : // R Type
                  (Opcode == 7'b0010011) ? 2'b11 : //I Type
                  (Opcode == 7'b1100011) ? 2'b01 : // B Type
                                           2'b00; 
                  
  assign Imm_Src = (Opcode == 7'b0010011) ? 2'b00 : //I Type
                   (Opcode == 7'b0100011) ? 2'b01 : //S Type
                   (Opcode == 7'b0000011) ? 2'b10 : //L Type
                   (Opcode == 7'b1100011) ? 2'b11 : // B Type
                                            2'b00 ; 
endmodule