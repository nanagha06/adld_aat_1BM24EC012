module parity_generator_checker (
    input [3:0] data,
    input parity_in,
    output parity_out,
    output error
);

assign parity_out = ^data;
assign error = ^{data, parity_in};

endmodule
module tb_parity;

reg [3:0] data;
reg parity_in;
wire parity_out, error;

parity_generator_checker uut(data, parity_in, parity_out, error);

initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0, tb_parity);

    $monitor("T=%0t Data=%b Pin=%b Pout=%b Error=%b",
             $time, data, parity_in, parity_out, error);

    data=4'b0000; parity_in=0; #10;
    data=4'b0001; parity_in=1; #10;
    data=4'b1011; parity_in=1; #10;
    data=4'b1011; parity_in=0; #10;

    $finish;
end

endmodule
