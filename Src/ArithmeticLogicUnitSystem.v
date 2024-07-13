`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: ITU Computer Engineering Department
// Engineer: Taskin Okmen
// Project Name: BLG222E Project 1
//////////////////////////////////////////////////////////////////////////////////

module MUX_2TO1(
    input wire S,
    input wire [7:0] D0,
    input wire [7:0] D1,
    output reg [7:0] Q
    );
    
    always@(*) 
    begin
        case(S)
            1'b0: Q <= D0;
            1'b1: Q <= D1;
        endcase
    end
endmodule

module MUX_4TO1(
    input wire [1:0] S,
    input wire [15:0] D0, 
    input wire [15:0] D1,
    input wire [15:0] D2,
    input wire [15:0] D3,
    output reg [15:0] Q
    );

    always@(*) 
    begin
        case(S)
            2'b00: Q <= D0;
            2'b01: Q <= D1;
            2'b10: Q <= D2;
            2'b11: Q <= D3;
        endcase
    end
endmodule

module ArithmeticLogicUnitSystem(
        input wire [2:0] RF_OutASel,   input wire [2:0] RF_OutBSel, 
        input wire [2:0] RF_FunSel,    input wire [3:0] RF_RegSel,
        input wire [3:0] RF_ScrSel,    input wire [4:0] ALU_FunSel,
        input wire       ALU_WF,       input wire [1:0] ARF_OutCSel, 
        input wire [1:0] ARF_OutDSel,  input wire [2:0] ARF_FunSel,
        input wire [2:0] ARF_RegSel,   input wire       IR_LH,
        input wire       IR_Write,     input wire       Mem_WR,
        input wire       Mem_CS,       input wire [1:0] MuxASel,
        input wire [1:0] MuxBSel,      input wire       MuxCSel,
        input wire       Clock
    );
    
    // Arithmetic Logic Unit
    wire [15:0] ALUOut;
    wire [3:0] ALU_FlagsOut;
    
    // Instruction Register
    wire [15:0] IROut;
    
    // Register File
    wire [15:0] OutA;
    wire [15:0] OutB;
    
    // Address File Register
    wire [15:0] OutC;
    wire [15:0] OutD;
                                
    // Memory
    wire [7:0] MemOut;
    wire [15:0] Address;
    
    // MUX A
    wire [15:0] MuxAOut;
    
    // MUX B
    wire [15:0] MuxBOut;
    
    // MUX C
    wire [7:0] MuxCOut;
    
    assign Address = OutD;
    
    MUX_4TO1 MUXA(
        .S(MuxASel), 
        .D0(ALUOut), 
        .D1(OutC), 
        .D2({8'h00, MemOut}), 
        .D3({8'h00, IROut[7:0]}), 
        .Q(MuxAOut)
    );
    
    MUX_4TO1 MUXB(
        .S(MuxBSel), 
        .D0(ALUOut), 
        .D1(OutC), 
        .D2({8'h00, MemOut}), 
        .D3({8'h00, IROut[7:0]}), 
        .Q(MuxBOut)
    );    
   
    MUX_2TO1 MUXC(
        .S(MuxCSel), 
        .D0(ALUOut[7:0]), 
        .D1(ALUOut[15:8]), 
        .Q(MuxCOut)
    );
    
    ArithmeticLogicUnit ALU( .A(OutA), .B(OutB), .FunSel(ALU_FunSel), .WF(ALU_WF), 
                                .Clock(Clock), .ALUOut(ALUOut), .FlagsOut(ALU_FlagsOut));
    
    AddressRegisterFile ARF(.I(MuxBOut), .OutCSel(ARF_OutCSel), .OutDSel(ARF_OutDSel), 
                                                    .FunSel(ARF_FunSel), .RegSel(ARF_RegSel), .Clock(Clock), 
                                                    .OutC(OutC), .OutD(OutD));
    
    RegisterFile RF(.I(MuxAOut), .OutASel(RF_OutASel), .OutBSel(RF_OutBSel), 
                                                    .FunSel(RF_FunSel), .RegSel(RF_RegSel), .ScrSel(RF_ScrSel), 
                                                    .Clock(Clock), .OutA(OutA), .OutB(OutB));
    
    Memory MEM(
        .Address(Address),
        .Data(MuxCOut),
        .WR(Mem_WR),
        .CS(Mem_CS),
        .Clock(Clock),
        .MemOut(MemOut)
    );
    
    InstructionRegister IR(.I(MemOut), .Write(IR_Write), .LH(IR_LH), 
                                    .Clock(Clock), .IROut(IROut));
endmodule