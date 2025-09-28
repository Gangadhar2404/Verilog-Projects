module Fetch_Cycle (
  input clk,rst,
  input Pc_Src,
  input [31:0] Pc_Target,
  output [31:0]instr_D,PCD,PCPlusD
  );
  
  reg [31:0] instr_D_R,PCD_R,PCPlusD_R;
  wire [31:0] PCPlusF,Pc_in,PcF,InstrW;
  
  MUX M1(
       .in0(PCPlusF),
       .in1(Pc_Target),
       .sel(Pc_Src),
       .out(Pc_in)
       );
       
       
  Pc_Counter PC(
               .clk(clk),
               .rst(rst),
               .Pc_in(Pc_in),
               .PcF(PcF)
              );
              
  Instruction_Memory IMEM(
                      .rst(rst),
                      .addr(PcF),
                      .RD(InstrW)
                     );
                     
   Adder A1(
           .a(PcF),
           .b(32'h00000004),
           .sum(PCPlusF)
         );
 
 always @(posedge clk)begin
   if(rst) begin
     instr_D_R <= 32'd0;
     PCD_R <= 32'd0;
     PCPlusD_R <= 32'd0;
   end
   else begin
     instr_D_R <= InstrW;
     PCD_R <= PcF;
     PCPlusD_R <= PCPlusF;
   end
 end
 
 assign instr_D = (rst==1'b1) ? 32'h00000000 : instr_D_R;
 assign PCD = (rst==1'b1) ? 32'h00000000 : PCD_R;
 assign PCPlusD = (rst==1'b1) ? 32'h00000000 : PCPlusD_R;
 
 endmodule
 
 
            