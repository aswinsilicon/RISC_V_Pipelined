
module forward_Bmux(RD2_E,ALUResult_M,write_back_result,ForwardB,outB);

    input [31:0] RD2_E;              //value coming from id_ex_reg (initially from reg_file)
    input [31:0] ALUResult_M;        //forwarded value from mem_wb_reg
    input [31:0] write_back_result;  //forwarded value from mem_wb_reg
    input [1:0] ForwardB;            //select pin to choose between forwarded values or reg_file value
    
    output [31:0] outB;              //32 bit output 
    //                             10                             01              00            
    assign outB = ForwardB[1] ? ALUResult_M : (ForwardB[0] ? write_back_result : RD2_E);
endmodule
