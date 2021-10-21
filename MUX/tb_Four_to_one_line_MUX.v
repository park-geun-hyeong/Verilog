`timescale 1ns/1ps

module tb_mux;

reg in_0,in_1,in_2,in_3;
reg [1:0]select;
wire m_out;

mux_4x1_beh m(.m_out(m_out), .in_0(in_0), .in_1(in_1), .in_2(in_2), .in_3(in_3), .select(select));

initial begin
   #10 select=2'b00;in_0=1;in_1=0;in_2=0;in_3=0;
   #10 select=2'b01;in_0=0;in_1=1;in_2=0;in_3=0;
   #10 select=2'b10;in_0=0;in_1=0;in_2=1;in_3=0;
   #10 select=2'b11;in_0=0;in_1=0;in_2=0;in_3=1;
   #10 $stop;

end
endmodule
