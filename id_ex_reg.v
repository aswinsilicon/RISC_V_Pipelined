
module id_ex_reg(clk,reset,clear,RD1_D,RD2_D,PCD,rs1_D,rs2_D,rd_D,immediate_extend_D,PCplus4D,
                                 RD1_E,RD2_E,PCE,rs1_E,rs2_E,rd_E,immediate_extend_E,PCplus4E);

    input clk;                            //clock input
    input reset;                          //active high reset to clear register contents
    input clear;                          //used to nullify instruction (misplace condition)
     
    input [31:0] RD1_D;                   //register file read data 1 (operand)
    input [31:0] RD2_D;                   //register file read data 2 (operand)
    input [31:0] PCD;                     //program counter value in decode
    input [4:0] rs1_D;                    //source register1 index in deocde
    input [4:0] rs2_D;                    //source register2 index in deocde
    input [4:0] rd_D;                     //destination register index in decode
    input [31:0] immediate_extend_D;      //immediate extend for sign/zero in decode
    input [31:0] PCplus4D;                // PC + 4 value in decode
    
    output reg [31:0] RD1_E;              //register file read data 1 (operand)
    output reg [31:0] RD2_E;              //register file read data 2 (operand)
    output reg [31:0] PCE;                //program counter value in execute
    output reg [4:0] rs1_E;               //source register1 index in execute
    output reg [4:0] rs2_E;               //source register2 index in execute
    output reg [4:0] rd_E;                //destination register index in execute
    output reg [31:0] immediate_extend_E; //immediate extend for sign/zero in execute
    output reg [31:0] PCplus4E;           //PC + 4 value in execute
    
    always @ (posedge clk, posedge reset) begin
        if (reset) begin                  //Asynchronous clear
            RD1_E              <= 0; 
            RD2_E              <= 0;
            PCE                <= 0;
            rs1_E              <= 0;
            rs2_E              <= 0;
            rd_E               <= 0;
            immediate_extend_E <= 0;
            PCplus4E           <= 0;  
        end 
        else if (clear) begin             //Synchronous clear
            RD1_E              <= 0;
            RD2_E              <= 0;
            PCE                <= 0;
            rs1_E              <= 0;
            rs2_E              <= 0;
            rd_E               <= 0;
            immediate_extend_E <= 0;
            PCplus4E           <= 0;  
                    
        end
        else begin    
            RD1_E              <= RD1_D;
            RD2_E              <= RD2_D;
            PCE                <= PCD ;
            rs1_E              <= rs1_D;
            rs2_E              <= rs2_D;
            rd_E               <= rd_D;
            immediate_extend_E <= immediate_extend_D;
            PCplus4E           <= PCplus4D;  
        end
    end
endmodule
