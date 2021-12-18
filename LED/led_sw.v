module led_sw(
	input clk, clk_1k, reset,
	output reg[15:0] led
);

reg [3:0] count;
reg [9:0] c;

always@(posedge clk_1k or negedge reset) begin
	if(~reset) begin
		c<=0; 
		count<=0;
	end
	else begin
		if(c>=499) begin
			count <= count + 1;
			c <= 0;
		end
		else begin
			c <= c+1;
		end
	end
end

always@(posedge clk_1k or negedge reset) begin
	if(~reset) begin
		led <= 16'b0000_0000_0000_0000;
	end
	else begin
		case(count)
		0 : led <= 16'b0000_0000_0000_0001;
		1 : led <= 16'b0000_0000_0000_0010;
		2 : led <= 16'b0000_0000_0000_0100;
		3 : led <= 16'b0000_0000_0000_1000;
		4 : led <= 16'b0000_0000_0001_0000;
		5 : led <= 16'b0000_0000_0010_0000;
		6 : led <= 16'b0000_0000_0100_0000;
		7 : led <= 16'b0000_0000_1000_0000;
		8 : led <= 16'b0000_0001_0000_0000;
		9 : led <= 16'b0000_0010_0000_0000;
		10 : led <= 16'b0000_0100_0000_0000;
		11 : led <= 16'b0000_1000_0000_0000;
		12 : led <= 16'b0001_0000_0000_0000;
		13 : led <= 16'b0010_0000_0000_0000;
		14 : led <= 16'b0100_0000_0000_0000;
		15 : led <= 16'b1000_0000_0000_0000;
		default : led<=16'b0000_0000_0000_0000;
		endcase
	end		
end
endmodule
