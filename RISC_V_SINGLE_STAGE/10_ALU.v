module ALU(
  input [2:0] ALUControl,
  input [31:0] A,B,
  output reg [31:0] Result,
  output Z,N,V,C
);
  reg Cout;
  reg Overflow;

  always @(*) begin
    Cout = 0;
    Overflow = 0;
    case (ALUControl)
      3'b000: begin // ADD
        {Cout, Result} = A + B;
        Overflow = (A[31] & B[31] & ~Result[31]) | (~A[31] & ~B[31] & Result[31]);
      end
      3'b001: begin // SUB
        {Cout, Result} = A - B;
        Overflow = (A[31] & ~B[31] & ~Result[31]) | (~A[31] & B[31] & Result[31]);
      end
      3'b010: Result = A & B;
      3'b011: Result = A | B;
      3'b101: Result = ($signed(A) < $signed(B)) ? 32'd1 : 32'd0;
      default: Result = 32'd0;
    endcase
  end

  assign Z = (Result == 32'd0);
  assign N = Result[31];
  assign C = Cout;
  assign V = Overflow;
endmodule
