
module pc_mux(PCplus4F,JumpTargetE,PCSrcE,pc_next);


    input [31:0] PCplus4F;       //PC +4 value in IF stage
    input [31:0] JumpTargetE;   //Jumping to another address
     
    input PCSrcE;                //select pin from Control Unit
    
    output [31:0] pc_next;       //result of the selection
    //                            1              0
    assign pc_next = PCSrcE ? JumpTargetE : PCplus4F ;
    
endmodule
