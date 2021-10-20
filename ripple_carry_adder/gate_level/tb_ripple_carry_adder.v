`timescale 1ns/1ps 

module ripple_carry_adder_tb;
   reg [7:0]A;
   reg [7:0]B;
   reg Cin;
   wire [7:0]S;
   wire Cout;
   
   ripple_carry_8_bit_adder M1(.S(S),.Cout(Cout),.A(A),.B(B),.Cin(Cin));
   initial begin
      #10 A=8'b00000001;B=8'b00000001;Cin=1'b0;
      #10 A=8'b00000001;B=8'b00000001;Cin=1'b1;
      #10 A=8'b00000010;B=8'b00000011;Cin=1'b0;
      #10 A=8'b10000001;B=8'b10000001;Cin=1'b0;
      #10 A=8'b00011001;B=8'b00110001;Cin=1'b0;
      #10 A=8'b00000011;B=8'b00000011;Cin=1'b1;
      #10 A=8'b11111111;B=8'b00000001;Cin=1'b0;
      #10 A=8'b11111111;B=8'b00000000;Cin=1'b1;
      #10 A=8'b11111111;B=8'b11111111;Cin=1'b0;
      #10 $stop;
   end
endmodule
