//Pc
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

//adder
module adder(ip1,ip2,op);
input [31:0] ip1 ,ip2;
output reg [31:0] op;
always@(ip1 or ip2)
begin
op <= ip1+ip2;
end
endmodule

//signE
module signE(ip,op);
input [15:0] ip;
output [31:0] op;

assign op = (ip[15]==0)? {16'b 0000_0000_0000_0000,ip }:{16'b 1111_1111_1111_1111 , ip};
endmodule 

//sLL2
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

//MUX's
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


//Instruction memory
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

//control unit
module control(opcode,reset, RegDst, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, AluOP,Jump);

input [5:0] opcode;
input reset;


output reg ALUSrc;
output reg RegWrite;
output reg MemRead;
output reg MemWrite;
output reg Branch;
output reg Jump;

output reg  [1:0] RegDst;
output reg [1:0] MemtoReg;
output reg [1:0] AluOP;


always @(opcode or reset) 
begin

    if(reset)
    begin
    RegDst <=1'b0;
    ALUSrc <=1'b0;
    MemtoReg<=1'b0;
    RegWrite<= 1'b0;
    MemRead <= 1'b0;
    MemWrite<=1'b0;
    Branch<=1'b0;
    AluOP<=2'b00;
    Jump<=1'b0;
    end 
	case (opcode) 
		6'b000000:{RegDst, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, AluOP, Jump}<=12'b 01_0_00_1_0_0_0_10_0; //r
		6'b100011:{RegDst, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, AluOP, Jump}<=12'b 00_1_01_1_1_0_0_00_0; //lw
		6'b101011:{RegDst, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, AluOP, Jump}<=12'b xx_1_xx_0_0_1_0_00_0; //sw
		6'b001000:{RegDst, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, AluOP, Jump}<=12'b xx_1_xx_1_0_0_0_00_0; //addi
		6'b000100:{RegDst, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, AluOP, Jump}<=12'b xx_0_xx_0_0_0_1_01_0; //beq
		6'b000010:{RegDst, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, AluOP, Jump}<=12'b xx_x_xx_0_0_0_0_01_1; //j (we give AluOP 01 as beq because w need to get jr signal =0 not x)
		6'b000011:{RegDst, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, AluOP, Jump}<=12'b 10_x_10_1_0_0_0_01_1; //jal (we give AluOP 01 as beq because w need to get jr signal =0 not x)
		6'b001101:{RegDst, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, AluOP, Jump}<=12'b 00_1_00_1_0_0_0_11_0; //ori
		default:
	{RegDst, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, AluOP, Jump}<=12'bxx_x_xx_xxx_x_xx_x;
	endcase

end

endmodule


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
/*always
  begin
       Rfout[2] <= Rf[2];
  end
  */
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


//Alu_control 
module Alu_ctrl(input [1:0] AluOP,input [5:0] func,output reg [3:0] alu_ctrl);


