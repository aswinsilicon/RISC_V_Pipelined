
module alu(SourceA,SourceB,ALUControl,ALUResult,Zero,Sign);

    input [31:0] SourceA;      //1st input: SourceA
    input [31:0] SourceB;      //2nd input: SourceB
    input [3:0] ALUControl;    //selects ALU operation
    output reg [31:0] ALUResult;   //result of ALU operation
    output Zero;               //stores 1 if ALUResult = 0
    output Sign;               //stores sign of the ALUResult
    
    wire [31:0] Sum;
    wire Overflow;
    
    assign Sum = SourceA + (ALUControl[0] ? ~SourceB : SourceB) + ALUControl[0]; 
    // if ALUControl[0] = 1, implement subtraction (using 2's complement)
    // if ALUControl[0] = 0, implement addition 
    
    assign Overflow = ~(ALUControl[0] ^ SourceB[31] ^ SourceA[31]) &  //checking if signs of operands(SourceA , SourceB) are same for addition / opposite for subtraction
                       (SourceA[31] ^ Sum[31]) &                      //checking if result sign = SourceA sign
                       (~ALUControl[1]);                              //disable checking for non Addition/Subtraction operations
    
    assign Zero = (ALUResult == 0)?1:0;  
      
    assign Sign = ALUResult[31];
    
    always @ (*) begin
    
        case (ALUControl)
            4'b0000: ALUResult = Sum;                                      //addition
            4'b0001: ALUResult = Sum;                                      //subtraction
            4'b0010: ALUResult = SourceA & SourceB;                        //and
            4'b0011: ALUResult = SourceA | SourceB;                        //or
            4'b0100: ALUResult = SourceA << SourceB;                       //sll, slli 
            4'b0101: ALUResult = ($signed(SourceA) < $signed(SourceB));     //slt, slti
            4'b0110: ALUResult = SourceA ^ SourceB;                        //xor
            4'b0111: ALUResult = SourceA >> SourceB;                       //srl
            4'b1000: ALUResult = ($unsigned(SourceA) < $unsigned(SourceB)); //sltu, sltiu
            4'b1111: ALUResult = SourceA >>> SourceB;                       //sra
            
            default: ALUResult = 32'bx;
        endcase
    end
endmodule

