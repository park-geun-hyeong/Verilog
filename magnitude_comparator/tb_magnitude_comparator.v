`timescale 1ns/1ps

module tb_magnitude_cmparator;

reg [3:0]A;
reg [3:0]B;
wire A_it_B;
wire A_eq_B;
wire A_gt_B;

mag_compare m(.A_it_B(A_it_B), .A_eq_B(A_eq_B), .A_gt_B(A_gt_B), .A(A), .B(B));

initial begin
   #10 A=4'b0001;B=4'b0001;
   #10 A=4'b0000;B=4'b0001;
   #10 A=4'b0001;B=4'b0000;
   #10 $stop;

end
endmodule
