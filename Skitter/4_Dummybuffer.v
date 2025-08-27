module dummybuffer # (parameter DN=1.1216)(
input in,
output out
    );
    
    wire int;
   assign int=~in;
   assign #DN out=~int;
endmodule
