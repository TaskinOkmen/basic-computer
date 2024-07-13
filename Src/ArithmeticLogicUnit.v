`timescale 1ns / 1ps

module ArithmeticLogicUnit(
    input wire [15:0] A,
    input wire [15:0] B,
    input wire [4:0] FunSel,
    input wire WF,
    input wire Clock,
    output reg [15:0] ALUOut,
    output reg [3:0] FlagsOut
    );
    
    // Zero, Carry, Negative, Overflow Flags
    reg Z = 0, C = 0, N = 0, O = 0;
    
    
    always @(*) 
    begin

        case(FunSel)
            
            // A (8-bit)
            5'b00000:
                begin
                    ALUOut = {8'h00, A[7:0]};
                    
                    if (WF) begin
                        Z = (ALUOut == 16'h0000) ? 1 : 0;
                        N = (ALUOut[7] == 1) ? 1 : 0;
                    end
                end
            

            // B (8-bit)
            5'b00001:
                begin
                    ALUOut = {8'h00, B[7:0]};
                    
                    if (WF) begin
                        Z = (ALUOut == 16'h0000) ? 1 : 0;
                        N = (ALUOut[7] == 1) ? 1 : 0;
                    end
                end            

            
            // NOT A (8-bit)
            5'b00010:
                begin
                    ALUOut = {8'h00, ~A[7:0]};
                    
                    if (WF) begin
                        Z = (ALUOut == 16'h0000) ? 1 : 0;
                        N = (ALUOut[7] == 1) ? 1 : 0;
                    end
                end
                
                
            // NOT B (8-bit)
            5'b00011:
                begin
                     ALUOut = {8'h00, ~B[7:0]};
                
                    if (WF) begin
                        Z = (ALUOut == 16'h0000) ? 1 : 0;
                        N = (ALUOut[7] == 1) ? 1 : 0;
                    end
                end
            
            
            // A + B (8-bit)
            5'b00100:
                begin
                    ALUOut = 16'h0000;
                    {C, ALUOut[7:0]} = {1'b0, A[7:0]} + {1'b0, B[7:0]};
                    
                    if (WF) begin
                        Z = (ALUOut == 16'h0000) ? 1 : 0;
                        N = (ALUOut[7] == 1) ? 1 : 0;
                        O = (A[7] == B[7] && A[7] != ALUOut[7]) ? 1 : 0;
                    end
                end                   
            
            
            // A + B + Carry (8-bit)
            5'b00101:
                begin
                    ALUOut = 16'h0000;
                    {C, ALUOut[7:0]} = {1'b0, A[7:0]} + {1'b0, B[7:0]} + {8'h00, FlagsOut[2]};
                
                    if (WF) begin
                        Z = (ALUOut == 16'h0000) ? 1 : 0;
                        N = (ALUOut[7] == 1) ? 1 : 0;
                        O = (A[7] == B[7] && A[7] != ALUOut[7]) ? 1 : 0;
                    end                    
                end       
            
            
            // A – B (8-bit)            
            5'b00110:
                begin
                    ALUOut = 16'h0000;
                    {C, ALUOut[7:0]} = {1'b0, A[7:0]} + {1'b0, (~B[7:0] + 8'd1)};

                    if (WF) begin
                        Z = (ALUOut == 16'h0000) ? 1 : 0;
                        N = (ALUOut[7] == 1) ? 1 : 0;
                        O = (A[7] != B[7] && B[7] == ALUOut[7]) ? 1 : 0;
                    end                
                end
                
                
            // A AND B (8-bit)
            5'b00111:
                begin
                    ALUOut = 16'h0000;
                    ALUOut[7:0] = A[7:0] & B[7:0];
                
                    if (WF) begin
                        Z = (ALUOut == 16'h0000) ? 1 : 0;
                        N = (ALUOut[7] == 1) ? 1 : 0;
                    end                    
                end
                
                
            // A OR B (8-bit)
            5'b01000:
                begin
                    ALUOut = 16'h0000;
                    ALUOut[7:0] = A[7:0] | B[7:0];
            
                    if (WF) begin
                        Z = (ALUOut == 16'h0000) ? 1 : 0;
                        N = (ALUOut[7] == 1) ? 1 : 0;
                    end                    
                end
            
            
            // A XOR B (8-bit)
            5'b01001:
                begin
                    ALUOut = 16'h0000;
                    ALUOut[7:0] = A[7:0] ^ B[7:0];
            
                    if (WF) begin
                        Z = (ALUOut == 16'h0000) ? 1 : 0;
                        N = (ALUOut[7] == 1) ? 1 : 0;
                    end                    
                end
            
            
            // A NAND B (8-bit)   
            5'b01010:
                begin
                    ALUOut = 16'h0000;
                    ALUOut[7:0] = ~(A[7:0] & B[7:0]);
            
                    if (WF) begin
                        Z = (ALUOut == 16'h0000) ? 1 : 0;
                        N = (ALUOut[7] == 1) ? 1 : 0;
                    end                    
                end
                
                
            // LSL A (8-bit)    
            5'b01011:
                begin
                    ALUOut = 16'h0000;
                    {C, ALUOut[7:0]} = {A[7:0], 1'b0};
            
                    if (WF) begin
                        Z = (ALUOut == 16'h0000) ? 1 : 0;
                        N = (ALUOut[7] == 1) ? 1 : 0;
                    end                    
                end            
            
            
            // LSR A (8-bit)
            5'b01100:
                begin
                    ALUOut = 16'h0000;
                    {ALUOut[7:0], C} = {1'b0, A[7:0]};
        
                    if (WF) begin
                        Z = (ALUOut == 16'h0000) ? 1 : 0;
                        N = (ALUOut[7] == 1) ? 1 : 0;
                    end                 
                end
                
                
            // ASR A (8-bit)
            5'b01101:
                begin
                    ALUOut = 16'h0000;
                    {ALUOut[7:0], C} = {A[7], A[7:0]};
    
                    if (WF) begin
                        Z = (ALUOut == 16'h0000) ? 1 : 0;
                    end                 
                end
                
                
            // CSL A (8-bit)
            5'b01110:
                begin
                    ALUOut = 16'h0000;
                    ALUOut[7:0] = {A[6:0], FlagsOut[2]};
                    C = A[7];

                    if (WF) begin
                        Z = (ALUOut == 16'h0000) ? 1 : 0;
                        N = (ALUOut[7] == 1) ? 1 : 0;
                    end                 
                end
                
                
            // CSR A (8-bit)
            5'b01111:
                begin
                    ALUOut = 16'h0000;
                    ALUOut[7:0] = {FlagsOut[2], A[7:1]};
                    C = A[0];

                    if (WF) begin
                        Z = (ALUOut == 16'h0000) ? 1 : 0;
                        N = (ALUOut[7] == 1) ? 1 : 0;
                    end                 
                end


            // A (16-bit)
            5'b10000:
                begin
                    ALUOut = A;
                    
                    if (WF) begin
                        Z = (ALUOut == 16'h0000) ? 1 : 0;
                        N = (ALUOut[15] == 1) ? 1 : 0;
                    end
                end
            

            // B (16-bit)
            5'b10001:
                begin
                    ALUOut = B;
                    
                    if (WF) begin
                        Z = (ALUOut == 16'h0000) ? 1 : 0;
                        N = (ALUOut[15] == 1) ? 1 : 0;
                    end
                end            

            
            // NOT A (16-bit)
            5'b10010:
                begin
                    ALUOut = ~A;
                    
                    if (WF) begin
                        Z = (ALUOut == 16'h0000) ? 1 : 0;
                        N = (ALUOut[15] == 1) ? 1 : 0;
                    end
                end
                
                
            // NOT B (16-bit)
            5'b10011:
                begin
                     ALUOut = ~B;
                
                    if (WF) begin
                        Z = (ALUOut == 16'h0000) ? 1 : 0;
                        N = (ALUOut[15] == 1) ? 1 : 0;
                    end
                end
            
            
            // A + B (16-bit)
            5'b10100:
                begin
                    {C, ALUOut} = {1'b0, A[15:0]} + {1'b0, B[15:0]};
                    
                    if (WF) begin
                        Z = (ALUOut == 16'h0000) ? 1 : 0;
                        N = (ALUOut[15] == 1) ? 1 : 0;
                        O = (A[15] == B[15] && A[15] != ALUOut[15]) ? 1 : 0;
                    end
                end                   
            
            
            // A + B + Carry (16-bit)
            5'b10101:
                begin
                    {C, ALUOut} = {1'b0, A[15:0]} + {1'b0, B[15:0]} + {16'h0000, FlagsOut[2]};
                
                    if (WF) begin
                        Z = (ALUOut == 16'h0000) ? 1 : 0;
                        N = (ALUOut[15] == 1) ? 1 : 0;
                        O = (A[15] == B[15] && A[15] != ALUOut[15]) ? 1 : 0;
                    end                    
                end       
            
            
            // A - B (16-bit)            
            5'b10110:
                begin
                    {C, ALUOut} = {1'b0, A} + {1'b0, (~B + 16'h0001)};

                    if (WF) begin
                        Z = (ALUOut == 16'h0000) ? 1 : 0;
                        N = (ALUOut[15] == 1) ? 1 : 0;
                        O = (A[15] != B[15] && B[15] == ALUOut[15]) ? 1 : 0;
                    end                
                end
                
                
            // A AND B (16-bit)
            5'b10111:
                begin
                    ALUOut = A & B;
                
                    if (WF) begin
                        Z = (ALUOut == 16'h0000) ? 1 : 0;
                        N = (ALUOut[15] == 1) ? 1 : 0;
                    end                    
                end
                
                
            // A OR B (16-bit)
            5'b11000:
                begin
                    ALUOut = A | B;
            
                    if (WF) begin
                        Z = (ALUOut == 16'h0000) ? 1 : 0;
                        N = (ALUOut[15] == 1) ? 1 : 0;
                    end                    
                end
            
            
            // A XOR B (16-bit)
            5'b11001:
                begin
                    ALUOut = A ^ B;
            
                    if (WF) begin
                        Z = (ALUOut == 16'h0000) ? 1 : 0;
                        N = (ALUOut[15] == 1) ? 1 : 0;
                    end                    
                end
            
            
            // A NAND B (16-bit)   
            5'b11010:
                begin
                    ALUOut = ~(A & B);
            
                    if (WF) begin
                        Z = (ALUOut == 16'h0000) ? 1 : 0;
                        N = (ALUOut[15] == 1) ? 1 : 0;
                    end                    
                end
                
                
            // LSL A (16-bit)    
            5'b11011:
                begin
                    {C, ALUOut} = {A, 1'b0};
            
                    if (WF) begin
                        Z = (ALUOut == 16'h0000) ? 1 : 0;
                        N = (ALUOut[15] == 1) ? 1 : 0;
                    end                    
                end            
            
            
            // LSR A (16-bit)
            5'b11100:
                begin
                    {ALUOut, C} = {1'b0, A};
        
                    if (WF) begin
                        Z = (ALUOut == 16'h0000) ? 1 : 0;
                        N = (ALUOut[15] == 1) ? 1 : 0;
                    end                 
                end
                
                
            // ASR A (16-bit)
            5'b11101:
                begin
                    {ALUOut, C} = {A[15], A};
    
                    if (WF) begin
                        Z = (ALUOut == 16'h0000) ? 1 : 0;
                    end                 
                end
                
                
            // CSL A (16-bit)
            5'b11110:
                begin
                    ALUOut = {A[14:0], FlagsOut[2]};
                    C = A[15];

                    if (WF) begin
                        Z = (ALUOut == 16'h0000) ? 1 : 0;
                        N = (ALUOut[15] == 1) ? 1 : 0;
                    end                 
                end
                
                
            // CSR A (8-bit)
            5'b11111:
                begin
                    ALUOut = {FlagsOut[2], A[15:1]};
                    C = A[0];

                    if (WF) begin
                        Z = (ALUOut == 16'h0000) ? 1 : 0;
                        N = (ALUOut[15] == 1) ? 1 : 0;
                    end                 
                end               
        endcase    
    end
    
    always @(posedge Clock)
    begin
        if (WF)
        begin
            FlagsOut <= {Z, C, N, O};
        end
        
        else
        begin
            FlagsOut <= FlagsOut;
        end
    end
endmodule