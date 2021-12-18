module test(
	input clk, rst,
	output [7:0] seg_data, seg_com

);

	wire reset;
	assign reset = rst;
	wire clk_1k, clk_1s;

	clk_div u1(.clk_25M(clk), .reset(rst), .clk_1k(clk_1k), .clk_1s(clk_1s));
	segment_clock u3(.clk(clk_1s), .clk_1k(clk_1k), .reset(reset), .seg_data(seg_data), .seg_com(seg_com));
	

endmodule
