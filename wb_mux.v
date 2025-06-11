
module wb_mux(ALUResult_W,read_data_W,PCplus4W,ResultSrcW,write_back_result);
  
    input [31:0] ALUResult_W;          //ALU result obtained from mem_wb_reg (R,I)
    input [31:0] read_data_W;          //read_data obtained from mem_wb_Reg (load)
    input [31:0] PCplus4W;             //PC + 4 value obtained from mem_wb_reg 
    
    input [1:0] ResultSrcW;            //control signal from the Control Unit during ID stage
    
    output [31:0] write_back_result;   //writing back the result according to ResultSrcW control signal
    //                                           10                            01           00 
    assign write_back_result = ResultSrcW[1]? PCplus4W : (ResultSrcW[0] ? read_data_W : ALUResult_W);
    
endmodule
