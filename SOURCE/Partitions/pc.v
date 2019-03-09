
module pc(stoppc,start,in,out,clk);
input stoppc;
input [31:0] in;
input clk,start;
reg [31:0] pc_current;
output reg [31:0]out;
always@(posedge clk)
begin
if(stoppc==0)
begin
   if(start)
   begin
   pc_current<=0;
   out<=pc_current;
   end
   else if (start==0)
   begin
    pc_current<=in;
    out<=pc_current;
   end
  end 
end
endmodule