module piezo(

	input clk, clk2, clk3, rst,
	input dot_game_over,game_success,
	input timeover,
	output reg piezo_freq,
	output reg [9:0] piezo_cnt
);

integer clk_t, clk_t2;

//Tone ??? ??? ?? ??? ??? ?? (clk=500kHz? ??)

parameter C_tone = 478; // ?(261 Hz) : [press key1]
parameter D_tone = 424; // ?(293 Hz) : [press key2]
parameter Dsharp_tone = 401; // ?(293 Hz) : [press key2]
parameter E_tone = 378; // ?(329 Hz) : [press key3]
parameter F_tone = 358; // ?(349 Hz) : [press key4]
parameter G_tone = 320; // ?(392 Hz) : [press key5]
parameter A_tone = 284; // ?(440 Hz) : [press key6]
parameter B_tone = 254; // ?(494 Hz) : [press key7]

reg [9:0] cnt;

always @(rst) begin
   if (rst) piezo_cnt = 0;
	else if(game_success == 1) begin
		case(clk_t2)
		 0 : piezo_cnt = B_tone/2;
		 1 : piezo_cnt = 1;
         2 : piezo_cnt = B_tone/2;
         3 : piezo_cnt = 1;
         4 : piezo_cnt = B_tone/2;
		 5 : piezo_cnt = B_tone/2;
		 6 : piezo_cnt = 1;
		 7 : piezo_cnt = 1;
		 8 : piezo_cnt = B_tone/2;
		 9 : piezo_cnt = 1;
		 10 : piezo_cnt = B_tone/2;
		 11 : piezo_cnt = 1;
         12 : piezo_cnt = B_tone/2;
		 13 : piezo_cnt = B_tone/2;
		 14 : piezo_cnt = 1;
		 15 : piezo_cnt = 1;
         16 : piezo_cnt = Dsharp_tone/4;
		 17 : piezo_cnt = 1;
         18 : piezo_cnt = B_tone/2;
		 19 : piezo_cnt = 1;
         20 : piezo_cnt = B_tone/2;
		 21 : piezo_cnt = 1;
         22 : piezo_cnt = A_tone/2;
		 23 : piezo_cnt = 1; 
         24 : piezo_cnt = G_tone/2;
		 25 : piezo_cnt = 1;
		 26 : piezo_cnt = A_tone/2;
		 27 : piezo_cnt = 1;
		 28 : piezo_cnt = B_tone/2;
		 29 : piezo_cnt = B_tone/2;
		 30 : piezo_cnt = 1;
         31 : piezo_cnt = 1;
         32 : piezo_cnt = B_tone/2; 
         33 : piezo_cnt = 1;
		 34 : piezo_cnt = B_tone/2;
		 35 : piezo_cnt = 1;
         36 : piezo_cnt = B_tone/2; 
         37 : piezo_cnt = B_tone/2;
		 38 : piezo_cnt = 1;
         39 : piezo_cnt = 1;
		 40 : piezo_cnt = B_tone/2;
		 41 : piezo_cnt = 1;
		 42 : piezo_cnt = B_tone/2;
		 43 : piezo_cnt = 1;
		 44 : piezo_cnt = B_tone/2;
		 45 : piezo_cnt = B_tone/2;
		 46 : piezo_cnt = 1;
		 47 : piezo_cnt = 1;
		 48 : piezo_cnt = B_tone/2;
		 49 : piezo_cnt = 1;
		 50 : piezo_cnt = A_tone/2;
		 51 : piezo_cnt = 1;
		 52 : piezo_cnt = G_tone/2;
		 53 : piezo_cnt = 1;
		 54 : piezo_cnt = A_tone/2;
		 55 : piezo_cnt = 1;
		 56 : piezo_cnt = G_tone/2;
		 57 : piezo_cnt = 1;
		 58 : piezo_cnt = E_tone/2;
		 59 : piezo_cnt = 1;
		 60 : piezo_cnt = E_tone/2;
		 61 : piezo_cnt = E_tone/2;
		 62 : piezo_cnt = 1;
		 63 : piezo_cnt = 1;
         default : piezo_cnt = 0;
         endcase
	end
	else begin
	if((dot_game_over == 0)&(timeover == 0)) begin         
		case(clk_t)
         0 : piezo_cnt = E_tone;
		 1 : piezo_cnt = 1;
         2 : piezo_cnt = A_tone;
         3 : piezo_cnt = 1;
         4 : piezo_cnt = A_tone;
		 5 : piezo_cnt = A_tone;
		 6 : piezo_cnt = 1;
		 7 : piezo_cnt = 1;
		 8 : piezo_cnt = A_tone;
		 9 : piezo_cnt = A_tone;
		 10 : piezo_cnt = 1;
		 11 : piezo_cnt = 1;
         12 : piezo_cnt = G_tone;
		 13 : piezo_cnt = G_tone;
		 14 : piezo_cnt = 1;
		 15 : piezo_cnt = 1;
         16 : piezo_cnt = A_tone;
		 17 : piezo_cnt = 1;
         18 : piezo_cnt = A_tone;
		 19 : piezo_cnt = 1;
         20 : piezo_cnt = E_tone;
		 21 : piezo_cnt = 1;
         22 : piezo_cnt = E_tone;
		 23 : piezo_cnt = 1; 
         24 : piezo_cnt = G_tone;
		 25 : piezo_cnt = G_tone;
		 26 : piezo_cnt = G_tone;
		 27 : piezo_cnt = G_tone;
		 28 : piezo_cnt = 0;
		 29 : piezo_cnt = 0;
         30 : piezo_cnt = 0;
         31 : piezo_cnt = 0; 
         32 : piezo_cnt = 0;
		 33 : piezo_cnt = 0;
         34 : piezo_cnt = 0;
         35 : piezo_cnt = 0; 
         36 : piezo_cnt = 0;
		 37 : piezo_cnt = 0;
         38 : piezo_cnt = 0;
         39 : piezo_cnt = 0; 
         40 : piezo_cnt = 0;
		 41 : piezo_cnt = 0;
         42 : piezo_cnt = 0;
         43 : piezo_cnt = 0; 
         44 : piezo_cnt = 0;
         default : piezo_cnt = 0;
         endcase
		end
		else piezo_cnt = B_tone;
      end
