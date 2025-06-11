
module immediate_extend(
    input  [31:7]     instr,    // Partial instruction (bits [31:7])
    input  [2:0]      imm_src,  // Immediate source selector
    output reg [31:0] imm_ext   // Sign-extended immediate output
);

    always @(*) begin
        case (imm_src)
        //I, I_Load-type
            3'b000: imm_ext = {{20{instr[31]}}, instr[31:20]};
            //Uses bits [31:20].
            //Sign-extends from bit 31
        //S-type
            3'b001: imm_ext = {{20{instr[31]}}, instr[31:25], instr[11:7]};
            //Uses bits [31:25] and [11:7] (split immediate)
            //Sign-extends from bit 31.
        //B-type
            3'b010: imm_ext = {{20{instr[31]}}, instr[7], instr[30:25], instr[11:8], 1'b0};
            //imm[12]    = instr[31]
            //imm[10:5]  = instr[30:25]
            //imm[4:1]   = instr[11:8]
            //imm[11]    = instr[7]
            //imm[0]     = 0 (LSB of offset is always 0 for alignment)
        //J-type
            3'b011: imm_ext = {{12{instr[31]}}, instr[19:12], instr[20], instr[30:21], 1'b0};
            //imm[20]    = instr[31]
            //imm[10:1]  = instr[30:21]
            //imm[11]    = instr[20]
            //imm[19:12] = instr[19:12]
            //imm[0]     = 0 (LSB always 0)
    
        default:imm_ext = 32'bx; 
        endcase    
    end

endmodule
