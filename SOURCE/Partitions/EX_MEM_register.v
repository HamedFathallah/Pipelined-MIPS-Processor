module EX_MEM(holdreg,inst20to16,inst15to11,control_signals,readdata2,aluresult,newpc,clk,
	          INST20TO16,INST15TO11,CONTROL_SIGNALS,READDATA2,ALURESULT,NEWPC);
input holdreg;
input [4:0] inst20to16,inst15to11;
input [6:0] control_signals;  //RegDst 2 bit ,MemtoReg 2bit,RegWrite, Memread,Memwrite
input [31:0] readdata2,aluresult,newpc;
input clk ;
output reg [4:0] INST20TO16,INST15TO11;
output reg [6:0] CONTROL_SIGNALS;
output reg [31:0] READDATA2,ALURESULT,NEWPC;
always @ (posedge clk)
begin
if(holdreg<=0)
begin 
    CONTROL_SIGNALS<=control_signals;
    READDATA2<= readdata2;
    ALURESULT<=aluresult;
    NEWPC<=newpc;   
    INST15TO11<=inst15to11;
    INST20TO16<=inst20to16;
 end   
end
endmodule