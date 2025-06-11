module reset_ff (clk,reset,d_in,q_out,Stall_D);
    input       clk, reset;
    input       [31:0] d_in;
    
    input       Stall_D;
    
    output reg  [31:0] q_out;
    


always @(posedge clk or posedge reset) begin
    if (reset) q_out <= 0;
    else if(!Stall_D)    q_out <= d_in;
end

endmodule
