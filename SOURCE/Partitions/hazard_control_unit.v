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