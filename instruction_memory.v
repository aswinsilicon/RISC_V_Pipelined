
module instruction_memory(pc,instruction_data);
   
    input [31:0] pc;               //from program counter fetch
    output [31:0] instruction_data;     //output instruction, read from memory
    
    reg [7:0] RAM[0:65536];        //65536 x 8-bit = 64KB 
    
    assign instruction_data = {RAM[pc+3],RAM[pc+2],RAM[pc+1],RAM[pc+0]};
                                        //this fetches 4 8-bit RAM indices
    
    initial begin
        $readmemh("test1.hex",RAM);     //reading from test1 hex file
        $readmemh("test2.hex",RAM);     //reading from test2 hex file
        $readmemh("test3.hex",RAM);     //reading from test3 hex file
        $readmemh("test4.hex",RAM);     //reading from test4 hex file
        $readmemh("test5.hex",RAM);     //reading from test5 hex file
        $readmemh("test6.hex",RAM);     //reading from test6 hex file
        $readmemh("test7.hex",RAM);     //reading from test7 hex file
        $readmemh("test8.hex",RAM);     //reading from test8 hex file
        $readmemh("test9.hex",RAM);     //reading from test9 hex file
        $readmemh("test10.hex",RAM);    //reading from test10 hex file
        
    end 
          
endmodule
