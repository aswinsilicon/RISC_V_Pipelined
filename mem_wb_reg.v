
module mem_wb_reg(clk,reset,ALUResult_M,read_data_M,rd_M,PCplus4M,
                            ALUResult_W,read_data_W,rd_W,PCplus4W);

    input clk;                        //clock input
    input reset;                      //active high reset to clear register contents
     
    input [31:0] ALUResult_M;         //ALU result in memory stage
    input [31:0] read_data_M;         //PC value in memory stage
    input [4:0] rd_M;                 //destination register in memory
    input [31:0] PCplus4M;            //PC + 4 value in memory stage 
    
    output reg [31:0] ALUResult_W;    //ALU result in write back stage
    output reg [31:0] read_data_W;    //PC value in write back stage
    output reg [4:0] rd_W;            //destination register in write back
    output reg [31:0] PCplus4W;       //PC + 4 value in write back stage 
    
    always @ (posedge clk, posedge reset) begin
        if (reset) begin         
            ALUResult_W   <= 0;
            read_data_W   <= 0;
            rd_W          <= 0;
            PCplus4W      <= 0; 
        end
        
        else  begin
            ALUResult_W   <= ALUResult_M;  
            read_data_W  <= read_data_M;
            rd_W          <= rd_M;
            PCplus4W      <= PCplus4M; 
        end
    end   
endmodule
