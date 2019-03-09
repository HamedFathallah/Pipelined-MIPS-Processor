//ALU
module alu(opA, opB, alu_ctrl, result, flagzero, instructionfrom6to10);

input signed [31:0] opA;
input signed [31:0] opB;
input [3:0] alu_ctrl;
input [4:0] instructionfrom6to10;//part of big instruction bits from 10 to 6

output reg signed[31:0] result;
output flagzero; //1 if result is 0

assign flagzero = (result==0)? 1'b1:1'b0 ;//zero equals one if result=0

always @(alu_ctrl or opA or opB) 
begin
	case(alu_ctrl) 
		4'b0000: result<=opA&opB;//And
		4'b0001: result<=opA|opB;//Or
		4'b0010: result<=opA+opB;//Add
		4'b0110: result<=opA-opB;//Sub
		4'b0111: result<=opA<opB?1:0; //slt
		4'b1111: result<=opB<<instructionfrom6to10 ;//SLL
		default: result<=32'bxxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx;
	endcase
end
endmodule