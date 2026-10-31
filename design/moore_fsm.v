module moore_detector (
    input clk,
    input reset,
    input x,
    output reg z
);

reg [1:0] state, next_state;

localparam S0 = 2'b00,
           S1 = 2'b01,
           S2 = 2'b10,
           S3 = 2'b11;

always @(posedge clk or posedge reset) begin
    if (reset)
        state <= S0;
    else
        state <= next_state;
end

always @(*) begin
    next_state = S0;

    case (state)
        S0: next_state = x ? S1 : S0;
        S1: next_state = x ? S1 : S2;
        S2: next_state = x ? S3 : S0;
        S3: next_state = x ? S1 : S2;
        default: next_state = S0;
    endcase
end

always @(*) begin
    z = (state == S3);
end

endmodule
module tb_moore_detector;

reg clk, reset, x;
wire z;

moore_detector uut(clk, reset, x, z);

always #5 clk = ~clk;

initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0, tb_moore_detector);

    clk=0;
    reset=1;
    x=0;

    #12 reset=0;

    x=1; #10;
    x=0; #10;
    x=1; #10;

    x=1; #10;
    x=0; #10;
    x=1; #10;

    #20 $finish;
end

initial begin
    $monitor("T=%0t X=%b Z=%b", $time, x, z);
end

endmodule
