module dot_matrix(
	input clk, reset, clk_1s,
	input [11:0] key,
	input timeover,
	input [9:0] piezo_cnt,
	output reg [13:0] dot_row,
	output reg [9:0] dot_col,
	output reg dot_game_over,
	output reg game_success
);

	reg [3:0] sel_count;
	reg [3:0] count;
	reg [13:0] map_data[9:0];
	reg [13:0] player_data[9:0];
	reg [3:0] row;
	reg [3:0] col;
	
	


always@(posedge clk or posedge reset) begin
	if(reset == 1'b1) begin
		dot_col <= 0;
		sel_count <= 0;
	end
	else begin
		if(sel_count >= 9)
			sel_count <= 0;
		else
			sel_count <= sel_count + 1;
		
		case(sel_count)
			4'd0 : dot_col <= 10'b10_0000_0000;
			4'd1 : dot_col <= 10'b01_0000_0000;
			4'd2 : dot_col <= 10'b00_1000_0000;
			4'd3 : dot_col <= 10'b00_0100_0000;
			4'd4 : dot_col <= 10'b00_0010_0000;
			4'd5 : dot_col <= 10'b00_0001_0000;
			4'd6 : dot_col <= 10'b00_0000_1000;
			4'd7 : dot_col <= 10'b00_0000_0100;
			4'd8 : dot_col <= 10'b00_0000_0010;
			4'd9 : dot_col <= 10'b00_0000_0001;
			default : dot_col <= 0;
		endcase
	end
end



integer i;
always@(posedge clk_1s or posedge reset) begin
	if(reset == 1'b1) begin
		player_data[9] <= 14'b00_0000_0000_0000;
		player_data[8] <= 14'b00_0000_0000_0000;
		player_data[7] <= 14'b00_0000_0000_0000;
		player_data[6] <= 14'b00_0000_0000_0000;
		player_data[5] <= 14'b00_0000_0000_0000;
		player_data[4] <= 14'b00_0000_0000_0000;
		player_data[3] <= 14'b00_0000_0000_0000;
		player_data[2] <= 14'b00_0000_0000_0000;
		player_data[1] <= 14'b00_0000_0000_0000;
		player_data[0] <= 14'b00_0000_0000_0000;

		map_data[9] <= 14'b00_0000_0000_0000;
        map_data[8] <= 14'b00_0000_0000_0000;
      	map_data[7] <= 14'b00_0000_0000_0000;
      	map_data[6] <= 14'b00_0000_0000_0000;
      	map_data[5] <= 14'b00_0000_0000_0000;
      	map_data[4] <= 14'b00_0000_0000_0000;
      	map_data[3] <= 14'b00_0000_0000_0000;
      	map_data[2] <= 14'b00_0000_0000_0000;
      	map_data[1] <= 14'b00_0000_0000_0000;
     	map_data[0] <= 14'b00_0000_0000_0000;
		row <= 4'd0;
		col <= 4'd0;
		dot_game_over <= 0;
		game_success <= 0;
	end
	else begin
			player_data[0] <= 14'b10_0000_0000_0000;
			player_data[1] <= 14'b00_0000_0000_0000;
			player_data[2] <= 14'b00_0000_0000_0000;
			player_data[3] <= 14'b00_0000_0000_0000;
			player_data[4] <= 14'b00_0000_0000_0000;
			player_data[5] <= 14'b00_0000_0000_0000;
			player_data[6] <= 14'b00_0000_0000_0000;
			player_data[7] <= 14'b00_0000_0000_0000;
			player_data[8] <= 14'b00_0000_0000_0000;
			player_data[9] <= 14'b00_0000_0000_0000;

			map_data[9] <= 14'b00_0000_0111_0000;
       		map_data[8] <= 14'b00_0000_0111_0000;
      		map_data[7] <= 14'b00_1110_0111_0011;
      		map_data[6] <= 14'b00_1110_0111_0011;
      		map_data[5] <= 14'b00_1110_0111_0011;
      		map_data[4] <= 14'b00_1110_0111_0011;
      		map_data[3] <= 14'b00_1110_0000_0011;
      		map_data[2] <= 14'b00_1110_0000_0011;
      		map_data[1] <= 14'b00_1111_1111_1111;
     		map_data[0] <= 14'b00_1111_1111_1111;
			if(piezo_cnt == 0) begin
				if(key != 0) begin
					dot_game_over <= 1;
				end
			end
			
			else begin
			
				
				if(key[1] == 1) begin
					if(row != 4'd13)
						row <= row + 4'd1;
					else
						row <= 4'd13;
				end
			
				else if(key[7] == 1) begin
					if(row != 4'd0)
						row <= row - 4'd1;
					else
						row <= 4'd0;
				end
			
				else if(key[3] == 1) begin
					if(col != 4'd9)
						col <= col + 4'd1;
					else
						col <= 4'd9;
				end
			
				else if(key[5] == 1) begin
					if(col != 4'd0)
						col <= col - 4'd1;
					else
						col <= 4'd0;
				end
				
			end	
			
		
			for(i = 0; i < 10; i=i+1) 
				player_data[i] <= 14'b00_0000_0000_0000;
		
			player_data[col] <= 14'b10_0000_0000_0000 >> row;
			
			if(((player_data[col]&map_data[col]) == player_data[col])&(player_data[col] != 0)) begin
				dot_game_over <= 1;
			end	
			
			else if(player_data[9] == 14'b00_0000_0000_0001 | player_data[8] == 14'b00_0000_0000_0001) begin
				game_success <= 1;
			end
	end
end

always@(posedge clk or posedge reset) begin
	if(reset == 1'b1) begin
		dot_row <= 0;
	end
	else begin
		if(game_success == 1) begin
			case(sel_count)
				4'd0 : dot_row <= 14'b00_0111_1111_1000;
				4'd1 : dot_row <= 14'b00_1111_1111_1100;
				4'd2 : dot_row <= 14'b01_1000_0000_0110;
				4'd3 : dot_row <= 14'b11_0000_0000_0011;
				4'd4 : dot_row <= 14'b11_0000_0000_0011;
				4'd5 : dot_row <= 14'b11_0000_0000_0011;
				4'd6 : dot_row <= 14'b11_0000_0000_0011;
				4'd7 : dot_row <= 14'b01_1000_0000_0110;
				4'd8 : dot_row <= 14'b00_1111_1111_1100;
				4'd9 : dot_row <= 14'b00_0111_1111_1000;
				default : dot_row <= 0;
			endcase
			
		end
		else if(player_data[col] == 0) begin
			case(sel_count)
				4'd0 : dot_row <= (map_data[0]);
				4'd1 : dot_row <= (map_data[1]);
				4'd2 : dot_row <= (map_data[2]);
				4'd3 : dot_row <= (map_data[3]);
				4'd4 : dot_row <= (map_data[4]);
				4'd5 : dot_row <= (map_data[5]);
				4'd6 : dot_row <= (map_data[6]);
				4'd7 : dot_row <= (map_data[7]);
				4'd8 : dot_row <= (map_data[8]);
				4'd9 : dot_row <= (map_data[9]);
				default : dot_row <= 0;
			endcase
		end
		
		else if((dot_game_over == 1)|(timeover == 1)) begin
			case(sel_count)
				4'd0 : dot_row <= 14'b11_0000_0000_0011;
				4'd1 : dot_row <= 14'b11_1100_0000_1111;
				4'd2 : dot_row <= 14'b01_1111_0011_1110;
				4'd3 : dot_row <= 14'b00_1111_1111_1100;
				4'd4 : dot_row <= 14'b00_0011_1111_0000;
				4'd5 : dot_row <= 14'b00_0011_1111_0000;
				4'd6 : dot_row <= 14'b00_1111_1111_1100;
				4'd7 : dot_row <= 14'b01_1111_0011_1110;
				4'd8 : dot_row <= 14'b11_1100_0000_1111;
				4'd9 : dot_row <= 14'b11_0000_0000_0011;
				default : dot_row <= 0;
			endcase
		end
		
		else begin
			case(sel_count)
				4'd0 : dot_row <= (player_data[0]|map_data[0]);
				4'd1 : dot_row <= (player_data[1]|map_data[1]);
				4'd2 : dot_row <= (player_data[2]|map_data[2]);
				4'd3 : dot_row <= (player_data[3]|map_data[3]);
				4'd4 : dot_row <= (player_data[4]|map_data[4]);
				4'd5 : dot_row <= (player_data[5]|map_data[5]);
				4'd6 : dot_row <= (player_data[6]|map_data[6]);
				4'd7 : dot_row <= (player_data[7]|map_data[7]);
				4'd8 : dot_row <= (player_data[8]|map_data[8]);
				4'd9 : dot_row <= (player_data[9]|map_data[9]);
				default : dot_row <= 0;
			endcase
		end
	end
end

endmodule
