module lfsr (
    input clk,
    input reset,
    output reg [3:0] q
);

wire feedback;
assign feedback = q[3] ^ q[2];

always @(posedge clk or posedge reset) begin
    if (reset)
        q <= 4'b0001;
    else
        q <= {q[2:0], feedback};
end

endmodule
module tb_lfsr;

reg clk, reset;
wire [3:0] q;

lfsr uut(clk, reset, q);

always #5 clk = ~clk;

initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0, tb_lfsr);

    clk=0;
    reset=1;

    #12 reset=0;
    #180 $finish;
end

initial begin
    $monitor("T=%0t Q=%b", $time, q);
end

endmodule