end

always @(posedge clk3 or posedge rst) begin
	if (rst==1'b1) begin
   		clk_t2 <= 0;
   	end

   	else begin
		if (game_success == 1'b1) begin
			case (clk_t2)
         		0 : clk_t2 <= 1;
         		1 : clk_t2 <= 2;
         		2 : clk_t2 <= 3;
         		3 : clk_t2 <= 4;
         		4 : clk_t2 <= 5;
         		5 : clk_t2 <= 6;
         		6 : clk_t2 <= 7;
         		7 : clk_t2 <= 8;
         		8 : clk_t2 <= 9;
         		9 : clk_t2 <= 10;
		 		10 : clk_t2 <= 11;
         		11 : clk_t2 <= 12;
         		12 : clk_t2 <= 13;
         		13 : clk_t2 <= 14;
		 		14 : clk_t2<= 15;
         		15 : clk_t2 <= 16;
         		16 : clk_t2 <= 17;
         		17 : clk_t2 <= 18;
				18 : clk_t2 <= 19;
		 		19 : clk_t2 <= 20;
		 		20 : clk_t2 <= 21;
				21 : clk_t2 <= 22;
         		22 : clk_t2 <= 23;
         		23 : clk_t2 <= 24;
         		24 : clk_t2 <= 25;
         		25 : clk_t2 <= 26;
         		26 : clk_t2 <= 27;
         		27 : clk_t2 <= 28;
        		28 : clk_t2 <= 29;
         		29 : clk_t2 <= 30;
         		30 : clk_t2 <= 31;
		 		31 : clk_t2 <= 32;
         		32 : clk_t2 <= 33;
         		33 : clk_t2 <= 34;
         		34 : clk_t2 <= 35;
		 		35 : clk_t2 <= 36;
         		36 : clk_t2 <= 37;
         		37 : clk_t2 <= 38;
        		38 : clk_t2 <= 39;
		 		39 : clk_t2 <= 40;
		 		40 : clk_t2 <= 41;
		 		41 : clk_t2 <= 42;
		 		42 : clk_t2 <= 43;
		 		43 : clk_t2 <= 44;
		 		44 : clk_t2 <= 45;
		 		45 : clk_t2 <= 46;
		 		46 : clk_t2 <= 47;
		 		47 : clk_t2 <= 48;
		 		48 : clk_t2 <= 49;
		 		49 : clk_t2 <= 50;
		 		50 : clk_t2 <= 51;
		 		51 : clk_t2 <= 52;
		 		52 : clk_t2 <= 53;
		 		53 : clk_t2 <= 54;
		 		54 : clk_t2 <= 55;
		 		55 : clk_t2 <= 56;
		 		56 : clk_t2 <= 57;
				57 : clk_t2 <= 58;
				58 : clk_t2 <= 59;
		 		59 : clk_t2 <= 60;
		 		60 : clk_t2 <= 61;
		 		61 : clk_t2 <= 62;
		 		62 : clk_t2 <= 63;
		 		63 : clk_t2 <= 0;
	        endcase
   		end
	end 


end

always @(posedge clk2 or posedge rst) begin
   if (rst==1'b1) begin
   clk_t <= 0;
   end
   
   else begin
		if(game_success == 1'b0) begin
         case (clk_t)
         0 : clk_t <= 1;
         1 : clk_t <= 2;
         2 : clk_t <= 3;
         3 : clk_t <= 4;
         4 : clk_t <= 5;
         5 : clk_t <= 6;
         6 : clk_t <= 7;
         7 : clk_t <= 8;
         8 : clk_t <= 9;
         9 : clk_t <= 10;
		 10 : clk_t <= 11;
         11 : clk_t <= 12;
         12 : clk_t <= 13;
         13 : clk_t <= 14;
		 14 : clk_t <= 15;
         15 : clk_t <= 16;
         16 : clk_t <= 17;
         17 : clk_t <= 18;
		 18 : clk_t <= 19;
		 19 : clk_t <= 20;
		 20 : clk_t <= 21;
		 21 : clk_t <= 22;
         22 : clk_t <= 23;
         23 : clk_t <= 24;
         24 : clk_t <= 25;
         25 : clk_t <= 26;
         26 : clk_t <= 27;
         27 : clk_t <= 28;
         28 : clk_t <= 29;
         29 : clk_t <= 30;
         30 : clk_t <= 31;
		 31 : clk_t <= 32;
         32 : clk_t <= 33;
         33 : clk_t <= 34;
         34 : clk_t <= 35;
	     35 : clk_t <= 36;
         36 : clk_t <= 37;
         37 : clk_t <= 38;
         38 : clk_t <= 39;
		 39 : clk_t <= 40;
		 40 : clk_t <= 41;
		 41 : clk_t <= 42;
		 42 : clk_t <= 43;
		 43 : clk_t <= 44;
		 44 : clk_t <= 0;
         endcase
		end
   end
end

always @(posedge clk or posedge rst) begin
   if (rst)
      begin
      cnt <= 0;
      piezo_freq <= 0;
      end
   else begin
      if (cnt == piezo_cnt) begin
         cnt <= 0;
         piezo_freq <= ~piezo_freq;
         end
      else 
		 cnt <= cnt + 1;
   end
end

endmodule 
