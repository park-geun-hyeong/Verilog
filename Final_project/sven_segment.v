module seven_segment(
	input clk, clk_1k, clk_1s, reset, success, dot_game_over,
	output reg [7:0] seg_data, seg_com,
	output reg timeover
);
	reg carry_down;
	reg [3:0] c_1, c_2, c_3, c_4, c_5, c_6, c_7, c_8;
	reg [2:0] sel_count;

	always@(posedge clk_1k or posedge reset) begin
		if(reset==1'b1) begin
			seg_com <= 0; sel_count <= 3'd0;
			end
		else begin
			sel_count <= sel_count+1;
			case(sel_count)
				3'b000 : seg_com <= 8'b1111_1110;
				3'b001 : seg_com <= 8'b1111_1101;
				3'b010 : seg_com <= 8'b1111_1011;
				3'b011 : seg_com <= 8'b1111_0111;
				3'b100 : seg_com <= 8'b1110_1111;
				3'b101 : seg_com <= 8'b1101_1111;
				3'b110 : seg_com <= 8'b1011_1111;
				3'b111 : seg_com <= 8'b0111_1111;
				default : seg_com <= 0;
			endcase
		end
	end

wire [7:0] seg_data_1, seg_data_2, seg_data_3, seg_data_4, seg_data_5, seg_data_6, seg_data_7, seg_data_8; 

segment_decode seg7(.clk(clk_1k), .reset(reset), .data(c_8), .seg_data(seg_data_8));
segment_decode seg6(.clk(clk_1k), .reset(reset), .data(c_7), .seg_data(seg_data_7));
segment_decode seg5(.clk(clk_1k), .reset(reset), .data(c_6), .seg_data(seg_data_6));
segment_decode seg4(.clk(clk_1k), .reset(reset), .data(c_5), .seg_data(seg_data_5));
segment_decode seg3(.clk(clk_1k), .reset(reset), .data(c_4), .seg_data(seg_data_4));
segment_decode seg2(.clk(clk_1k), .reset(reset), .data(c_3), .seg_data(seg_data_3));
segment_decode seg1(.clk(clk_1k), .reset(reset), .data(c_2), .seg_data(seg_data_2));
segment_decode seg0(.clk(clk_1k), .reset(reset), .data(c_1), .seg_data(seg_data_1));

always@(posedge clk_1k or posedge reset) begin
	if(reset==1'b1) begin
		seg_data <= 8'd0;
	end
	else begin
		case(sel_count)
			3'b000 : seg_data <= seg_data_1;
			3'b001 : seg_data <= seg_data_2;
			3'b010 : seg_data <= seg_data_3;
			3'b011 : seg_data <= seg_data_4;
			3'b100 : seg_data <= seg_data_5;
			3'b101 : seg_data <= seg_data_6;
			3'b110 : seg_data <= seg_data_7;
			3'b111 : seg_data <= seg_data_8;
			default : seg_data <= seg_data;
		endcase
	end
end

always@(posedge clk_1s or posedge reset) begin
	if(reset == 1'b1) begin
		c_1 <= 9; c_3 <= 11; c_4 <= 11; c_5 <= 11; c_6 <= 11; c_7 <= 11; c_8 <= 11;
		carry_down <= 0;
	end
	else begin
		if(timeover == 1'b1 | success == 1'b1 | dot_game_over == 1'b1)begin
		c_1 <= 10; c_3 <= 10; c_4 <= 10; c_5 <= 10; c_6 <= 10; c_7 <= 10; c_8 <= 10;
		end
		else begin
		if(c_1 <= 0) begin
			c_1 <= 9;
			carry_down <= carry_down+1;
		end
		else begin
			c_1 <= c_1-1;
			carry_down <= 0;
		end
		end
	end
end

always@(posedge carry_down or posedge reset or posedge timeover or posedge success or posedge dot_game_over) begin
	if(reset == 1'b1) begin
		c_2 <= 9;
		timeover <= 1'b0;
	end
	else begin
		if(timeover == 1'b1 | success == 1'b1 | dot_game_over == 1'b1) begin
		c_2 <= 10;
		end
		else begin
			if(c_2 == 0 && c_1 == 0)begin
			timeover <= 1'b1;
			end
			else begin
			c_2 <= c_2-1;
			end
		end
	end
end

endmodule
