//IF_ID REGISTER
module IF_ID(holdreg,inst,newpc,INST,NEWPC,clk);
input holdreg;
input [31:0] inst,newpc; //newpc is pc+4 (output of the adder)
input clk;
output reg [31:0] INST,NEWPC;
always @(posedge clk)
begin
if(holdreg==0)
  begin
  INST[31:0]<=inst[31:0];
  NEWPC<=newpc;
  end
end
endmodule
