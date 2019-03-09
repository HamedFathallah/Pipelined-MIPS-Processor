module  MEM_WB(holdreg,inst20to16,inst15to11,readmemdata,aluresult,newpc,control_signals,clk,
	           INST20TO16,INST15TO11,READMEMDATA,ALURESULT,NEWPC,CONTROL_SIGNALS);
input holdreg;
input [4:0] inst20to16,inst15to11;
input [31:0] readmemdata,aluresult,newpc; // nextpc is the final value of Jumpaddress and branchaddress and pc+4
input [4:0] control_signals; //RegDst 2 bit ,MemtoReg 2bit,RegWrite 
input clk;
output reg [4:0] INST20TO16,INST15TO11;
output reg  [31:0] READMEMDATA,ALURESULT,NEWPC;
output reg [4:0] CONTROL_SIGNALS;
always @( posedge clk)
begin
if(holdreg<=0)
 begin 
   READMEMDATA <= readmemdata;
   ALURESULT <= aluresult;
   NEWPC<=newpc;
   CONTROL_SIGNALS<=control_signals;
   INST15TO11<=inst15to11;
    INST20TO16<=inst20to16;
  end  
end
endmodule
