module divide_by_n #(
    parameter N = 5
)(
    input clk,
    input reset,
    output reg clk_out
);

localparam WIDTH = (N <= 1) ? 1 : $clog2(N);
reg [WIDTH-1:0] count;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        count <= 0;
        clk_out <= 0;
    end
    else if (count == N-1) begin
        count <= 0;
        clk_out <= ~clk_out;
    end
    else begin
        count <= count + 1'b1;
    end
end

endmodule
module tb_divide_by_n;

reg clk, reset;
wire clk_out;

divide_by_n #(.N(5)) uut(clk, reset, clk_out);

always #5 clk = ~clk;

initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0, tb_divide_by_n);

    clk=0;
    reset=1;

    #12 reset=0;
    #220 $finish;
end

initial begin
    $monitor("T=%0t CLK=%b CLK_OUT=%b",
             $time, clk, clk_out);
end

endmodule
