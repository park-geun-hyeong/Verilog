module full_adder_dataflow(A,B,Cin,S,Cout);
input A,B,Cin;
output S,Cout;

assign S = ((A^B)^Cin);
assign Cout = ((A&B)|((A^B)&Cin)); 

endmodule

module ripple_carry_adder_dataflow(A,B,Cin,S,Cout);

input [7:0]A;
input [7:0]B;
input Cin;
output [7:0]S;
output Cout;

wire C[6:0];

full_adder_dataflow a1(A[0],B[0],Cin,S[0],C[0]);
full_adder_dataflow a2(A[1],B[1],C[0],S[1],C[1]);
full_adder_dataflow a3(A[2],B[2],C[1],S[2],C[2]);
full_adder_dataflow a4(A[3],B[3],C[2],S[3],C[3]);
full_adder_dataflow a5(A[4],B[4],C[3],S[4],C[4]);
full_adder_dataflow a6(A[5],B[5],C[4],S[5],C[5]);
full_adder_dataflow a7(A[6],B[6],C[5],S[6],C[6]);
full_adder_dataflow a8(A[7],B[7],C[6],S[7],Cout);

endmodule
