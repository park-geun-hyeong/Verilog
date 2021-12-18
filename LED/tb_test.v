`timescale 1ns/1ns

module tb_test;

reg clk, rst;
wire [15:0] led;

test uut(clk,rst,led);

initial begin
	clk = 1;
	rst = 0; #30;
	rst = 1;
end

always #20 clk = ~clk;

endmodule
