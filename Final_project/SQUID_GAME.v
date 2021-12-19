module SQUID_GAME(
	input clk, rst,
	input [3:0] key_pad_row,
	output [2:0] key_pad_col,
	output [13:0] dot_row,
	output [9:0] dot_col,
	output reg [3:0] step_motor,
	output reg piezo_freq,
	output reg [7:0] seg_data, seg_com,
	output lcd_en, lcd_rs, lcd_rw,
	output [7:0] lcd_data,
	output reg [15:0] led
);
	
	wire reset;
	wire [11:0] key;
	assign reset = rst;
	wire clk_1k, clk_1s, clk_10hz, clk_10khz, clk_5hz, clk_500khz, clk_800hz, clk_625hz, clk_7hz, dot_game_over, game_success, timeover;
	wire [9:0] piezo_cnt;
	
	clk_div u1(.reset(reset), .clk_25M(clk), .clk_1k(clk_1k), .clk_1s(clk_1s), .clk_10hz(clk_10hz), .clk_10khz(clk_10khz), .clk_5hz(clk_5hz), .clk_500khz(clk_500khz), .clk_800hz(clk_800hz), .clk_625hz(clk_625hz), .clk_7hz(clk_7hz));
	
	dot_matrix u2(.clk(clk_10khz), .clk_1s(clk_5hz), .reset(reset), .dot_row(dot_row), .dot_col(dot_col), .key(key), .piezo_cnt(piezo_cnt), .dot_game_over(dot_game_over), .game_success(game_success), .timeover(timeover));
	
	key_pad u3(.clk(clk), .rst(reset), .key_col(key_pad_col), .key_row(key_pad_row), .key_data(key));
	
	step_motor u4(.reset(reset), .clk_625hz(clk_625hz), .piezo_cnt(piezo_cnt), .step_motor(step_motor), .dot_game_over(dot_game_over), .timeover(timeover));
	
	piezo u5(.clk(clk_500khz), .rst(rst), .clk2(clk_10hz), .clk3(clk_7hz), .piezo_freq(piezo_freq), .piezo_cnt(piezo_cnt), .dot_game_over(dot_game_over),.game_success(game_success), .timeover(timeover));
	
	seven_segment u6(.clk_1k(clk_1k), .clk_1s(clk_1s), .reset(reset), .success(game_success), .seg_data(seg_data), .seg_com(seg_com), .timeover(timeover), .dot_game_over(dot_game_over));
	
	lcd u7( .clk_1k(clk_1k), .reset(reset), .dot_game_over(dot_game_over), .game_success(game_success), .lcd_en(lcd_en), .lcd_rs(lcd_rs), .lcd_rw(lcd_rw), .lcd_data(lcd_data), .timeover(timeover));
	
	led u8(.clk(clk_1k), .reset(reset), .piezo_cnt(piezo_cnt), .led(led), .timeover(timeover), .dot_game_over(dot_game_over), .game_success(game_success));

endmodule

