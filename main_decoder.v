module main_decoder(opcode,ALUOp,ALUSrcA,ALUSrcB,RegWrite,MemWrite,ResultSrc,Branch,Jump,ImmSrc);
 
    input [6:0] opcode;
    
    //controlling ALU operations and operand source
    output reg [1:0] ALUOp;   //tells the alu_decoder what operation to perform
    output reg ALUSrcA;       //select SourceA of ALU (rs1 or imm)
    output reg [1:0] ALUSrcB; //select SourceB of ALU (rs2, imm, PC+4, any-other)
    
    //controlling Data movement (registers and memory)
    output reg RegWrite;      //enables writing to register file (reg_file)
    output reg MemWrite;      //enables writing to data memory (data_memory)
    output reg [1:0] ResultSrc;     //selects whether register gets values from
                               //(ALUResult) or (Data Memory) or (PC+4)
    
    //controlling Program flow (branching and jumping)
    output reg Branch;        //enables Branching
    output reg Jump;          //enables Jumping
    
    //controlling immediate type extraction
    output reg [2:0] ImmSrc;  //tells the control logic how to code immediate field
                               // I,S,B,J etc
                               //3 bits in order to choose among the 5-6 types
    //opcode types  
    localparam I_Load   = 7'b0000011;  //I type (for Load) 
    localparam S        = 7'b0100011;  //S type (for store)
    localparam R        = 7'b0110011;  //R type
    localparam B        = 7'b1100011;  //B type
    localparam I        = 7'b0010011;  //I type
    localparam J        = 7'b1101111;  //J type
    //localparam I_Jalr   = 7'b1100111;  //I type (for jalr)
    
   
    always @ (opcode) begin
        case (opcode)
        //RegWrite_ImmSrc_ALUSrcA_ALUSrcB_MemWrite_ResultSrc_Branch_ALUOp_Jump
     
        I_Load : {RegWrite,ImmSrc,ALUSrcA,ALUSrcB,MemWrite,ResultSrc,Branch,ALUOp,Jump} <= 14'b1_000_0_01_0_01_0_00_0;
        S      : {RegWrite,ImmSrc,ALUSrcA,ALUSrcB,MemWrite,ResultSrc,Branch,ALUOp,Jump} <= 14'b0_001_0_01_1_00_0_00_0;
        R      : {RegWrite,ImmSrc,ALUSrcA,ALUSrcB,MemWrite,ResultSrc,Branch,ALUOp,Jump} <= 14'b1_000_0_00_0_00_0_10_0;
        B      : {RegWrite,ImmSrc,ALUSrcA,ALUSrcB,MemWrite,ResultSrc,Branch,ALUOp,Jump} <= 14'b0_010_0_00_0_00_1_01_0;
        I      : {RegWrite,ImmSrc,ALUSrcA,ALUSrcB,MemWrite,ResultSrc,Branch,ALUOp,Jump} <= 14'b1_000_0_01_0_00_0_10_0;
        J      : {RegWrite,ImmSrc,ALUSrcA,ALUSrcB,MemWrite,ResultSrc,Branch,ALUOp,Jump} <= 14'b1_011_0_00_0_10_0_00_1;
        //I_Jalr : {RegWrite,ImmSrc,ALUSrcA,ALUSrcB,MemWrite,ResultSrc,Branch,ALUOp,Jump} <= 14'b1_000_0_01_0_10_0_00_1;

        default: {RegWrite,ImmSrc,ALUSrcA,ALUSrcB,MemWrite,ResultSrc,Branch,ALUOp,Jump} <= 14'b0_000_0_00_0_00_0_00_0;
        
        endcase
    end
     
endmodule
