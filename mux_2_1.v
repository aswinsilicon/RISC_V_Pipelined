
module mux_2_1(A, B, select, out);

    input [31:0] A;    //input A (32-bit)
    input [31:0] B;    //input B (32-bit)
    input select;      //select pin

    output wire [31:0] out; //output out (32-bit)

    assign out = (select == 0) ? A : B;
    //if select = 0, out = A
    //else if select = 1, out = B

endmodule
