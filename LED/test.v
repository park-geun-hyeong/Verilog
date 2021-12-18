module test(
	input clk, rst,
	output [15:0] led
);

	wire reset;
	assign reset = rst;
	
	wire clk_1k, clk_1s;

	clk_div u1(.clk_25M(clk), .reset(reset), .clk_1k(clk_1k), .clk_1s(clk_1s));
	
	led_sw u3(.clk(clk), .clk_1k(clk_1k), .reset(reset), .led(led));

endmodule
