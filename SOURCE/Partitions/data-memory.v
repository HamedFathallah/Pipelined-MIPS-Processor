//data_memory
module data_memory (addr,write_data,memwrite, memread,clk,read_data);

input wire [31:0] addr;         
input wire [31:0] write_data;    
input wire memwrite, memread;
input wire clk;                 
output reg [31:0] read_data; 

reg [31:0] MEM[0:255];  // 256 words of 32-bit memory
initial
begin 
    //we initially write in the DM from this file 
    //you will need to make this text file at C:\Modeltech_pe_edu_10.4\examples
     $readmemb("data_memory_pipelinefinal.txt", MEM);
end

always @(posedge clk)
begin
  if (memread == 1'b0 && memwrite==1'b1) 
  begin
    MEM[addr] <= write_data;
  end
end
always@(negedge clk)
begin
  if (memread == 1'b1 && memwrite==1'b0) 
  begin
    read_data <= MEM[addr];
  end
end

endmodule