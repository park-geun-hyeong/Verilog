module half_adder(S,C,x,y);
  input x,y;
  output S,C;

   xor(S,x,y);
   and(C,x,y);
endmodule

module full_adder(S,C,x,y,z);
   output S,C;
   input x,y,z;
   wire S1,D1,D2;

   half_adder HA1(S1,D1, x,y);
   half_adder HA2(S, D2, S1,z);
   or G1(C,D2,D1);
endmodule

module ripple_carry_8_bit_adder( S, Cout, A, B, Cin);
   
   input [07:0]A;
   input [07:0]B;
   input Cin;
   output [7:0]S;
   output Cout;

   wire [6:0]C;

   full_adder FA0 (S[0],C[0],A[0],B[0],Cin),
	      FA1 (S[1],C[1],A[1],B[1],C[0]),
              FA2 (S[2],C[2],A[2],B[2],C[1]),
              FA3 (S[3],C[3],A[3],B[3],C[2]),
              FA4 (S[4],C[4],A[4],B[4],C[3]),
              FA5 (S[5],C[5],A[5],B[5],C[4]),
              FA6 (S[6],C[6],A[6],B[6],C[5]),
              FA7 (S[7],Cout,A[7],B[7],C[6]);
endmodule

