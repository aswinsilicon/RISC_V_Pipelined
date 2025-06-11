
module adder(A,B,out); 

    input [31:0] A;    //input A (32-bit)
    input [31:0] B;    //input B (32-bit)
    output wire [31:0] out; //output out (32-bit)
 
    assign out = A + B; //out is summation of A and B

endmodule
