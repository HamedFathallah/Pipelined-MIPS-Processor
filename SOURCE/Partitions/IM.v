module IM(read_address,Instruction);
input  [31:0] read_address  ;
wire [7:0] address_avalible;
assign address_avalible = read_address[9:2];
output wire [31:0] Instruction;

//note : to make code synthesizable you need to make the memory from 0 to 4294967295
reg [31:0] memory[0:255];

	initial
		begin
		    //we make text file to insert the instruction in the IM.
            //you will need at C:\Modeltech_pe_edu_10.4\examples (if you use to modelsim)
		    //write in this file the instruction that you want to execute 
		    //Note this is not synthesizable, So if you want check for synthesizable make this commented 
			$readmemb("MIPS_inspipelinefinal.txt", memory);
		end
assign Instruction = (read_address[31:0] > 1024)? 32'dx : memory[address_avalible];	

endmodule