module adder(ip1,ip2,op);
input [31:0] ip1 ,ip2;
output reg [31:0] op;
always@(ip1 or ip2)
begin
op <= ip1+ip2;
end
endmodule