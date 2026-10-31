module barrel_shifter (
    input [3:0] data_in,
    input [1:0] shift_amount,
    input direction,
    output reg [3:0] data_out
);

always @(*) begin
    if (direction == 1'b0)
        data_out = data_in << shift_amount;
    else
        data_out = data_in >> shift_amount;
end

endmodule
module tb_barrel_shifter;

reg [3:0] data_in;
reg [1:0] shift_amount;
reg direction;
wire [3:0] data_out;

barrel_shifter uut(data_in, shift_amount, direction, data_out);

initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0, tb_barrel_shifter);

    $monitor("T=%0t In=%b Shift=%d Dir=%b Out=%b",
             $time, data_in, shift_amount, direction, data_out);

    data_in=4'b1011; shift_amount=1; direction=0; #10;
    data_in=4'b1011; shift_amount=2; direction=0; #10;
    data_in=4'b1011; shift_amount=1; direction=1; #10;
    data_in=4'b1011; shift_amount=2; direction=1; #10;

    $finish;
end

endmodule
