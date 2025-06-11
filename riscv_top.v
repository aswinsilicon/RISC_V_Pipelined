
module riscv_top(clk,reset,WriteDataM,DataAdrM,MemWriteM);
                           
    input clk;
    input reset;
    output [31:0] WriteDataM,DataAdrM;
    output MemWriteM;

    wire [31:0] Instr_F,PCF, ReadDataM;
    
    riscv_integrated ri(clk,reset,PCF,Instr_F,MemWriteM, DataAdrM,WriteDataM,ReadDataM);
    instruction_memory im(PCF,Instr_F);
    data_memory dm(clk, MemWriteM,DataAdrM,WriteDataM,ReadDataM);


endmodule

