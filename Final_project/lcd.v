module lcd(
	input clk_1k, reset,
	input dot_game_over, game_success, timeover,
	output lcd_en,
	output reg lcd_rs, lcd_rw,
	output reg [7:0] lcd_data
);

reg [9:0] count, shift_count;
reg [2:0] state;

parameter [2:0] delay			= 3'b000,
				function_set	= 3'b001,
				disp_on_off 	= 3'b010,
				entry_mode_set	= 3'b011,
				Fline			= 3'b100,
				Sline			= 3'b101;

assign lcd_en = clk_1k;

always@(posedge clk_1k or posedge reset)begin
	if(reset == 1'b1)begin
		state <= delay;
		count <= 0;
		end
	else
		case(state)
		delay			:if(count == 10'd70) begin
						state <= function_set;
						count <= 0;
					 	end
					 	else count <= count + 1;

		function_set		:if(count == 10'd30) begin
						state <= disp_on_off;
						count <= 0 ;
						end
						else count <= count+1;

		disp_on_off		:if(count == 10'd30) begin
						state <= entry_mode_set;
						count <= 0 ;
						end
						else count <= count+1;

		entry_mode_set	:if(count == 10'd30) begin
						state <= Fline;
						count <= 0 ;
						end
						else count <= count+1;

		Fline			:if(count == 10'd16) begin
						state <= Sline;
						count <= 0 ;
						end
						else count <= count+1;

		Sline			:if(count == 10'd16) begin
						count <= 0 ;
						end
						else count <= count+1;

		default : ;
		endcase
end


always@(posedge clk_1k or posedge reset)begin
	if(reset == 1'b1) begin
		lcd_rs <= 1; lcd_rw <= 1;
		lcd_data <= 8'b0000_0000;
		shift_count <= 0;
	end

	else begin
	
		if(dot_game_over == 0 && timeover == 0 && game_success == 0)begin	
		shift_count <= shift_count + 1;
		case(state)
			delay			:begin lcd_rs <= 0; lcd_rw <= 0; lcd_data <= 8'b0000_0000; end
			function_set	:begin lcd_rs <= 0; lcd_rw <= 0; lcd_data <= 8'b0011_1000; end
			disp_on_off		:begin lcd_rs <= 0; lcd_rw <= 0; lcd_data <= 8'b0000_1111; end
			entry_mode_set	:begin lcd_rs <= 0; lcd_rw <= 0; lcd_data <= 8'b0000_0110; end 
			Fline			:begin
				lcd_rw <= 0;
					case(count)
						0	:begin lcd_rs <= 0; lcd_data <= 8'd128; end // dd ram address line1
						
						1	:begin lcd_rs <= 1; lcd_data <= 8'd32;  end // <space>
						2	:begin lcd_rs <= 1; lcd_data <= 8'd32;  end // <space>
						3	:begin lcd_rs <= 1; lcd_data <= 8'd34;  end // "
						4	:begin lcd_rs <= 1; lcd_data <= 8'd83;  end // S
						5	:begin lcd_rs <= 1; lcd_data <= 8'd81;  end // Q
					 	6	:begin lcd_rs <= 1; lcd_data <= 8'd85;  end // U
						7	:begin lcd_rs <= 1; lcd_data <= 8'd73;  end // I
						8	:begin lcd_rs <= 1; lcd_data <= 8'd68;  end // D
						9	:begin lcd_rs <= 1; lcd_data <= 8'd32;  end // <space>
						10	:begin lcd_rs <= 1; lcd_data <= 8'd71;  end // G
						11	:begin lcd_rs <= 1; lcd_data <= 8'd65;  end // A
						12	:begin lcd_rs <= 1; lcd_data <= 8'd77;  end // M
						13	:begin lcd_rs <= 1; lcd_data <= 8'd69;  end // E
						14	:begin lcd_rs <= 1; lcd_data <= 8'd34;  end // "
						15	:begin lcd_rs <= 1; lcd_data <= 8'd32;  end // <space>
						16	:begin lcd_rs <= 1; lcd_data <= 8'd32;  end // <space>
						default :;
					endcase
				end

			Sline			:begin
				lcd_rw <= 0;
				case(count)
					0	: begin lcd_rs <= 0; lcd_data <= 8'd192; end // dd ram address line2
					
		  			1	: begin lcd_rs <= 1; lcd_data <= 8'd32;  end // <space>
					2	: begin lcd_rs <= 1; lcd_data <= 8'd32;  end // <space>
					3	: begin lcd_rs <= 1; lcd_data <= 8'd32;  end // <space>
					4	: begin lcd_rs <= 1; lcd_data <= 8'd71;  end // G
					5	: begin lcd_rs <= 1; lcd_data <= 8'd111; end // o
					6	: begin lcd_rs <= 1; lcd_data <= 8'd111; end // 0
					7	: begin lcd_rs <= 1; lcd_data <= 8'd100; end // d
					8	: begin lcd_rs <= 1; lcd_data <= 8'd32;  end // <space>
					9	: begin lcd_rs <= 1; lcd_data <= 8'd76;  end // L
					10	: begin lcd_rs <= 1; lcd_data <= 8'd117; end // u
					11	: begin lcd_rs <= 1; lcd_data <= 8'd99;  end // c
					12	: begin lcd_rs <= 1; lcd_data <= 8'd107; end // k
					13	: begin lcd_rs <= 1; lcd_data <= 8'd33;  end // !
					14	: begin lcd_rs <= 1; lcd_data <= 8'd32;  end // <space>
					15	: begin lcd_rs <= 1; lcd_data <= 8'd32;  end // <space>
					16	: begin lcd_rs <= 1; lcd_data <= 8'd32;  end // <space>
					default :;
				endcase
				end	
		endcase
		if(shift_count == 10'd500) begin
			lcd_rs <= 0; lcd_data <= 8'b0001_1100;
			shift_count <= 0;
		end
		end
	
		// dot game over
		else if((dot_game_over == 1 | timeover == 1) && game_success == 0) begin
		shift_count <= shift_count+1;
		case(state)
			delay			:begin lcd_rs <= 0; lcd_rw <= 0; lcd_data <= 8'b0000_0000; end
			function_set	:begin lcd_rs <= 0; lcd_rw <= 0; lcd_data <= 8'b0011_1000; end
			disp_on_off		:begin lcd_rs <= 0; lcd_rw <= 0; lcd_data <= 8'b0000_1111; end
			entry_mode_set	:begin lcd_rs <= 0; lcd_rw <= 0; lcd_data <= 8'b0000_0110; end 
			Fline			:begin
				lcd_rw <= 0;
					case(count)
						0	:begin lcd_rs <= 0; lcd_data <= 8'd128; end // dd ram address line1
						
						1	:begin lcd_rs <= 1; lcd_data <= 8'd32;  end // <space>
						2	:begin lcd_rs <= 1; lcd_data <= 8'd32;  end // <space>
						3	:begin lcd_rs <= 1; lcd_data <= 8'd34;  end // "
						4	:begin lcd_rs <= 1; lcd_data <= 8'd83;  end // S
						5	:begin lcd_rs <= 1; lcd_data <= 8'd81;  end // Q
					 	6	:begin lcd_rs <= 1; lcd_data <= 8'd85;  end // U
						7	:begin lcd_rs <= 1; lcd_data <= 8'd73;  end // I
						8	:begin lcd_rs <= 1; lcd_data <= 8'd68;  end // D
						9	:begin lcd_rs <= 1; lcd_data <= 8'd32;  end // <space>
						10	:begin lcd_rs <= 1; lcd_data <= 8'd71;  end // G
						11	:begin lcd_rs <= 1; lcd_data <= 8'd65;  end // A
						12	:begin lcd_rs <= 1; lcd_data <= 8'd77;  end // M
						13	:begin lcd_rs <= 1; lcd_data <= 8'd69;  end // E
						14	:begin lcd_rs <= 1; lcd_data <= 8'd34;  end // "
						15	:begin lcd_rs <= 1; lcd_data <= 8'd32;  end // <space>
						16	:begin lcd_rs <= 1; lcd_data <= 8'd32;  end // <space>
						default :;
					endcase
				end

			Sline			:begin
				lcd_rw <= 0;
				case(count)
					0	: begin lcd_rs <= 0; lcd_data <= 8'd192; end // dd ram address line2
					
		  			1	: begin lcd_rs <= 1; lcd_data <= 8'd32;  end // <space>
					2	: begin lcd_rs <= 1; lcd_data <= 8'd32;  end // <space>
					3	: begin lcd_rs <= 1; lcd_data <= 8'd32;  end // <space>
					4	: begin lcd_rs <= 1; lcd_data <= 8'd84;  end // T
					5	: begin lcd_rs <= 1; lcd_data <= 8'd114; end // r
					6	: begin lcd_rs <= 1; lcd_data <= 8'd121; end // y
					7	: begin lcd_rs <= 1; lcd_data <= 8'd32;  end // <space> 
					8	: begin lcd_rs <= 1; lcd_data <= 8'd32;  end // <space>
					9	: begin lcd_rs <= 1; lcd_data <= 8'd65;  end // A
					10	: begin lcd_rs <= 1; lcd_data <= 8'd103; end // g
					11	: begin lcd_rs <= 1; lcd_data <= 8'd97;  end // a
					12	: begin lcd_rs <= 1; lcd_data <= 8'd105; end // i
					13	: begin lcd_rs <= 1; lcd_data <= 8'd110; end // n
					14	: begin lcd_rs <= 1; lcd_data <= 8'd32;  end // <space>
					15	: begin lcd_rs <= 1; lcd_data <= 8'd32;  end // <space>
					16	: begin lcd_rs <= 1; lcd_data <= 8'd32;  end // <space>
					default :;
				endcase
			end
		endcase
		if(shift_count == 10'd250) begin
			lcd_rs <= 0; lcd_data <= 8'b0001_1100;
			shift_count <= 0;
		end
	
	 	end
	
	//game_ success
	else if((dot_game_over == 0 | timeover == 0)&& game_success == 1) begin
		shift_count <= shift_count+1;
		case(state)
			delay			:begin lcd_rs <= 0; lcd_rw <= 0; lcd_data <= 8'b0000_0000; end
			function_set	:begin lcd_rs <= 0; lcd_rw <= 0; lcd_data <= 8'b0011_1000; end
			disp_on_off		:begin lcd_rs <= 0; lcd_rw <= 0; lcd_data <= 8'b0000_1111; end
			entry_mode_set	:begin lcd_rs <= 0; lcd_rw <= 0; lcd_data <= 8'b0000_0110; end 
			Fline			:begin
				lcd_rw <= 0;
					case(count)
						0	:begin lcd_rs <= 0; lcd_data <= 8'd128; end // dd ram address line1
						
						1	:begin lcd_rs <= 1; lcd_data <= 8'd32;  end // <space>
						2	:begin lcd_rs <= 1; lcd_data <= 8'd32;  end // <space>
						3	:begin lcd_rs <= 1; lcd_data <= 8'd34;  end // "
						4	:begin lcd_rs <= 1; lcd_data <= 8'd83;  end // S
						5	:begin lcd_rs <= 1; lcd_data <= 8'd81;  end // Q
					 	6	:begin lcd_rs <= 1; lcd_data <= 8'd85;  end // U
						7	:begin lcd_rs <= 1; lcd_data <= 8'd73;  end // I
						8	:begin lcd_rs <= 1; lcd_data <= 8'd68;  end // D
						9	:begin lcd_rs <= 1; lcd_data <= 8'd32;  end // <space>
						10	:begin lcd_rs <= 1; lcd_data <= 8'd71;  end // G
						11	:begin lcd_rs <= 1; lcd_data <= 8'd65;  end // A
						12	:begin lcd_rs <= 1; lcd_data <= 8'd77;  end // M
						13	:begin lcd_rs <= 1; lcd_data <= 8'd69;  end // E
						14	:begin lcd_rs <= 1; lcd_data <= 8'd34;  end // "
						15	:begin lcd_rs <= 1; lcd_data <= 8'd32;  end // <space>
						16	:begin lcd_rs <= 1; lcd_data <= 8'd32;  end // <space>
						default :;
					endcase
				end

			Sline			:begin
				lcd_rw <= 0;
				case(count)
					0	: begin lcd_rs <= 0; lcd_data <= 8'd192; end // dd ram address line2
					
		  			1	: begin lcd_rs <= 1; lcd_data <= 8'd32;  end // <space>
					2	: begin lcd_rs <= 1; lcd_data <= 8'd32;  end // <space>
					3	: begin lcd_rs <= 1; lcd_data <= 8'd32;  end // <space>
					4	: begin lcd_rs <= 1; lcd_data <= 8'd32;  end // <space>
					5	: begin lcd_rs <= 1; lcd_data <= 8'd83;  end // S
					6	: begin lcd_rs <= 1; lcd_data <= 8'd117; end // u
					7	: begin lcd_rs <= 1; lcd_data <= 8'd99;  end // c
					8	: begin lcd_rs <= 1; lcd_data <= 8'd99;  end // c
					9	: begin lcd_rs <= 1; lcd_data <= 8'd101; end // e
					10	: begin lcd_rs <= 1; lcd_data <= 8'd115; end // s
					11	: begin lcd_rs <= 1; lcd_data <= 8'd115; end // s
					12	: begin lcd_rs <= 1; lcd_data <= 8'd33;  end // !
					13	: begin lcd_rs <= 1; lcd_data <= 8'd32;  end // <space>
					14	: begin lcd_rs <= 1; lcd_data <= 8'd32;  end // <space>
					15	: begin lcd_rs <= 1; lcd_data <= 8'd32;  end // <space>
					16	: begin lcd_rs <= 1; lcd_data <= 8'd32;  end // <space>
					default :;
				endcase
			end
		endcase
		if(shift_count == 10'd250) begin
			lcd_rs <= 0; lcd_data <= 8'b0001_1100;
			shift_count <= 0;
		end				
		end
	end // else end	
end //always end
endmodule
