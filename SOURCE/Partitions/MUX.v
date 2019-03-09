module mux(ip0,ip1,op,Ctrl);
input [31:0] ip0;
input [31:0] ip1;
input Ctrl;
output [31:0] op;
assign op = (Ctrl == 0)? ip0 : ip1 ;
endmodule 

module mux5bit(ip0,ip1,op,Ctrl);
input [4:0] ip0;
input [4:0] ip1;
input Ctrl;
output [4:0] op;
assign op = (Ctrl == 0)? ip0 : ip1 ;
endmodule

module mux3_1_5bit(ip0,ip1,ip2,op,Ctrl);
input [4:0] ip0;
input [4:0] ip1;
input [4:0] ip2;
input [1:0] Ctrl;
output [4:0] op;
assign op = (Ctrl == 00)? ip0 : (Ctrl==01)? ip1 : ip2 ;  //if ctrl ==10 or 11 then go to ip2
endmodule 

module mux3_1(ip0,ip1,ip2,op,Ctrl);
input [31:0] ip0;
input [31:0] ip1;
input [31:0] ip2;
input [1:0] Ctrl;
output [31:0] op;
assign op = (Ctrl == 00)? ip0 : (Ctrl==01)? ip1 : ip2 ;  //if ctrl ==10 or 11 then go to ip2
endmodule 

module mux4_1(ip0,ip1,ip2,ip3,op,Ctrl);
input [31:0] ip0;
input [31:0] ip1;
input [31:0] ip2;
input [31:0] ip3;
input [1:0] Ctrl;
output [31:0] op;
assign op = (Ctrl == 00)? ip0 : (Ctrl==01)? ip1 : (Ctrl==10)? ip2 : ip3 ; 
endmodule 
