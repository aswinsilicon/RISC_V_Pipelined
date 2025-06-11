
module if_id_reg(clk,reset,clear,enable,InstrF,PCF,PCplus4F,
                                        InstrD,PCD,PCplus4D);

    input clk;                   //clock input
    input reset;                 //active high reset to clear register contents
    input clear;                 //used to nullify instruction (misplace condition)
    input enable;                //to enable this register to function (enable = 1: stall, else it updates)
    input [31:0] InstrF;         //instruction fetched in IF stage
    input [31:0] PCF;            //PC value in IF stage
    input [31:0] PCplus4F;       //PC + 4 value in IF Stage 
    
    output reg [31:0] InstrD;    //instruction for ID stage (latched from InstrF)
    output reg [31:0] PCD;       //PC value passed to ID stage (latched from PCF) (hazard detction and branch computation)
    output reg [31:0] PCplus4D;  //PC + 4 passed to ID stage (latched from PCplus4F) (for control flow instr like jal,jalr)
    
     
    always @ (posedge clk, posedge reset) begin
        if (reset) begin         //Asynchronous clear
            InstrD   <= 0;
            PCD      <= 0;
            PCplus4D <= 0; 
        end
        
        else if (clear) begin   //Synchronous clear
            InstrD   <= 0;
            PCD      <= 0;
            PCplus4D <= 0; 
        end
        
        else if (!enable) begin
            InstrD   <= InstrF;
            PCD      <= PCF;
            PCplus4D <= PCplus4F;
        end
    end   
endmodule
