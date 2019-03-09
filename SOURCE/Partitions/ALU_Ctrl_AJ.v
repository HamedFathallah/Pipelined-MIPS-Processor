
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
  6'b100000 : begin alu_ctrl <= 4'b0010;  end // ADD 
  6'b100010 : begin alu_ctrl <= 4'b0110; end // SUB
  6'b100100 : begin alu_ctrl <= 4'b0000;  end  //AND
  6'b100101 : begin alu_ctrl <= 4'b0001;  end //OR
  6'b101010 : begin alu_ctrl <= 4'b0111;  end //SLT
  6'b000000 : begin alu_ctrl <= 4'b1111;  end //SLL//we want it in Alu//alu_ctrl=4'b1111: result<=opB<<instruction[10:6];//sll
  6'b001000 : begin alu_ctrl <= 4'b1000;  end//JR
  default begin alu_ctrl<=4'bxxxx ;  end 
  
  endcase
 end
end
endmodule 