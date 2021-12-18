module clk_div(
	input clk_25M, reset,
	output reg clk_1k, clk_1s
);

reg [14:0] cnt_1k = 0;
reg [24:0] cnt_1s = 0;

always @(posedge clk_25M or negedge reset) begin
	if(~reset) begin
		clk_1k <= 1;
		clk_1s <= 1;
		cnt_1k <= 0;
		cnt_1s <= 0;
	end
	
	else begin
		
		// 25MHZ clock 25000개 동안 1k 한주기 생성 
		if(cnt_1k >= 15'd12499)
			begin
				clk_1k <= ~clk_1k;
				cnt_1k <= 0;
		
		end
		else cnt_1k <= cnt_1k + 1'b1;
		
		// 25MHZ clock 25M개 동안 clk_1s 한주기 생
		if(cnt_1s >= 25'd12499999)
			begin
				clk_1s <= ~clk_1s;
				cnt_1s <= 0;
		end
		else cnt_1s <= cnt_1s + 1'b1;
	end
end
endmodule
