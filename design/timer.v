module timer #(
    parameter N = 5
)(
    input clk,
    input reset,
    input enable,
    output reg done
);

reg [31:0] count;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        count <= 0;
        done <= 0;
    end
    else if (enable) begin
        if (count == N-1) begin
            count <= 0;
            done <= 1;
        end
        else begin
            count <= count + 1;
            done <= 0;
        end
    end
    else begin
        done <= 0;
    end
end

endmodule
module tb_timer;

reg clk, reset, enable;
wire done;

timer #(.N(5)) uut(clk, reset, enable, done);

always #5 clk = ~clk;

initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0, tb_timer);

    clk=0;
    reset=1;
    enable=0;

    #12 reset=0;
    enable=1;

    #100 enable=0;
    #20 $finish;
end

initial begin
    $monitor("T=%0t Reset=%b Enable=%b Done=%b",
             $time, reset, enable, done);
end

endmodule
