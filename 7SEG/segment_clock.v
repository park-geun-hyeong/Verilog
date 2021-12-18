module segment_clock(
	input clk, clk_1k, reset,
	output reg[7:0] seg_data, seg_com
);

reg carry_1s, carry_10s, carry_1m, carry_10m, carry_1h, carry_10h, carry_1d;
reg [3:0] c_1s, c_1m, c_1h, c_1d;
reg [3:0] c_10s, c_10m, c_10h, c_10d;
reg [2:0] sel_count;

always@(posedge clk_1k or negedge reset)begin
	
	if(~reset)begin
		seg_com<=0;
		sel_count<=3'd0;
	end
	else begin
		sel_count <= sel_count + 1;
		case(sel_count)
			3'b000 : seg_com<=8'b1111_1110;
			3'b001 : seg_com<=8'b1111_1101;
			3'b010 : seg_com<=8'b1111_1011;
			3'b011 : seg_com<=8'b1111_0111;
			3'b100 : seg_com<=8'b1110_1111;
			3'b101 : seg_com<=8'b1101_1101;
			3'b110 : seg_com<=8'b0111_1111;
			3'b111 : seg_com<=8'b0111_1101;
			default: seg_com<=0;
		endcase
	end			
end

wire [7:0] seg_data_0, seg_data_1, seg_data_2, seg_data_3, seg_data_4, seg_data_5, seg_data_6, seg_data_7;

segment_decode seg7(.clk(clk_1k), .reset(reset), .data(c_10d), .seg_data(seg_data_7));
segment_decode seg6(.clk(clk_1k), .reset(reset), .data(c_1d),  .seg_data(seg_data_6));
segment_decode seg5(.clk(clk_1k), .reset(reset), .data(c_10h), .seg_data(seg_data_5));
segment_decode seg4(.clk(clk_1k), .reset(reset), .data(c_1h),  .seg_data(seg_data_4));
segment_decode seg3(.clk(clk_1k), .reset(reset), .data(c_10m), .seg_data(seg_data_3));
segment_decode seg2(.clk(clk_1k), .reset(reset), .data(c_1m),  .seg_data(seg_data_2));
segment_decode seg1(.clk(clk_1k), .reset(reset), .data(c_10s), .seg_data(seg_data_1));
segment_decode seg0(.clk(clk_1k), .reset(reset), .data(c_1s),  .seg_data(seg_data_0));


always@(posedge clk_1k or negedge reset) begin
	if(~reset)begin
		seg_data<=8'd0;
	end
	else begin
		case(sel_count)
			3'b000 : seg_data <=seg_data_0;
			3'b001 : seg_data <=seg_data_1;
			3'b010 : seg_data <=seg_data_2;
			3'b011 : seg_data <=seg_data_3;
			3'b100 : seg_data <=seg_data_4;
			3'b101 : seg_data <=seg_data_5;
			3'b110 : seg_data <=seg_data_6;
			3'b111 : seg_data <=seg_data_7;	
		endcase
	end
end

always@(posedge clk_1k or negedge reset) begin
	if(~reset)begin
		c_1s <=0;
		carry_1s<=0;
	end
	else begin
		if(c_1s >=9) begin
			c_1s <=0;
			carry_1s <= carry_1s + 1;
		end	
		else begin
			c_1s <= c_1s + 1;
			carry_1s <= 0;
		end
	end
end

always@(posedge carry_1s or negedge reset) begin
	
	if(~reset)begin
		c_10s <= 0;
		carry_10s <= 0;
	
	end
	else begin 
		if(c_10s >=5) begin
			c_10s <= 0;
			carry_10s <= carry_10s + 1;
		end
		else begin
			c_10s <= c_10s + 1;
			carry_10s <=0;
		end
	end	
end


always@(posedge clk_1k or negedge reset) begin
	if(~reset)begin
		c_1m <=0;
		carry_1m<=0;
	end
	else begin
		if(c_1m >=9) begin
			c_1m <=0;
			carry_1m <= carry_1m + 1;
		end	
		else begin
			c_1m <= c_1m + 1;
			carry_1m <= 0;
		end
	end
end

always@(posedge carry_1m or negedge reset) begin
	
	if(~reset)begin
		c_10m <= 0;
		carry_10m <= 0;
	
	end
	else begin 
		if(c_10m >=5) begin
			c_10m <= 0;
			carry_10m <= carry_10m + 1;
		end
		else begin
			c_10m <= c_10m + 1;
			carry_10m <=0;
		end
	end	
end


always@(posedge clk_1k or negedge reset) begin
	if(~reset)begin
		c_1h <=0;
		carry_1h<=0;
	end
	else begin
		if(c_1h >=9) begin
			c_1h <=0;
			carry_1h <= carry_1h + 1;
		end	
		else begin
			c_1h <= c_1h + 1;
			carry_1h <= 0;
		end
	end
end

always@(posedge carry_1h or negedge reset) begin
	
	if(~reset)begin
		c_10h <= 0;
		carry_10h <= 0;
	
	end
	else begin 
		if(c_10h >=5) begin
			c_10h <= 0;
			carry_10h <= carry_10h + 1;
		end
		else begin
			c_10h <= c_10h + 1;
			carry_10h <=0;
		end
	end	
end

always@(posedge clk_1k or negedge reset) begin
	if(~reset)begin
		c_1d <=0;
		carry_1d<=0;
	end
	else begin
		if(c_1d >=9) begin
			c_1d <=0;
			carry_1d <= carry_1d + 1;
		end	
		else begin
			c_1d <= c_1d + 1;
			carry_1d <= 0;
		end
	end
end

always@(posedge carry_1d or negedge reset) begin
	
	if(~reset)begin
		c_10d <= 0;

	end
	else begin 
		if(c_10d >=5) begin
			c_10d <= 0;
		end
		else begin
			c_10d <= c_10d + 1;
		end
	end	
end

endmodule
