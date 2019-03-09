//jr check unit
module jrcheck(Instruction0to5,AluOP,jrsignal);
input [5:0] Instruction0to5;
input [1:0] AluOP;
output jrsignal;
assign jrsignal = (Instruction0to5==6'b001000 && AluOP ==2'b10)? 1'b1 : 1'b0 ;
endmodule
