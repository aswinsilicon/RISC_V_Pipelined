
module mux_3_1(A, B, C, select, out);

    input [31:0] A;          //input A (32-bit)
    input [31:0] B;          //input B (32-bit)
    input [31:0] C;          //input C (32-bit)
    input [1:0] select;      //select pin

    output wire [31:0] out;  //output out (32-bit)

    //                                                  00  01                       10  11
    assign out = (select[1] == 0) ? ((select[0] == 0) ? A : B) : ((select[0] == 0) ? C : 0);

endmodule
