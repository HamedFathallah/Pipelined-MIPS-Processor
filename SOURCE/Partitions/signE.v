module signE(ip,op);
input [15:0] ip;
output [31:0] op;

assign op = (ip[15]==0)? {16'b 0000_0000_0000_0000,ip }:{16'b 1111_1111_1111_1111 , ip};
endmodule 
