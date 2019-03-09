module Sll2(ip,op);
input [31:0] ip;
output [31:0] op;
assign op = ip << 2;
endmodule

module Sll2_26bit(ip,op);
input [25:0] ip;
output [27:0] op;
assign op = ip << 2;
endmodule