module asynchronous_counter (
    input clk,
    input reset,
    output reg [3:0] q
);

always @(posedge clk or posedge reset) begin
    if (reset)
        q[0] <= 0;
    else
        q[0] <= ~q[0];
end

always @(negedge q[0] or posedge reset) begin
    if (reset)
        q[1] <= 0;
    else
        q[1] <= ~q[1];
end

always @(negedge q[1] or posedge reset) begin
    if (reset)
        q[2] <= 0;
    else
        q[2] <= ~q[2];
end

always @(negedge q[2] or posedge reset) begin
    if (reset)
        q[3] <= 0;
    else
        q[3] <= ~q[3];
end

endmodule
module tb_asynchronous_counter;

reg clk, reset;
wire [3:0] q;

asynchronous_counter uut(clk, reset, q);

always #5 clk = ~clk;

initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0, tb_asynchronous_counter);

    clk=0;
    reset=1;

    #12 reset=0;
    #180 $finish;
end

initial begin
    $monitor("T=%0t Reset=%b Q=%b", $time, reset, q);
end

endmodule
