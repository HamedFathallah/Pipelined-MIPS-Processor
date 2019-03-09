
//ID_EX REGISTER

module ID_EX(holdreg,inst20to16,inst15to11,readdata1,readdata2,newpc,signe,control_signals,inst0to10,clk,
	         INST20TO16,INST15TO11,READDATA1,READDATA2,NEWPC,SIGNE,CONTROL_SIGNALS,INST0TO10);
input holdreg;
input [4:0] inst20to16,inst15to11;
input [31:0] readdata1,readdata2,newpc,signe; //newpc is pc+4 (output of adder)
input [9:0] control_signals; //RegDst 2 bit  ,AlUSrc,MemtoReg 2bit,RegWrite, Memread,Memwrite,AluOP(2bits) //memread to alusrc = 5 to 0 respectivelyd
input [10:0] inst0to10; // inst[5:0] needed by alucontrol && inst[10:6] needed by Alu to make SLL
input clk ; 
output reg [4:0] INST20TO16,INST15TO11;
output reg [31:0] READDATA1,READDATA2,NEWPC,SIGNE;
output reg [9:0] CONTROL_SIGNALS;
output reg [10:0] INST0TO10;
always @ (posedge clk)
begin

if(holdreg==0)
begin
  READDATA1 <= readdata1;
  READDATA2 <= readdata2;
  NEWPC<=newpc;
  SIGNE <= signe;
  CONTROL_SIGNALS <= control_signals;
  INST0TO10 <= inst0to10;
  INST15TO11<=inst15to11;
  INST20TO16<=inst20to16;
end
end

endmodule
