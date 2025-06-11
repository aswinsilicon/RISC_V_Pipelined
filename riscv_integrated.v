
module riscv_integrated(clk,reset,PCF,Instr_F,MemWriteM,ALUResultM,WriteDataM,ReadDataM);
  
    input clk;
    input reset;
    input [31:0] Instr_F;
    input [31:0] ReadDataM;
    
    output [31:0] PCF;
    output [31:0] ALUResultM;
    output [31:0] WriteDataM;
    output MemWriteM;
    
    wire ALUSrcAE,RegWriteM,RegWriteW,Zero_E,Sign_E,PCJalSrcE;
    wire [1:0] ALUSrcBE;
    wire Stall_D,Stall_F,Flush_D,Flush_E,ResultSrcE0;
    wire [1:0] ResultSrcW;
    wire [2:0] ImmSrcD;
    wire [3:0] ALUControlE;
    wire [31:0] Instr_D;
    wire [4:0] rs1_D,rs2_D,rs1_E,rs2_E;
    wire [4:0] rd_E,rd_M,rd_W;
    wire [1:0] ForwardAE,ForwardBE;
    
    
    
    controller cnt (clk,reset,Instr_D[6:0],Instr_D[14:12],Instr_D[30],Zero_E,Sign_E,Flush_E,
                              ResultSrcE0,ResultSrcW,MemWriteM,PCJalSrcE,PCSrcE,
                              ALUSrcAE,ALUSrcBE,RegWriteM,RegWriteW,ImmSrcD,ALUControlE);
         
    datapath dp (clk,reset,ResultSrcW,PCJalSrcE,PCSrcE,ALUSrcAE,ALUSrcBE,RegWriteW,ImmSrcD,ALUControlE,
                           Zero_E,Sign_E,PCF,Instr_F,Instr_D,ALUResultM,WriteDataM,ReadDataM,ForwardAE,
                           ForwardBE,rs1_D,rs2_D,rs1_E,rs2_E,rd_E,rd_M,rd_W,Stall_D,Stall_F,Flush_D,Flush_E,ResultW);

    hazard_detection_unit hdu (rs1_D,rs2_D,rs1_E,rs2_E,rd_E,rd_M,rd_W,
                               RegWriteM,RegWriteW,ResultSrcE0,PCSrcE,
                               ForwardAE,ForwardBE,Flush_E,Flush_D,
                               Stall_D,Stall_F);
endmodule

    
