
module reg_file(clk,RegWrite,rs1,rs2,rd_w,write_data,RD1_D,RD2_D);

    input clk;                                //clock input
    
    input RegWrite;                           //control signal to write data or not into reg_file
    input [4:0] rs1;                          //source register 1 index value from if_id_reg
    input [4:0] rs2;                          //source register 2 index value from if_id_reg
    input [4:0] rd_w;                         //destination register index value from mem_wb_reg
    
    input [31:0] write_data;                  //writing data into the reg_file when RegWrite is 1
    
    output wire [31:0] RD1_D;                 //register file output 1 given to id_ex_reg
    output wire [31:0] RD2_D;                 //register file output 2 given to id_ex_reg
 

    reg [31:0] register [31:0];               //register file memory array
                                              //32 registers each having size 32 bit
                                 
    //we will write on falling edge  (write_data operations)
    //we will read on rising edge    (rs1,rs2 operations)
    
    //we will need to keep register[0] = 0
    assign RD1_D = (rs1 != 0) ? register[rs1] : 0;
    assign RD2_D = (rs2 != 0) ? register[rs2] : 0;
    
    //the following happens during write back stage
    always @ (negedge clk) begin
        if (RegWrite & rd_w != 5'b00000) begin //preventing writing 5'b00000 to reg_file
            register[rd_w] <= write_data;
            
        end
    end
endmodule
