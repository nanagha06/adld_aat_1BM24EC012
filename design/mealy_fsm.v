module mealy_detector (
    input clk,
    input reset,
    input x,
    output reg z
);

reg [1:0] state, next_state;

localparam S0 = 2'b00,
           S1 = 2'b01,
           S2 = 2'b10;

always @(posedge clk or posedge reset) begin
    if (reset)
        state <= S0;
    else
        state <= next_state;
end

always @(*) begin
    next_state = state;
    z = 0;

    case (state)
        S0: begin
            if (x)
                next_state = S1;
            else
                next_state = S0;
        end

        S1: begin
            if (x)
                next_state = S1;
            else
                next_state = S2;
        end

        S2: begin
            if (x) begin
                next_state = S1;
                z = 1;
            end
            else
                next_state = S0;
        end

        default: next_state = S0;
    endcase
end

endmodule
module tb_mealy_detector;

reg clk, reset, x;
wire z;

mealy_detector uut(clk, reset, x, z);

always #5 clk = ~clk;

initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0, tb_mealy_detector);

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

    #10 $finish;
end

initial begin
    $monitor("T=%0t X=%b Z=%b", $time, x, z);
end

endmodule
