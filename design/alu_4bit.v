module alu (
    input [3:0] A, B,
    input [2:0] sel,
    output reg [3:0] Y,
    output reg carry
);

always @(*) begin
    Y = 0;
    carry = 0;

    case (sel)
        3'b000: {carry, Y} = {1'b0, A} + {1'b0, B};
        3'b001: Y = A - B;
        3'b010: Y = A & B;
        3'b011: Y = A | B;
        3'b100: Y = A ^ B;
        3'b101: Y = ~A;
        3'b110: begin
            Y = A << 1;
            carry = A[3];
        end
        3'b111: begin
            Y = A >> 1;
            carry = A[0];
        end
    endcase
end

endmodule
module tb_alu;

reg [3:0] A, B;
reg [2:0] sel;
wire [3:0] Y;
wire carry;

alu uut(A, B, sel, Y, carry);

initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0, tb_alu);

    $monitor("T=%0t A=%b B=%b sel=%b Y=%b carry=%b",
             $time, A, B, sel, Y, carry);

    A=5; B=3; sel=0; #10;
    sel=1; #10;
    sel=2; #10;
    sel=3; #10;
    sel=4; #10;
    sel=5; #10;
    sel=6; #10;
    sel=7; #10;

    $finish;
end

endmodule
