
module alu_decoder(opcodebit5,funct3,funct7bit5,ALUOp,ALUControl);

    input            opcodebit5;   // bit 5 of the opcode (op[5])
    input [2:0]      funct3;       // funct3 field of instruction
    input            funct7bit5;   // bit 5 of funct7 field (funct7[5])
    input [1:0]      ALUOp;        // ALU operation type from main_decoder
    output reg [3:0] ALUControl;   // control signal sent to the ALU
    
    wire RtypeSub;
    //opcode for R-type: 0110011
    assign RtypeSub = funct7bit5 & opcodebit5;    //True for R-type subtract
    
    always @ (*) begin
        case (ALUOp)
            2'b00: ALUControl = 4'b0000;          //addition (for lw, sw, jal)
            2'b01: ALUControl = 4'b0001;          //subtraction  (for branchings)
            
            2'b10: begin case (funct3)            //R-type or I-type ALU
            
                3'b000: if (RtypeSub)             //if R-Type bit 5 is 1
                            ALUControl = 4'b0001; //sub
                        else
                            ALUControl = 4'b0000; //add, addi 
                            
                3'b001:     ALUControl = 4'b0100; //sll, slli
                3'b010:     ALUControl = 4'b0101; //slt,slti
                3'b011:     ALUControl = 4'b1000; //sltu, sltiu
                3'b100:     ALUControl = 4'b0110; //xor, xori
                
                3'b101: if (funct7bit5)           //if funct7bit5 is 1
                            ALUControl = 4'b1111; //sra, srai
                        else
                            ALUControl = 4'b0111; //srl, srli 
                            
                3'b110:     ALUControl = 4'b0011; //or, ori
                3'b111:     ALUControl = 4'b0010; //and, andi
            default:        ALUControl = 4'b1010; //don't care
            endcase
            end
        endcase
    end
endmodule
