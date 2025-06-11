
module datapath(clk,reset,ResultSrcW,PCJalSrcE,PCSrcE,ALUSrcAE,ALUSrcBE,RegWriteW,ImmSrcD,ALUControlE,
                          Zero_E,Sign_E,PCF,Instr_F,Instr_D,ALUResultM,WriteDataM,ReadDataM,ForwardAE,
                          ForwardBE,rs1_D,rs2_D,rs1_E,rs2_E,rd_E,rd_M,rd_W,Stall_D,Stall_F,Flush_D,Flush_E,ResultW);
                          
    input clk;
    input reset;
    input [1:0] ResultSrcW;
    input PCJalSrcE;
    input PCSrcE;
    input ALUSrcAE;
    input [1:0] ALUSrcBE;
    input RegWriteW;
    input [2:0] ImmSrcD;
    input [3:0] ALUControlE;
    input [31:0] Instr_F;
    input [31:0] ReadDataM;
    input [1:0] ForwardAE;
    input [1:0] ForwardBE;
    input Stall_D;
    input Stall_F;
    input Flush_D;
    input Flush_E;
    
    
    output Zero_E;
    output Sign_E;
    output [31:0] PCF;
    output [31:0] Instr_D;
    output [31:0] ALUResultM;
    output [31:0] WriteDataM;
    output [4:0] rs1_D, rs2_D, rs1_E, rs2_E;
    output [4:0] rd_E, rd_M, rd_W;
    output [31:0] ResultW;
    
    wire [31:0] PCD, PCE,ALUResultE,ALUResultM,ReadDataM,ReadDataW;
    wire [31:0] PCNextF,PCplus4F,PCplus4D,PCplus4E,PCplus4M,PCplus4W,PCTargetE,JumpTargetE;
    wire [31:0] WriteDataE;
    wire [31:0] ImmExtD;
    wire [31:0] ImmExtE;
    wire [31:0] SrcAEfor,SrcAE,SrcBE,RD1_D,RD2_D,RD1_E,RD2_E;
    wire [31:0] ResultW;
    wire [4:0] rd_D;
    
    //Instruction Fetch Stage
    mux_2_1 jalr(PCTargetE,ALUResultE,PCJalSrcE,JumpTargetE);
    pc_mux pcmux(PCplus4F,JumpTargetE,PCSrcE,PCNextF);
    reset_ff pcSel(clk,reset,PCNextF,PCF,~Stall_F);
    adder pcadd4(PCF,32'd4,PCplus4F);
    
    //instruction_memory im(PCF,Instr_F);
    
    //Instruction Fetch_Instruction Decode register
    if_id_reg pipefd(clk,reset,Flush_D,~Stall_D,Instr_F,PCF,PCPlus4F,
                                                Instr_D,PCD,PCplus4D);
    assign rs1_D = Instr_D[19:15];
    assign rs2_D = Instr_D[24:20];
    
    reg_file r(clk, RegWriteW, rs1_D,rs2_D,rd_W,ResultW,rd1_D,rd2_D);
    
    assign rd_D = Instr_D[11:7];
    
    immediate_extend im_ext(Instr_D[31:7],ImmSrcD,ImmExtD);
    
    //Instruction Decode_ Instruction_Execute register
    id_ex_reg pipeidex(clk,reset,Flush_E,RD1_D,RD2_D,PCD,rs1_D,rs2_D,rd_D,ImmExtD,PCplus4D,
                                       RD1_E,RD2_E,PCE,rs1_E,rs2_E,rd_E,ImmExtE,PCplus4E);
    
    forward_Amux forwardmuxA(RD1_E,ResultW,ALUResultM,ForwardAE,SrcAEfor);
    mux_2_1 srcAmux(SrcAEfor,32'b0,ALUSrcAE,SrcAE);
    forward_Bmux forwardmuxB(RD2_E,ResultW,ALUResultM,ForwardBE,WriteDataE);
    mux_3_1 srcBmux(WriteDataE,ImmExtE,PCTargetE,ALUSrcBE,SrcBE);
    adder pcadder(PCE,ImmExtE,PCTargetE); //next PC for jump and branch instructions
    
    alu al(SrcAE,SrcBE,ALUControlE,ALUResultE,Zero_E,Sign_E);
    
    //Instruction Execute_Memory Access register
    ex_mem_reg pipeexmem(clk,reset,ALUResultE,WriteDataE,rd_E,PCplus4E,
                                   ALUResultM,WriteDataM,rd_M,PCplus4M);

    //data_memory dm(clk, MemWriteM,ALUResultM,WriteDataM,ReadDataM);
    
    //Memory Access_Write Back register
    mem_wb_reg pipememwb(clk,reset,ALUResultM,ReadDataM,rd_M,PCplus4M,
                                   ALUResultW,ReadDataW,rd_W,PCplus4W);
                                   
    wb_mux wr(ALUResultW,ReadDataW,PCplus4W,ResultSrcW,ResultW); 
                                 
endmodule
