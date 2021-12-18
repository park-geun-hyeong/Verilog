`timescale 1ns/1ns

module tb_test;
reg clk, rst;
wire[7:0] seg_data, seg_com;
test uur(clk, rst, seg_data, seg_com);

initial begin
	clk =1;
	rst =0; #30;
	rst =1; 
end

always #20 clk = ~clk;

endmodule
