module synchronous_counter (
    input clk,
    input reset,
    output reg [3:0] q
);

always @(posedge clk or posedge reset) begin
    if (reset)
        q <= 4'b0000;
    else
        q <= q + 1'b1;
end

endmodule
module tb_synchronous_counter;

reg clk, reset;
wire [3:0] q;

synchronous_counter uut(clk, reset, q);

always #5 clk = ~clk;

initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0, tb_synchronous_counter);

    clk=0;
    reset=1;

    #12 reset=0;
    #180 $finish;
end

initial begin
    $monitor("T=%0t Reset=%b Q=%d (%b)", $time, reset, q, q);
end

endmodule
