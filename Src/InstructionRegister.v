`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/22/2024 09:11:25 AM
// Design Name: 
// Module Name: InstructionRegister
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module InstructionRegister(
    input wire [7:0] I,
    input wire Write,
    input wire LH,
    input wire Clock,
    output reg [15:0] IROut
    );
    
    always @(posedge Clock)
        begin
            if (!Write)
            begin
                IROut <= IROut;
            end
            
            else
            begin
                case(LH)
                    1'b0:   IROut[7:0] <= I;
                    1'b1:   IROut[15:8] <= I;
                    
                    default:    IROut <= IROut;
                endcase
            end
        end
    
endmodule
