module ring_counter (
    input clk,
    input reset,
    output reg [3:0] q
);

always @(posedge clk or posedge reset) begin
    if (reset)
        q <= 4'b0001;
    else
        q <= {q[2:0], q[3]};
end

endmodule
module tb_ring_counter;

reg clk, reset;
wire [3:0] q;

ring_counter uut(clk, reset, q);

always #5 clk = ~clk;

initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0, tb_ring_counter);

    clk=0;
    reset=1;

    #12 reset=0;
    #80 $finish;
end

initial begin
    $monitor("T=%0t Reset=%b Q=%b", $time, reset, q);
end

endmodule