always @(AluOP or func)
begin



 if(AluOP == 2'b00)
 begin
   alu_ctrl <= 4'b0010; // load_word or store word or addi
    //jr<=1'b0; 
 end
 if(AluOP == 2'b01)
 begin
  alu_ctrl <= 4'b0110; // branch equal
  //jr<=1'b0;
  end
 if(AluOP == 2'b11)
 begin
 alu_ctrl <= 4'b0001; // ori
  //jr<=1'b0;
 end

 //r-type
 if(AluOP == 2'b10 )
 begin
    case(func)
	6'b100000 : begin alu_ctrl <= 4'b0010; /*jr<=1'b0;*/ end // ADD 
	6'b100010 : begin alu_ctrl <= 4'b0110; /*jr<=1'b0;*/end // SUB
	6'b100100 : begin alu_ctrl <= 4'b0000; /*jr<=1'b0; */ end  //AND
	6'b100101 : begin alu_ctrl <= 4'b0001; /*jr<=1'b0;*/ end //OR
	6'b101010 : begin alu_ctrl <= 4'b0111; /*jr<=1'b0;*/ end //SLT
	6'b000000 : begin alu_ctrl <= 4'b1111; /*jr<=1'b0;*/ end //SLL//we want it in Alu//alu_ctrl=4'b1111: result<=opB<<instruction[10:6];//sll
	6'b001000 : begin alu_ctrl <= 4'b1000; /*jr<=1'b1;*/ end//JR
	default begin alu_ctrl<=4'bxxxx ; /*jr<=1'bx ;*/ end 
	
	endcase
 end
 /*else
  begin
    alu_ctrl<=4'bxxxx;
    jr<=1'bx;
  end
  */
end
endmodule 

//ALU
module alu(opA, opB, alu_ctrl, result, flagzero, instructionfrom6to10);

input signed [31:0] opA;
input signed [31:0] opB;
input [3:0] alu_ctrl;
input [4:0] instructionfrom6to10;//part of big instruction bits from 10 to 6

output reg signed[31:0] result;
output flagzero; //1 if result is 0

assign flagzero = (result==0)? 1'b1:1'b0 ;//zero equals one if result=0

always @(alu_ctrl or opA or opB) 
begin
	case(alu_ctrl) 
		4'b0000: result<=opA&opB;//And
		4'b0001: result<=opA|opB;//Or
		4'b0010: result<=opA+opB;//Add
		4'b0110: result<=opA-opB;//Sub
		4'b0111: result<=opA<opB?1:0; //slt
		4'b1111: result<=opB<<instructionfrom6to10 ;//SLL
		//4'b1000: result <= 4'bzzzz; //jr (el result msh mohma f el jr)
		default: result<=32'bxxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx;
	endcase
end
endmodule

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

//////

//jr check unit
module jrcheck(Instruction0to5,AluOP,jrsignal);
input [5:0] Instruction0to5;
input [1:0] AluOP;
output jrsignal;
assign jrsignal = (Instruction0to5==6'b001000 && AluOP ==2'b10)? 1'b1 : 1'b0 ;
endmodule


//check register equality
module Equilty(read_data1,read_data2,isequal);
input [31:0] read_data1;
input [31:0] read_data2;
output isequal ;
assign isequal = (read_data1 == read_data2)? 1'b1 : 1'b0;
endmodule

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


///////////////////////////////////////////////////////

//ID_EX REGISTER

module ID_EX(holdreg,inst20to16,inst15to11,readdata1,readdata2,newpc,signe,control_signals,inst0to10,clk,
	         INST20TO16,INST15TO11,READDATA1,READDATA2,NEWPC,SIGNE,CONTROL_SIGNALS,INST0TO10);
input holdreg;
input [4:0] inst20to16,inst15to11;
input [31:0] readdata1,readdata2,newpc,signe; //newpc is pc+4 (output of adder)
input [9:0] control_signals; //RegDst 2 bit  ,AlUSrc,MemtoReg 2bit,RegWrite, Memread,Memwrite,AluOP(2bits) //memread to alusrc = 5 to 0 respectivelyd
input [10:0] inst0to10; // inst[5:0] needed by alucontrol && inst[10:6] needed by Alu to make SLL
input clk ; 
output reg [4:0] INST20TO16,INST15TO11;
output reg [31:0] READDATA1,READDATA2,NEWPC,SIGNE;
output reg [9:0] CONTROL_SIGNALS;
output reg [10:0] INST0TO10;
always @ (posedge clk)
begin

if(holdreg==0)
begin
  READDATA1 <= readdata1;
  READDATA2 <= readdata2;
  NEWPC<=newpc;
  SIGNE <= signe;
  CONTROL_SIGNALS <= control_signals;
  INST0TO10 <= inst0to10;
  INST15TO11<=inst15to11;
  INST20TO16<=inst20to16;
end
end

endmodule

////////////////////////////////////////////////////////   

//EX_MEM REGISTER



module EX_MEM(holdreg,inst20to16,inst15to11,control_signals,readdata2,aluresult,newpc,clk,
	          INST20TO16,INST15TO11,CONTROL_SIGNALS,READDATA2,ALURESULT,NEWPC);
input holdreg;
input [4:0] inst20to16,inst15to11;
input [6:0] control_signals;  //RegDst 2 bit ,MemtoReg 2bit,RegWrite, Memread,Memwrite
input [31:0] readdata2,aluresult,newpc;
input clk ;
output reg [4:0] INST20TO16,INST15TO11;
output reg [6:0] CONTROL_SIGNALS;
output reg [31:0] READDATA2,ALURESULT,NEWPC;
always @ (posedge clk)
begin
if(holdreg<=0)
begin 
    CONTROL_SIGNALS<=control_signals;
    READDATA2<= readdata2;
    ALURESULT<=aluresult;
    NEWPC<=newpc;   
    INST15TO11<=inst15to11;
    INST20TO16<=inst20to16;
 end   
end
endmodule

////////////////////////////////////////////////////
//MEM_WB REGISTER
module  MEM_WB(holdreg,inst20to16,inst15to11,readmemdata,aluresult,newpc,control_signals,clk,
	           INST20TO16,INST15TO11,READMEMDATA,ALURESULT,NEWPC,CONTROL_SIGNALS);
input holdreg;
input [4:0] inst20to16,inst15to11;
input [31:0] readmemdata,aluresult,newpc; // nextpc is the final value of Jumpaddress and branchaddress and pc+4
input [4:0] control_signals; //RegDst 2 bit ,MemtoReg 2bit,RegWrite 
input clk;
output reg [4:0] INST20TO16,INST15TO11;
output reg  [31:0] READMEMDATA,ALURESULT,NEWPC;
output reg [4:0] CONTROL_SIGNALS;
always @( posedge clk)
begin
if(holdreg<=0)
 begin 
   READMEMDATA <= readmemdata;
   ALURESULT <= aluresult;
   NEWPC<=newpc;
   CONTROL_SIGNALS<=control_signals;
   INST15TO11<=inst15to11;
    INST20TO16<=inst20to16;
  end  
end
endmodule



///////////////////////////////////

//hazard_control_unit
module hazardctrl_unit(opcode,inst25to21,inst20to16,jrsignal,writereg,stoppc,holdreg,takenewpc);
input [5:0] opcode;
input [4:0] inst25to21,inst20to16,writereg;
input jrsignal;
output reg holdreg;
output reg [1:0] takenewpc;
output reg stoppc;
reg [4:0] memreg[2:0];
reg [1:0] i;
reg [1:0] hold;
initial
begin
memreg[0]<=5'b00000;
memreg[1]<=5'b00000;
memreg[2]<=5'b00000;
i <=0;
hold<=0;
end
always@(inst25to21 or inst20to16 or writereg  or jrsignal or hold )
begin
  if(hold<0)
  begin
   //case of check Rtype with Rtype
   if(inst25to21 == memreg[0] || inst20to16 == memreg[0])
   begin
       hold <= 3;
       takenewpc<=2'b00;
       stoppc<=1;
   end

   else if(inst25to21 == memreg[1] || inst20to16 == memreg[1])
   begin
       hold <= 2;
       takenewpc<=2'b00;
       stoppc<=1;
   end

     else if(inst25to21 == memreg[2] || inst20to16 == memreg[2])
     begin
       hold <= 1;
       takenewpc<=2'b00;
       stoppc<=1;
 
      end

   end

  if(hold<0)
  begin
      //j inst
      if(opcode==6'b000010)
      begin
           hold<=1;
           takenewpc<=2'b10;
           stoppc<=1;
      end 
      
      //jal inst 
      if(opcode==6'b000010)
      begin
           hold<=3;
           takenewpc<=2'b10;
           stoppc<=1;
      end 
      
      //beq inst 
      if(opcode==6'b000100)
      begin 
           hold<=1;
           takenewpc<=2'b01;
           stoppc<=1;
      end

      //jr inst
      if(jrsignal== 1'b1)
      begin 
           hold<=1;
           takenewpc<=2'b11;
           stoppc<=1;

      end 
   end 
   if(hold>0)
   begin
        holdreg<=1'b1;
        hold <= hold - 1;
   end

   if(hold==0)
   begin
       holdreg<=1'b0;
       takenewpc<=2'b00;
       stoppc<=1'b0;

   end

   

   if(i==3)
     i<=2;
   if(i<3)
   begin
      memreg[i]<=writereg;
      i <=i+1;
   end

end
endmodule 

///
module PIPELINE_MIPS();
reg start;
reg  clk;
wire [31:0] inpc;
wire [31:0] outpc;

//start of IF stage 
//inpc is the op of the mux //momkn n7tag mux akbr ..dah 7aga mbd2ya //ctrl higy min el hazard 3'alben 
wire [31:0] Jumpaddress ,branchaddress, pcplus4;
wire [31:0]read_data1;
wire [1:0] takenewpc;
mux4_1 mux0(pcplus4,branchaddress,Jumpaddress,read_data1,inpc,takenewpc);  //ctrl = 00 mo2ktan l7d ma a3ml hazard unit
wire stoppc;
pc pcdevice(stoppc,start,inpc,outpc,clk);


adder adderdev(outpc,4,pcplus4);

wire [31:0] Instruction;
IM IMdevice(outpc,Instruction);

//end of IF stage 


wire [31:0] INST,PCPLUS4;
wire holdreg;
IF_ID IF_IDreg(holdreg,Instruction,pcplus4,INST,PCPLUS4,clk);

//start of ID stage 

wire jrsignal; //el jr signal htd5ol input lil hazard control unit
wire [4:0] write_reg;


hazardctrl_unit H(INST[31:26],INST[25:21] ,INST[20:16],jrsignal,write_reg,stoppc,holdreg,takenewpc);

wire ALUSrc, RegWrite, MemRead, MemWrite, Branch,Jump;
wire [1:0] AluOP,RegDst,MemtoReg;
reg reset;

control controldevice(INST[31:26],reset, RegDst, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, AluOP,Jump);



wire [1:0] RegDstwb;  
//we use mux 3_1 to support jal .. if the instruction is jal then w need to write back in register $ra ($31)
wire [4:0] inst20to16,inst15to11;
mux3_1_5bit mux1(inst20to16,inst15to11,5'd31,write_reg,RegDstwb);
// RegDstwb htkon gaya min wb stage

jrcheck jrcheckunit(INST[5:0],AluOP,jrsignal);

wire signed  [31:0] read_data2,write_data; 
wire RegWritewb;
regfile regfiledevice(INST[25:21],INST[20:16],write_reg,write_data,clk,read_data1,read_data2,RegWritewb);
//RegWritewb hatkon gaya min WB stage 

wire isequal;
Equilty Equiltyunit(read_data1,read_data2,isequal);

wire [27:0] sll28bitout;
Sll2_26bit sll26bitdevice(INST[25:0],sll28bitout);


assign Jumpaddress = {pcplus4[31:28],sll28bitout};

wire [31:0] signEout;
signE signEdevice(INST[15:0],signEout);

wire [31:0] sll2out;
Sll2 sll2device(signEout,sll2out);

adder adderbranch(PCPLUS4,sll2out,branchaddress);

wire [9:0] control_signals; //RegDst 2 bit  ,AlUSrc,MemtoReg 2bit,RegWrite, MemRead,Memwrite,AluOP(2bits)
assign control_signals = {RegDst,ALUSrc,MemtoReg,RegWrite,MemRead,MemWrite,AluOP};

wire [9:0] control_signals_hazardC;
assign control_signals_hazardC = (holdreg==1'b0)? control_signals : 10'b00000_00000; 

//end of ID stage 

wire [31:0] READ_DATA1,READ_DATA2,PCPLUS4EX,SIGNEOUT;
wire [9:0] CONTROL_SIGNALS;
wire [10:0] INST0TO10;
wire [4:0] INST20TO16,INST15TO11;
ID_EX ID_EXreg(holdreg,INST[20:16],INST[15:11],read_data1,read_data2,PCPLUS4,signEout,control_signals_hazardC,
	      INST[10:0],clk,INST20TO16,INST15TO11, READ_DATA1,READ_DATA2,PCPLUS4EX,SIGNEOUT,CONTROL_SIGNALS,INST0TO10);


//start of EX stage 

wire [3:0] alu_ctrl;
Alu_ctrl Alu_ctrlunit(CONTROL_SIGNALS[1:0],INST0TO10[5:0],alu_ctrl); //CONTROL_SIGNALS[1:0] is AluOP

wire [31:0] ip2alu;
mux mux2(READ_DATA2,SIGNEOUT,ip2alu,CONTROL_SIGNALS[7]);  //CONTROL_SIGNALS[7] is AlUSrc

wire signed [31:0] aluresult;
wire flagzero;
alu aludevice(READ_DATA1,ip2alu,alu_ctrl,aluresult,flagzero,INST0TO10[10:6]);

//end of Ex stage 

wire [6:0] control_signalsEx ;  //RegDst 2 bit ,MemtoReg 2bit,RegWrite, Memread,Memwrite
assign control_signalsEx = {CONTROL_SIGNALS[9:8],CONTROL_SIGNALS[6:5],CONTROL_SIGNALS[4:2]};

wire [31:0] READ_DATA2MEM,ALURESULT,PCPLUS4MEM;
wire [6:0] CONTROL_SIGNALSMEM;
wire [4:0] INST20TO16MEM,INST15TO11MEM;
EX_MEM EX_MEMreg(holdreg, INST20TO16,INST15TO11,control_signalsEx,READ_DATA2,aluresult,PCPLUS4EX,clk,
	             INST20TO16MEM,INST15TO11MEM,CONTROL_SIGNALSMEM,READ_DATA2MEM,ALURESULT,PCPLUS4MEM);

//start of mem stage

wire [31:0] read_memorydata;
data_memory data_memorydevice(ALURESULT,READ_DATA2MEM,CONTROL_SIGNALSMEM[0],CONTROL_SIGNALSMEM[1],
	                           clk,read_memorydata);

//end of mem stage 

wire [4:0] control_signalsMem; //RegDst 2 bit ,MemtoReg 2bit,RegWrite 
assign control_signalsMem = CONTROL_SIGNALSMEM[6:2];

wire [31:0] READMEMORYDATA,ALURESULTWB,PCPLUS4WB;
wire [4:0] CONTROL_SIGNALSWB;
wire [4:0] INST20TO16WB,INST15TO11WB;
 MEM_WB MEM_WBreg(holdreg,INST20TO16MEM,INST15TO11MEM,read_memorydata,ALURESULT,PCPLUS4MEM,control_signalsMem,clk,
 	              INST20TO16WB,INST15TO11WB,READMEMORYDATA,ALURESULTWB,PCPLUS4WB,CONTROL_SIGNALSWB);

//start of WB stage 

//we use mux 3_1 to support jal inst bec for jal w need to write back the pcplus4 in reg  $ra.
mux3_1 mux3(ALURESULTWB,READMEMORYDATA,PCPLUS4WB,write_data,CONTROL_SIGNALSWB[2:1]);

assign RegWritewb = CONTROL_SIGNALSWB[0];
assign RegDstwb = CONTROL_SIGNALSWB[4:3];
assign inst20to16 = INST20TO16WB;
assign inst15to11 = INST15TO11WB;


initial
begin
/* $monitor("%d %d  %d  %d %d %d %d %d %d %d %d %d  %d %b %d ",$time ,outpc,inpc,pcplus4,INST[25:21]
	,INST[20:16],read_data1,read_data2,ip2alu,MemWrite,aluresult,write_reg,write_data,RegDstwb,RegWritewb); 
*/
clk<=0;
#4
start<=1;
#28
start<=0;
#48 
start<=0;
end
always
begin
#3
clk=~clk;
end

endmodule

