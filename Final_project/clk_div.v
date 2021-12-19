module clk_div(
	input clk_25M, reset,
	output reg clk_1k, clk_1s, clk_10hz, clk_10khz, clk_5hz, clk_500khz, clk_800hz, clk_625hz, clk_7hz
);

reg [14:0]	cnt_1k = 0;
reg [24:0]	cnt_1s = 0;
reg [20:0]	cnt_10hz = 0;
reg [10:0]	cnt_10khz = 0;
reg [23:0]	cnt_5hz = 0;
reg [5:0]	cnt_500khz = 0;
reg [16:0]  cnt_800hz = 0;
reg [16:0]  cnt_625hz = 0;
reg	[21:0]	cnt_7hz = 0;


always @(posedge clk_25M or posedge reset) begin
		
		if(reset == 1'b1) begin
			clk_1k <= 1;
			clk_1s <= 1;
			clk_10hz <= 1;
			clk_5hz <= 1;
			clk_10khz <= 1;
			clk_500khz <= 1; 
			clk_800hz <= 1;
			clk_625hz <= 1;
			clk_7hz <=1;
			cnt_1k <= 0; cnt_1s <= 0; cnt_10hz <= 0; cnt_10khz <= 0; cnt_5hz <= 0; cnt_500khz <= 0; cnt_800hz <= 0; cnt_625hz <= 0; cnt_7hz <= 0;
		end
		
		else begin
			//1KHz
			if(cnt_1k >= 15'd12499)
				begin
					clk_1k <= ~clk_1k;
					cnt_1k <= 0;
			end
			else cnt_1k <= cnt_1k + 1'b1;
			
			
			//1Hz
			if(cnt_1s >= 25'd12499999)
				begin
					clk_1s <= ~clk_1s;
					cnt_1s <= 0;
			end
			else cnt_1s <= cnt_1s + 1'b1;
			
			//10Hz
			if(cnt_10hz >= 21'd1249999)
				begin
					clk_10hz <= ~clk_10hz;
					cnt_10hz <= 0;
			end
			else cnt_10hz <= cnt_10hz + 1'b1;
			
			//10kHz
			if(cnt_10khz >= 11'd12499)
				begin
					clk_10khz <= ~clk_10khz;
					cnt_10khz <= 0;
			end
			else cnt_10khz <= cnt_10khz + 1'b1;
			
			//5hz
			if(cnt_5hz >= 24'd6249999)
				begin
					clk_5hz <= ~clk_5hz;
					cnt_5hz <= 0;
			end
			else cnt_5hz <= cnt_5hz + 1'b1;
			
			//500khz
			if(cnt_500khz >= 6'd49)
				begin
					clk_500khz <= ~clk_500khz;
					cnt_500khz <= 0;
			end

			else cnt_500khz <= cnt_500khz + 1'b1;
			
			//800Hz
			if(cnt_800hz >= 17'd15624)
				begin
					clk_800hz <= ~clk_800hz;
					cnt_800hz <= 0;
			end
			else cnt_800hz <= cnt_800hz + 1'b1;
			
			//625Hz
			if(cnt_625hz >= 17'd19999)
				begin
					clk_625hz <= ~clk_625hz;
					cnt_625hz <= 0;
			end
			else cnt_625hz <= cnt_625hz + 1'b1;
			
			if(cnt_7hz >= 22'd1874999)
				begin
					clk_7hz <= ~clk_7hz;
					cnt_7hz <= 0;
			end
			else cnt_7hz <= cnt_7hz + 1'b1;
		end
	end
endmodule
			
			
			
