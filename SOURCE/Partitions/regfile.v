//regfile
module regfile (read_reg1,read_reg2,write_reg,write_data,clk,read_data1,read_data2,regwrite);
input [4:0] read_reg1,read_reg2 ,write_reg;
input clk,regwrite;
input  signed [31:0] write_data; //signed msh far2a kiteer hena (mohma @alu)
output signed [31:0] read_data1 ,read_data2; //signed msh far2a kiteer hena (mohma @alu)
reg [31:0] Rf [0:31];
integer outfile2; //file descriptors

//output reg [31:0] Rfout [0:31];
initial
	begin
	Rf[0]= 0;
	Rf[8]= 0;
	Rf[9]= 0;
	Rf[10]=0;
	Rf[11]=2;
	Rf[12]=7;
	Rf[13]=3;	
    Rf[18]=4;
    Rf[17]=4;
    Rf[19]=10;
    Rf[20] =1;
    Rf[21]=0;
    Rf[22]=5;
    //you will need to make this text file at C:\Modeltech_pe_edu_10.4\examples (if you use modelsim)
    outfile2=$fopen("A_write_bin_pipelinefinal.txt","w");
	end
  always @(write_reg)
  begin
      // we write all changes that happen to the reg file
      $fdisplay(outfile2,"%p",Rf); //write as binary
  end

assign read_data1 = Rf[read_reg1]; 
assign read_data2 = Rf[read_reg2];
always@ (posedge clk)  //we read from Regfile in the posedge clk
	begin
		if(regwrite)
		begin
		     Rf[write_reg] <= write_data;
		end
	end
 
endmodule 