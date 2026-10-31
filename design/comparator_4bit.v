module comparator (
    input [3:0] A, B,
    output A_gt_B,
    output A_eq_B,
    output A_lt_B
);

assign A_gt_B = (A > B);
assign A_eq_B = (A == B);
assign A_lt_B = (A < B);

endmodule
module tb_comparator;

reg [3:0] A, B;
wire A_gt_B, A_eq_B, A_lt_B;

comparator uut(A, B, A_gt_B, A_eq_B, A_lt_B);

initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0, tb_comparator);

    $monitor("T=%0t A=%d B=%d GT=%b EQ=%b LT=%b",
             $time, A, B, A_gt_B, A_eq_B, A_lt_B);

    A=5; B=3; #10;
    A=4; B=4; #10;
    A=2; B=7; #10;
    A=15; B=0; #10;

    $finish;
end

endmodule
