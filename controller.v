
module controller(clk,reset,opcode,funct3,funct7bit5,Zero_E,Sign_E,Flush_E,
                  ResultSrcE0,ResultSrcW,MemWriteM,PCJalSrcE,PCSrcE,
                  ALUSrcAE,ALUSrcBE,RegWriteM,RegWriteW,ImmSrcD,ALUControlE);
                  
    input clk;                 //clock input
    input reset;               //active high reset pin
    input [6:0] opcode;        //7 bit opcode
    input [2:0] funct3;        //3 bit funct3 
    input funct7bit5;          //5th bit of funct7
    input Zero_E;              //Zero result of ALU in EX stage
    input Sign_E;              //Sign result of ALU in EX stage
    input Flush_E;             //Used to flush the pipeline
    
    output ResultSrcE0;        //LSB bit of ResultSrcE control signal
    output [1:0] ResultSrcW;   //2 bit ResultSrcW control signal
    output MemWriteM;          //sends signal to data_memory as write_enable
    output PCJalSrcE;          //sends signals to PC Jal mux
    output PCSrcE;             //sends signals to PC mux
    output ALUSrcAE;           //select operand 1 source (rs1 or PC)
    output [1:0] ALUSrcBE;     //select operand 2 source (rs2 or imm or +4 or any-other)
    output RegWriteM;          //control signal to control write operation in reg_file (M)
    output RegWriteW;          //control signal to control write operation in reg_file (W)
    output [2:0] ImmSrcD;      //immediate source selector
    output [3:0] ALUControlE;  //controls which ALU operation to perform 
    
    wire [1:0] ALUOpD;          // ALU operation type from main_decoder to alu_decoder
    
    wire [1:0] ResultSrcD;     //2 bit ResultSrcD control signal
    wire [1:0] ResultSrcE;     //2 bit ResultSrcE control signal
    wire [1:0] ResultSrcM;     //2 bit ResultSrcM control signal
    
    wire RegWriteD;            //control signals to control write operation in reg_file (D) 
    wire RegWriteE;            //control signals to control write operation in reg_file (D) 

    wire [3:0] ALUControlD;    //controls which ALU operation to perform
    wire ALUSrcAD;
    
    wire BranchD, BranchE;     //branch control conditions based on funct3
    wire MemWriteD, MemWriteE; //sends signal to data_memory as write_enable
    wire JumpD, JumpE;         //used in pc_mux for jump interrupts
    wire [1:0] ALUSrcBD;       //select operand 2 source (rs2 or imm or +4 or any-other)
  
    wire SignOp;               //sign flag for branch logic
    wire BranchOp;             //only beq / no branch 
    wire ZeroOp;
    
    //main decoder
    main_decoder m(opcode,ALUOpD,ALUSrcAD,ALUSrcBD,RegWriteD,MemWriteD,ResultSrcD,BranchD,JumpD,ImmSrcD);
    
    //alu decoder
    alu_decoder  a(opcode[5],funct3,funct7bit5,ALUOpD,ALUControlD);
    
    id_ex_reg_ctrl  pipe0(clk,reset,Flush_E,RegWriteD,MemWriteD,JumpD,BranchD,ALUSrcAD,ALUSrcBD,ResultSrcD,ALUControlD,
                                            RegWriteE,MemWriteE,JumpE,BranchE,ALUSrcAE,ALUSrcBE,ResultSrcE,ALUControlE);
    
    assign ResultSrcE0 = ResultSrcE[0];
    
    ex_mem_reg_ctrl pipe1(clk,reset,RegWriteE,MemWriteE,ResultSrcE,
                                    RegWriteM,MemWriteM,ResultSrcM);
                               
    mem_wb_reg_ctrl pipe2(clk,reset,RegWriteM,MemWriteM,ResultSrcM,
                                    RegWriteW,MemWriteW,ResultSrcW);
    
    assign ZeroOp = Zero_E ^ funct3[0]; //complements Zero flag for bne instruction
    assign SignOp = Sign_E ^ funct3[0]; //complements Zero flag for bge instruction
    
    assign BranchOp = funct3[2] ? (SignOp) : (ZeroOp);
    assign PCSrcE = (BranchE & BranchOp) | JumpE;
    assign PCJalSrcE = JumpE; //(opcode == 7'b1100111) ? 1'b1 : 1'b0;  //jalr instruction

endmodule
