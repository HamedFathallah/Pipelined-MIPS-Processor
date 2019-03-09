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