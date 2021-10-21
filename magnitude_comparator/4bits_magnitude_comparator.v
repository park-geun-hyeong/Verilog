module mag_compare(
   output A_it_B, A_eq_B, A_gt_B,
   input [3:0]A,B
);

assign A_it_B = (A<B);
assign A_gt_B = (A>B);
assign A_eq_B = (A==B);

endmodule
