module step_motor(
	input reset, clk_625hz,dot_game_over,timeover,
	input [9:0] piezo_cnt,
	output reg [3:0] step_motor
	
);

reg [7:0] count;

always@(posedge reset or posedge clk_625hz or posedge dot_game_over or posedge timeover)begin


	if(reset == 1'b1 | dot_game_over == 1'b1 | timeover == 1'b1) begin
		step_motor <= 0;
		count <= 0;
	end
	else begin

		if (piezo_cnt == 10'b0 ) begin
			step_motor <= 0 ;
		end
		else begin
			case(count)
				0  : begin step_motor <= 4'b1000; count <= 1;  end
				1  : begin step_motor <= 4'b1100; count <= 2;  end
				2  : begin step_motor <= 4'b0100; count <= 3;  end
				3  : begin step_motor <= 4'b0110; count <= 4;  end
				4  : begin step_motor <= 4'b0010; count <= 5;  end
				5  : begin step_motor <= 4'b0011; count <= 6;  end
				6  : begin step_motor <= 4'b0001; count <= 7;  end
				7  : begin step_motor <= 4'b1001; count <= 0;  end
			endcase
		end
	end
end

endmodule
