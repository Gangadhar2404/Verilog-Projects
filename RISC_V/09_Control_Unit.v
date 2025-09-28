module Control_Unit(
  input [6:0]Opcode,
  input [2:0]func3,
  input func7,
  output Branch,Mem_Write,Reg_Write,Result_Src,ALU_Src,
  output [1:0]Imm_Src,
  output [2:0]ALU_Control
  );
  
  wire [1:0]ALU_Op;
  
  Main_Decoder MD(
                 .Opcode(Opcode),
                 .Reg_Write(Reg_Write),
                 .Mem_Write(Mem_Write),
                 .Result_Src(Result_Src),
                 .Branch(Branch),
                 .ALU_Src(ALU_Src),
                 .ALU_Op(ALU_Op),
                 .Imm_Src(Imm_Src)
               );
 ALU_Decoder AD (
                .Opcode(Opcode),
                .func3(func3),
                .func7(func7),
                .ALU_Op(ALU_Op),
                .ALU_Control(ALU_Control) 
              );  
              
 endmodule            