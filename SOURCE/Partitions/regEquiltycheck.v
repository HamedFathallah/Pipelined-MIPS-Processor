//check register equality
module Equilty(read_data1,read_data2,isequal);
input [31:0] read_data1;
input [31:0] read_data2;
output isequal ;
assign isequal = (read_data1 == read_data2)? 1'b1 : 1'b0;
endmodule