module shift_register (
    input clk,
    input reset,
    input serial_in,
    output serial_out,
    output reg [3:0] q
);

assign serial_out = q[3];

always @(posedge clk or posedge reset) begin
    if (reset)
        q <= 4'b0000;
    else
        q <= {q[2:0], serial_in};
end

endmodule
module tb_shift_register;

reg clk, reset, serial_in;
wire serial_out;
wire [3:0] q;

shift_register uut(clk, reset, serial_in, serial_out, q);

always #5 clk = ~clk;

initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0, tb_shift_register);

    clk=0;
    reset=1;
    serial_in=0;

    #12 reset=0;

    serial_in=1; #10;
    serial_in=0; #10;
    serial_in=1; #10;
    serial_in=1; #10;
    serial_in=0; #10;
    serial_in=0; #10;

    $finish;
end

initial begin
    $monitor("T=%0t SI=%b Q=%b SO=%b",
             $time, serial_in, q, serial_out);
end

endmodule
