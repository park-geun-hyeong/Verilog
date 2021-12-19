module led(
	input clk, reset, timeover, dot_game_over, game_success,
	input [9:0] piezo_cnt,
	output reg [15:0] led
);

always@(posedge clk or posedge reset)begin
	if(reset) begin
		led <= 16'b0000_0000_0000_0000;
	end
	
	else begin
		if(piezo_cnt == 0) begin
		 led <= 16'b1111_1111_0000_0000;
		end
		else begin
			if((timeover == 1) | (dot_game_over == 1) | (game_success == 1))
				led <= 16'b0000_0000_0000_0000;
			else
		 		led <= 16'b0000_0000_1111_1111;
		end	
	end

end

endmodule

