`timescale 1ns / 1ps


module counter(clk,reset,count,O);
    input wire clk,reset,count;
    output reg [3:0] O = 4'b1111;

    always@(posedge clk)
        begin
            if(reset)
                O <= 0;
            else if(count)
                O <= O + 1;
            else
                O <= O;
    end
endmodule

module decoder_4to16(enable,I,O);
    input wire enable;
    input wire [3:0] I;
    output reg [15:0] O;
    
    always @(*)
    begin
        if(enable) begin
        case(I)
            4'h0 : O = 16'h0001;
            4'h1 : O = 16'h0002;
            4'h2 : O = 16'h0004;
            4'h3 : O = 16'h0008;
            4'h4 : O = 16'h0010;
            4'h5 : O = 16'h0020;
            4'h6 : O = 16'h0040;
            4'h7 : O = 16'h0080;
            4'h8 : O = 16'h0100;
            4'h9 : O = 16'h0200;
            4'hA : O = 16'h0400;
            4'hB : O = 16'h0800;
            4'hC : O = 16'h1000;
            4'hD : O = 16'h2000;
            4'hE : O = 16'h4000;
            4'hF : O = 16'h8000;
            default : O = 0;
        endcase
        end
        else
        begin
            O = O;
        end
    end
endmodule

module decoder_6to64(enable,I,O);
    input wire enable;
    input wire [5:0] I;
    output reg [63:0] O;
    
    always @(*)
    begin
        if(enable) begin
        case(I)
            6'd00 : O = 64'h0000_0000_0000_0001;
            6'd01 : O = 64'h0000_0000_0000_0002;
            6'd02 : O = 64'h0000_0000_0000_0004;
            6'd03 : O = 64'h0000_0000_0000_0008;
            6'd04 : O = 64'h0000_0000_0000_0010;
            6'd05 : O = 64'h0000_0000_0000_0020;
            6'd06 : O = 64'h0000_0000_0000_0040;
            6'd07 : O = 64'h0000_0000_0000_0080;
            6'd08 : O = 64'h0000_0000_0000_0100;
            6'd09 : O = 64'h0000_0000_0000_0200;
            6'd10 : O = 64'h0000_0000_0000_0400;
            6'd11 : O = 64'h0000_0000_0000_0800;
            6'd12 : O = 64'h0000_0000_0000_1000;
            6'd13 : O = 64'h0000_0000_0000_2000;
            6'd14 : O = 64'h0000_0000_0000_4000;
            6'd15 : O = 64'h0000_0000_0000_8000;

            6'd16 : O = 64'h0000_0000_0001_0000;
            6'd17 : O = 64'h0000_0000_0002_0000;
            6'd18 : O = 64'h0000_0000_0004_0000;
            6'd19 : O = 64'h0000_0000_0008_0000;
            6'd20 : O = 64'h0000_0000_0010_0000;
            6'd21 : O = 64'h0000_0000_0020_0000;
            6'd22 : O = 64'h0000_0000_0040_0000;
            6'd23 : O = 64'h0000_0000_0080_0000;
            6'd24 : O = 64'h0000_0000_0100_0000;
            6'd25 : O = 64'h0000_0000_0200_0000;
            6'd26 : O = 64'h0000_0000_0400_0000;
            6'd27 : O = 64'h0000_0000_0800_0000;
            6'd28 : O = 64'h0000_0000_1000_0000;
            6'd29 : O = 64'h0000_0000_2000_0000;
            6'd30 : O = 64'h0000_0000_4000_0000;
            6'd31 : O = 64'h0000_0000_8000_0000;
            
            6'd32 : O = 64'h0000_0001_0000_0000;
            6'd33 : O = 64'h0000_0002_0000_0000;

            default : O = 0;
        endcase
        end
        else
        begin
            O = O;
        end
    end
endmodule

module fetch_L(T0, ARF_FunSel, ARF_RegSel, OutDSel, CS, WR, LH, IR_Write);
    input wire T0;
    output reg [2:0] ARF_FunSel;
    output reg [2:0] ARF_RegSel;
    output reg [1:0] OutDSel;
    output reg CS;
    output reg WR;
    output reg LH;
    output reg IR_Write;
    
    
    always @(T0)
    begin
        if(T0)
        begin
            // IR[7:0] <= Mem[PC]
            OutDSel <= 2'b00;
            CS <= 1'b0;
            WR <= 1'b0;
            LH <= 1'b0;
            IR_Write <= 1'b1;
            
            // PC <= PC + 1
            ARF_RegSel <= 3'b011;
            ARF_FunSel <= 3'b001;
        end
        else
        begin
            
            OutDSel <= 2'bZZ;
            CS <= 1'bZ;
            WR <= 1'bZ;
            LH <= 1'bZ;
            IR_Write <= 1'bZ;
        
            
            ARF_RegSel <= 3'bZZZ;
            ARF_FunSel <= 3'bZZZ;
        end
        end
endmodule

module fetch_H(T1, ARF_FunSel, ARF_RegSel, OutDSel, CS, WR, LH, IR_Write);
    input wire T1;
    output reg [2:0] ARF_FunSel;
    output reg [2:0] ARF_RegSel;
    output reg [1:0] OutDSel;
    output reg CS;
    output reg WR;
    output reg LH;
    output reg IR_Write;
    
    
    always @(T1)
    begin
        if(T1)
        begin
            // IR[7:0] <= Mem[PC]
            OutDSel <= 2'b00;
            CS <= 1'b0;
            WR <= 1'b0;
            LH <= 1'b1;
            IR_Write <= 1'b1;
            
            // PC <= PC + 1
            ARF_RegSel <= 3'b011;
            ARF_FunSel <= 3'b001;
        end
        else
        begin
            
            OutDSel <= 2'bZZ;
            CS <= 1'bZ;
            WR <= 1'bZ;
            LH <= 1'bZ;
            IR_Write <= 1'bZ;
        
            
            ARF_RegSel <= 3'bZZZ;
            ARF_FunSel <= 3'bZZZ;
        end
        end
endmodule

//Rx = D: 3, 4, 18, 19, 30, 32, 33
module control_unit(clk, IROut, ARF_FunSel, ARF_RegSel, ARF_OutCSel, ARF_OutDSel, 
    ALU_FlagReg, ALU_FunSel, RF_OutASel, RF_OutBSel, RF_FunSel, RF_RegSel, RF_ScrSel,
    MuxASel, MuxBSel, MuxCSel, Mem_CS, Mem_WR, IR_LH, IR_Write, SC_Reset, ALU_WF, T);

    input wire clk;
    input wire [15:0] IROut;
    input wire [3:0] ALU_FlagReg;
    
    output reg SC_Reset;
    output reg [2:0] ARF_FunSel;
    output reg [2:0] ARF_RegSel;
    output reg [1:0] ARF_OutCSel;
    output reg [1:0] ARF_OutDSel;
    output reg [4:0] ALU_FunSel;
    output reg [2:0] RF_OutASel;
    output reg [2:0] RF_OutBSel;
    output reg [2:0] RF_FunSel;
    output reg [3:0] RF_RegSel;
    output reg [3:0] RF_ScrSel;
    output reg ALU_WF;

    output reg [1:0] MuxASel;
    output reg [1:0] MuxBSel;
    output reg MuxCSel;

    output reg Mem_CS;
    output reg Mem_WR;
    output reg IR_LH;
    output reg IR_Write;

    output wire [15:0] T;
    wire [3:0] temp;
    
    counter SC(clk,SC_Reset,1'b1,temp);
    decoder_4to16 SC_decoder(1'b1,temp,T); 


    initial begin
        Mem_WR <= 1'b0;
        Mem_CS <= 1'b1;
        ARF_FunSel <= 3'b000;
        RF_FunSel <= 3'b000;
        RF_RegSel <= 4'b1111;
        ARF_RegSel <= 3'b111;
        RF_ScrSel <= 4'b1111;
        SC_Reset <= 1;
        
        #6;
        RF_RegSel <= 4'b1111;
        ARF_RegSel <= 3'b111;
        RF_ScrSel <= 4'b1111;
        SC_Reset <= 0;
        #4;
    end    
        
    // Decode cycle, D15, ... D1, D0 <- IROut[15:10]
    wire [63:0] D;
    decoder_6to64 step3(T[2], IROut[15:10], D);
    
    // Instructions with address reference
    wire [1:0] RSEL = IROut[9:8];
    wire [7:0] ADDRESS = IROut[7:0];
    
    // Instructions without an address reference: Rx based
    wire S = IROut[9];
    wire [2:0] DSTREG = IROut[8:6];
    wire [2:0] SREG1 = IROut[5:3];
    wire [2:0] SREG2 = IROut[2:0];
    wire Z = ALU_FlagReg[3];

    reg [1:0] sources = 2'b00;      
    
    always @(negedge clk) begin
        // Fetch and Decode Cycles T0, T1
        if(T[0])
        begin
            // Counter
            SC_Reset <= 0;
            
            // IR[7:0] <= Mem[PC]
            ARF_OutDSel <= 2'b00;
            Mem_CS <= 1'b0;
            Mem_WR <= 1'b0;
            IR_LH <= 1'b0;
            IR_Write <= 1'b1;
        
            // PC <= PC + 1
            ARF_RegSel <= 3'b011;
            ARF_FunSel <= 3'b001;
        end
 
        if (T[1])
        begin
            // IR[15:8] <= Mem[PC]
            ARF_OutDSel <= 2'b00;
            Mem_CS <= 1'b0;
            Mem_WR <= 1'b0;
            IR_LH <= 1'b1;
            IR_Write <= 1'b1;
    
            // PC <= PC + 1
            ARF_RegSel <= 3'b011;
            ARF_FunSel <= 3'b001;
        end
        
        if (T[2]) begin
            ARF_RegSel <= 3'b111;   
            IR_Write <= 1'b0;
        end
        
        /* Instruction: BRA, BNE, BEQ: PC <- PC + VAL */
        if (D[0] || (D[1] && ~Z) || (D[2] && Z)) begin
            //  R1 <- IR[7:0]
            if (T[2]) begin
                MuxASel <= 2'b11;
                RF_ScrSel <= 4'b0111;
                RF_FunSel <= 3'b010;
            end
            // R2 <- PC
            if (T[3]) begin
                MuxASel <= 2'b01;
                ARF_OutCSel <= 2'b00;
                RF_ScrSel <= 4'b1011;
                RF_FunSel <= 3'b010;
            end 
            // PC <- R1 + R2
            if (T[4]) begin
                RF_OutASel <= 3'b100;
                RF_OutBSel <= 3'b101;
                ALU_FunSel <= 5'b10100;
                RF_RegSel <= 4'b1111;
                MuxBSel <= 2'b00;
                
                ARF_RegSel <= 3'b011;
                ARF_FunSel <= 3'b010;
                RF_ScrSel <= 4'b1111;
            end
            
            if (T[5]) begin
                RF_RegSel <= 4'b1111;
                RF_ScrSel <= 4'b1111;
                ARF_RegSel <= 3'b111;
                SC_Reset <= 1;
            end
        end
        /* -------------------------------- */
        
        /* Instruction: INC: DESTRG <- SREG1 + 1 */
        if (D[5]) begin
            //  DSTREG <- SREG1
            //  DSTREG <- DSTREG + 1
            if (T[2]) begin
                if ((SREG1[2] == 1)) begin  // SREG1 in RF
                    RF_OutASel <= {1'b0, SREG1[1:0]};
                    ALU_FunSel <= 5'b10000;
                
                    if (DSTREG[2] == 1) begin // DSTREG in RF
                        MuxASel <= 2'b00;
                        RF_FunSel <= 3'b010;
                    
                        case (DSTREG[1:0])
                            2'b00: RF_RegSel <= 4'b0111;
                            2'b01: RF_RegSel <= 4'b1011;
                            2'b10: RF_RegSel <= 4'b1101;
                            2'b11: RF_RegSel <= 4'b1110;
                        endcase
                    end
                    else begin // DSTREG in ARF
                        MuxBSel <= 2'b00;
                        ARF_FunSel <= 3'b010;
                    
                        case (DSTREG[1:0])
                            2'b00: ARF_RegSel <= 3'b011;
                            2'b01: ARF_RegSel <= 3'b011;
                            2'b10: ARF_RegSel <= 3'b110;
                            2'b11: ARF_RegSel <= 3'b101;
                        endcase                   
                    end
                end
                else begin // SREG1 in ARF
                    
                    case (SREG1[1:0])
                        2'b00: ARF_OutCSel <= 2'b00;
                        2'b01: ARF_OutCSel <= 2'b00;
                        2'b10: ARF_OutCSel <= 2'b11;
                        2'b11: ARF_OutCSel <= 2'b10;
                    endcase               
                    
                    if (DSTREG[2] == 1) begin // DSTREG in RF
                        MuxASel <= 2'b01;
                        RF_FunSel <= 3'b010;
                        case (DSTREG[1:0])
                            2'b00: RF_RegSel <= 4'b0111;
                            2'b01: RF_RegSel <= 4'b1011;
                            2'b10: RF_RegSel <= 4'b1101;
                            2'b11: RF_RegSel <= 4'b1110;
                        endcase                       
                    end
                    else begin
                        MuxBSel <= 2'b01;
                        ARF_FunSel <= 3'b010;
                
                        case (DSTREG[1:0])
                            2'b00: ARF_RegSel <= 3'b011;
                            2'b01: ARF_RegSel <= 3'b011;
                            2'b10: ARF_RegSel <= 3'b110;
                            2'b11: ARF_RegSel <= 3'b101;
                        endcase                   
                    end
                end
            end
           
            
            if (T[3]) begin
                
                if (DSTREG[2] == 1) begin // DSTREG in RF
                    RF_FunSel <= 3'b001;
                    ARF_RegSel <= 3'b111;
                    case (DSTREG[1:0])
                        2'b00: RF_RegSel <= 4'b0111;
                        2'b01: RF_RegSel <= 4'b1011;
                        2'b10: RF_RegSel <= 4'b1101;
                        2'b11: RF_RegSel <= 4'b1110;
                    endcase              
                end
                else begin
                    ARF_FunSel <= 3'b001;
                    RF_RegSel <= 4'b1111;
                    case (DSTREG[1:0])
                        2'b00: ARF_RegSel <= 3'b011;
                        2'b01: ARF_RegSel <= 3'b011;
                        2'b10: ARF_RegSel <= 3'b110;
                        2'b11: ARF_RegSel <= 3'b101;
                    endcase                    
                end
            end
            
            if (T[4]) begin
                RF_RegSel <= 4'b1111;
                ARF_RegSel <= 3'b111;
                SC_Reset <= 1;
            end
        end
        /* ------------------------------------- */
        
        /* Instruction: DEC: DESTRG <- SREG1 - 1 */
        if (D[6]) begin
            //  DSTREG <- SREG1
            //  DSTREG <- DSTREG + 1
            if (T[2]) begin
                if ((SREG1[2] == 1)) begin  // SREG1 in RF
                    RF_OutASel <= {1'b0, SREG1[1:0]};
                    ALU_FunSel <= 5'b10000;
                
                    if (DSTREG[2] == 1) begin // DSTREG in RF
                        MuxASel <= 2'b00;
                        RF_FunSel <= 3'b010;
                    
                        case (DSTREG[1:0])
                            2'b00: RF_RegSel <= 4'b0111;
                            2'b01: RF_RegSel <= 4'b1011;
                            2'b10: RF_RegSel <= 4'b1101;
                            2'b11: RF_RegSel <= 4'b1110;
                        endcase
                    end
                    else begin // DSTREG in ARF
                        MuxBSel <= 2'b00;
                        ARF_FunSel <= 3'b010;
                    
                        case (DSTREG[1:0])
                            2'b00: ARF_RegSel <= 3'b011;
                            2'b01: ARF_RegSel <= 3'b011;
                            2'b10: ARF_RegSel <= 3'b110;
                            2'b11: ARF_RegSel <= 3'b101;
                        endcase                   
                    end
                end
                else begin // SREG1 in ARF
                    
                    case (SREG1[1:0])
                        2'b00: ARF_OutCSel <= 2'b00;
                        2'b01: ARF_OutCSel <= 2'b00;
                        2'b10: ARF_OutCSel <= 2'b11;
                        2'b11: ARF_OutCSel <= 2'b10;
                    endcase               
                    
                    if (DSTREG[2] == 1) begin // DSTREG in RF
                        MuxASel <= 2'b01;
                        RF_FunSel <= 3'b010;
                        case (DSTREG[1:0])
                            2'b00: RF_RegSel <= 4'b0111;
                            2'b01: RF_RegSel <= 4'b1011;
                            2'b10: RF_RegSel <= 4'b1101;
                            2'b11: RF_RegSel <= 4'b1110;
                        endcase                       
                    end
                    else begin
                        MuxBSel <= 2'b01;
                        ARF_FunSel <= 3'b010;
                
                        case (DSTREG[1:0])
                            2'b00: ARF_RegSel <= 3'b011;
                            2'b01: ARF_RegSel <= 3'b011;
                            2'b10: ARF_RegSel <= 3'b110;
                            2'b11: ARF_RegSel <= 3'b101;
                        endcase                   
                    end
                end
            end
           
            
            if (T[3]) begin
                
                if (DSTREG[2] == 1) begin // DSTREG in RF
                    RF_FunSel <= 3'b000;
                    ARF_RegSel <= 3'b111;
                    case (DSTREG[1:0])
                        2'b00: RF_RegSel <= 4'b0111;
                        2'b01: RF_RegSel <= 4'b1011;
                        2'b10: RF_RegSel <= 4'b1101;
                        2'b11: RF_RegSel <= 4'b1110;
                    endcase              
                end
                else begin
                    ARF_FunSel <= 3'b000;
                    RF_RegSel <= 4'b1111;
                    case (DSTREG[1:0])
                        2'b00: ARF_RegSel <= 3'b011;
                        2'b01: ARF_RegSel <= 3'b011;
                        2'b10: ARF_RegSel <= 3'b110;
                        2'b11: ARF_RegSel <= 3'b101;
                    endcase                    
                end
            end
            
            if (T[4]) begin
                RF_RegSel <= 4'b1111;
                ARF_RegSel <= 3'b111;
                SC_Reset <= 1;
            end
        end
        /* ------------------------------------- */        
        
        /* Instruction: MOVS: DSTREG <- SREG1 */
        if (D[24]) begin 
            if (T[2]) begin
                ALU_WF <= 1'b1;
                if (SREG1[2] == 1) begin // SREG1 in RF
                    RF_OutASel <= {1'b0, SREG1[1:0]};
                    ALU_FunSel <= 5'b10000;
                end
                else begin  // SREG1 in ARF
                    case (SREG1[1:0])
                        2'b00: ARF_OutCSel <= 2'b00;
                        2'b01: ARF_OutCSel <= 2'b00;
                        2'b10: ARF_OutCSel <= 2'b11;
                        2'b11: ARF_OutCSel <= 2'b10;
                    endcase                   
                end
                
                if (SREG1[2] == 1 && DSTREG[2] == 1) begin // both in RF
                    MuxASel <= 2'b00;
                    RF_FunSel <= 3'b010;
                    RF_RegSel <= {1'b0, DSTREG[1:0]};
                end
                if (SREG1[2] == 1 && DSTREG[2] == 0) begin // DSTREG in ARF
                    MuxBSel <= 2'b00;
                    ARF_FunSel <= 3'b010;
                    case (DSTREG[1:0])
                        2'b00: ARF_RegSel <= 3'b011;
                        2'b01: ARF_RegSel <= 3'b011;
                        2'b10: ARF_RegSel <= 3'b110;
                        2'b11: ARF_RegSel <= 3'b101;
                    endcase 
                end
                if (SREG1[2] == 0 && DSTREG[2] == 1) begin // DSTREG in RF
                    MuxASel <= 2'b01;
                    RF_FunSel <= 3'b010;
                    RF_RegSel <= {1'b0, DSTREG[1:0]};
                end
                if (SREG1[2] == 0 && DSTREG[2] == 0) begin // DSTREG in ARF
                    MuxBSel <= 2'b01;
                    ARF_FunSel <= 3'b010;
                    case (DSTREG[1:0])
                        2'b00: ARF_RegSel <= 3'b011;
                        2'b01: ARF_RegSel <= 3'b011;
                        2'b10: ARF_RegSel <= 3'b110;
                        2'b11: ARF_RegSel <= 3'b101;
                    endcase 
                end
            end
            if (T[3]) begin
                RF_RegSel <= 4'b1111;
                ARF_RegSel <= 3'b111;
                ALU_WF <= 1'b0;
                SC_Reset <= 1;                
            end
        end
        /* ------------------------------------- */
        
        /* Instruction: XOR: DSTREG <- SREG1 XOR SREG2 */
        if (D[15] || D[29]) begin
            if (T[2] && SREG1[2] == 0) begin    // SREG1 in ARF
                MuxASel <= 2'b01;
                RF_ScrSel <= 4'b0111;
                RF_FunSel <= 3'b010;
                case (SREG1[1:0])
                    2'b00: ARF_OutCSel <= 2'b00;
                    2'b01: ARF_OutCSel <= 2'b00;
                    2'b10: ARF_OutCSel <= 2'b11;
                    2'b11: ARF_OutCSel <= 2'b10;
                endcase
            end
            
            if (T[3] && SREG2[2] == 0) begin    // SREG2 in ARF
                MuxASel <= 2'b01;
                RF_ScrSel <= 4'b1011;
                RF_FunSel <= 3'b010;
                case (SREG2[1:0])
                    2'b00: ARF_OutCSel <= 2'b00;
                    2'b01: ARF_OutCSel <= 2'b00;
                    2'b10: ARF_OutCSel <= 2'b11;
                    2'b11: ARF_OutCSel <= 2'b10;
                endcase
            end
            
            if (T[4]) begin
                RF_ScrSel <= 4'b1111;
                ALU_FunSel <= 5'b11001;
                if (D[29]) begin
                    ALU_WF <= 1;
                end               
                if (SREG1[2] == 1) begin
                    RF_OutASel <= {1'b0, SREG1[1:0]};
                end
                else begin
                    RF_OutASel <= 3'b100;
                end
                if (SREG2[2] == 1) begin
                    RF_OutBSel <= {1'b0, SREG2[1:0]};
                end
                else begin
                    RF_OutBSel <= 3'b101;
                end
                
                if (DSTREG[2] == 1) begin // DSTREG in RF
                    MuxASel <= 2'b00;
                    RF_FunSel <= 3'b010;
                
                    case (DSTREG[1:0])
                        2'b00: RF_RegSel <= 4'b0111;
                        2'b01: RF_RegSel <= 4'b1011;
                        2'b10: RF_RegSel <= 4'b1101;
                        2'b11: RF_RegSel <= 4'b1110;
                    endcase
                end
                else begin // DSTREG in ARF
                    MuxBSel <= 2'b00;
                    ARF_FunSel <= 3'b010;
                
                    case (DSTREG[1:0])
                        2'b00: ARF_RegSel <= 3'b011;
                        2'b01: ARF_RegSel <= 3'b011;
                        2'b10: ARF_RegSel <= 3'b110;
                        2'b11: ARF_RegSel <= 3'b101;
                    endcase                   
                end           
            end
            
            if (T[5]) begin
                ARF_RegSel <= 3'b111;
                RF_RegSel <= 4'b1111;
                ALU_WF <= 0;
                SC_Reset <= 1;
            end
        end
        /* ------------------------------------- */
        
        /* Instruction: AND: DSTREG <- SREG1 AND SREG2 */
        if (D[12] || D[27]) begin
            if (T[2] && SREG1[2] == 0) begin    // SREG1 in ARF
                MuxASel <= 2'b01;
                RF_ScrSel <= 4'b0111;
                RF_FunSel <= 3'b010;
                case (SREG1[1:0])
                    2'b00: ARF_OutCSel <= 2'b00;
                    2'b01: ARF_OutCSel <= 2'b00;
                    2'b10: ARF_OutCSel <= 2'b11;
                    2'b11: ARF_OutCSel <= 2'b10;
                endcase
            end
            
            if (T[3] && SREG2[2] == 0) begin    // SREG2 in ARF
                MuxASel <= 2'b01;
                RF_ScrSel <= 4'b1011;
                RF_FunSel <= 3'b010;
                case (SREG2[1:0])
                    2'b00: ARF_OutCSel <= 2'b00;
                    2'b01: ARF_OutCSel <= 2'b00;
                    2'b10: ARF_OutCSel <= 2'b11;
                    2'b11: ARF_OutCSel <= 2'b10;
                endcase
            end
            
            if (T[4]) begin
                RF_ScrSel <= 4'b1111;
                ALU_FunSel <= 5'b10111;
                if (D[27]) begin
                    ALU_WF <= 1;
                end
                if (SREG1[2] == 1) begin
                    RF_OutASel <= {1'b0, SREG1[1:0]};
                end
                else begin
                    RF_OutASel <= 3'b100;
                end
                if (SREG2[2] == 1) begin
                    RF_OutBSel <= {1'b0, SREG2[1:0]};
                end
                else begin
                    RF_OutBSel <= 3'b101;
                end
                
                if (DSTREG[2] == 1) begin // DSTREG in RF
                    MuxASel <= 2'b00;
                    RF_FunSel <= 3'b010;
                
                    case (DSTREG[1:0])
                        2'b00: RF_RegSel <= 4'b0111;
                        2'b01: RF_RegSel <= 4'b1011;
                        2'b10: RF_RegSel <= 4'b1101;
                        2'b11: RF_RegSel <= 4'b1110;
                    endcase
                end
                else begin // DSTREG in ARF
                    MuxBSel <= 2'b00;
                    ARF_FunSel <= 3'b010;
                
                    case (DSTREG[1:0])
                        2'b00: ARF_RegSel <= 3'b011;
                        2'b01: ARF_RegSel <= 3'b011;
                        2'b10: ARF_RegSel <= 3'b110;
                        2'b11: ARF_RegSel <= 3'b101;
                    endcase                   
                end           
            end
            if (T[5]) begin
                ARF_RegSel <= 3'b111;
                RF_RegSel <= 4'b1111;
                ALU_WF <= 0;
                SC_Reset <= 1;
            end
        end
        /* ------------------------------------- */         
    
        /* Instruction: OR: DSTREG <- SREG1 OR SREG2 */
        if (D[13] || D[28]) begin
            if (T[2] && SREG1[2] == 0) begin    // SREG1 in ARF
                MuxASel <= 2'b01;
                RF_ScrSel <= 4'b0111;
                RF_FunSel <= 3'b010;
                case (SREG1[1:0])
                    2'b00: ARF_OutCSel <= 2'b00;
                    2'b01: ARF_OutCSel <= 2'b00;
                    2'b10: ARF_OutCSel <= 2'b11;
                    2'b11: ARF_OutCSel <= 2'b10;
                endcase
            end
            
            if (T[3] && SREG2[2] == 0) begin    // SREG2 in ARF
                MuxASel <= 2'b01;
                RF_ScrSel <= 4'b1011;
                RF_FunSel <= 3'b010;
                case (SREG2[1:0])
                    2'b00: ARF_OutCSel <= 2'b00;
                    2'b01: ARF_OutCSel <= 2'b00;
                    2'b10: ARF_OutCSel <= 2'b11;
                    2'b11: ARF_OutCSel <= 2'b10;
                endcase
            end
            
            if (T[4]) begin
                RF_ScrSel <= 4'b1111;
                ALU_FunSel <= 5'b11000;
                if (D[28]) begin
                    ALU_WF <= 1;
                end
                if (SREG1[2] == 1) begin
                    RF_OutASel <= {1'b0, SREG1[1:0]};
                end
                else begin
                    RF_OutASel <= 3'b100;
                end
                if (SREG2[2] == 1) begin
                    RF_OutBSel <= {1'b0, SREG2[1:0]};
                end
                else begin
                    RF_OutBSel <= 3'b101;
                end
                
                if (DSTREG[2] == 1) begin // DSTREG in RF
                    MuxASel <= 2'b00;
                    RF_FunSel <= 3'b010;
                
                    case (DSTREG[1:0])
                        2'b00: RF_RegSel <= 4'b0111;
                        2'b01: RF_RegSel <= 4'b1011;
                        2'b10: RF_RegSel <= 4'b1101;
                        2'b11: RF_RegSel <= 4'b1110;
                    endcase
                end
                else begin // DSTREG in ARF
                    MuxBSel <= 2'b00;
                    ARF_FunSel <= 3'b010;
                
                    case (DSTREG[1:0])
                        2'b00: ARF_RegSel <= 3'b011;
                        2'b01: ARF_RegSel <= 3'b011;
                        2'b10: ARF_RegSel <= 3'b110;
                        2'b11: ARF_RegSel <= 3'b101;
                    endcase                   
                end           
            end
            if (T[5]) begin
                ARF_RegSel <= 3'b111;
                RF_RegSel <= 4'b1111;
                ALU_WF <= 0;
                SC_Reset <= 1;
            end
        end
        /* ------------------------------------- */   

        /* Instruction: NAND: DSTREG <- SREG1 NAND SREG2 */
        if (D[16]) begin
            if (T[2] && SREG1[2] == 0) begin    // SREG1 in ARF
                MuxASel <= 2'b01;
                RF_ScrSel <= 4'b0111;
                RF_FunSel <= 3'b010;
                case (SREG1[1:0])
                    2'b00: ARF_OutCSel <= 2'b00;
                    2'b01: ARF_OutCSel <= 2'b00;
                    2'b10: ARF_OutCSel <= 2'b11;
                    2'b11: ARF_OutCSel <= 2'b10;
                endcase
            end
            
            if (T[3] && SREG2[2] == 0) begin    // SREG2 in ARF
                MuxASel <= 2'b01;
                RF_ScrSel <= 4'b1011;
                RF_FunSel <= 3'b010;
                case (SREG2[1:0])
                    2'b00: ARF_OutCSel <= 2'b00;
                    2'b01: ARF_OutCSel <= 2'b00;
                    2'b10: ARF_OutCSel <= 2'b11;
                    2'b11: ARF_OutCSel <= 2'b10;
                endcase
            end
            
            if (T[4]) begin
                RF_ScrSel <= 4'b1111;
                ALU_FunSel <= 5'b11010;
                if (SREG1[2] == 1) begin
                    RF_OutASel <= {1'b0, SREG1[1:0]};
                end
                else begin
                    RF_OutASel <= 3'b100;
                end
                if (SREG2[2] == 1) begin
                    RF_OutBSel <= {1'b0, SREG2[1:0]};
                end
                else begin
                    RF_OutBSel <= 3'b101;
                end
                
                if (DSTREG[2] == 1) begin // DSTREG in RF
                    MuxASel <= 2'b00;
                    RF_FunSel <= 3'b010;
                
                    case (DSTREG[1:0])
                        2'b00: RF_RegSel <= 4'b0111;
                        2'b01: RF_RegSel <= 4'b1011;
                        2'b10: RF_RegSel <= 4'b1101;
                        2'b11: RF_RegSel <= 4'b1110;
                    endcase
                end
                else begin // DSTREG in ARF
                    MuxBSel <= 2'b00;
                    ARF_FunSel <= 3'b010;
                
                    case (DSTREG[1:0])
                        2'b00: ARF_RegSel <= 3'b011;
                        2'b01: ARF_RegSel <= 3'b011;
                        2'b10: ARF_RegSel <= 3'b110;
                        2'b11: ARF_RegSel <= 3'b101;
                    endcase                   
                end           
            end
            if (T[5]) begin
                ARF_RegSel <= 3'b111;
                RF_RegSel <= 4'b1111;
                SC_Reset <= 1;
            end
        end
        /* ------------------------------------- */  

        /* Instruction: ADD: DSTREG <- SREG1 + SREG2 */
        if (D[21] || D[22] || D[25]) begin
            if (T[2] && SREG1[2] == 0) begin    // SREG1 in ARF
                MuxASel <= 2'b01;
                RF_ScrSel <= 4'b0111;
                RF_FunSel <= 3'b010;
                case (SREG1[1:0])
                    2'b00: ARF_OutCSel <= 2'b00;
                    2'b01: ARF_OutCSel <= 2'b00;
                    2'b10: ARF_OutCSel <= 2'b11;
                    2'b11: ARF_OutCSel <= 2'b10;
                endcase
            end
            
            if (T[3] && SREG2[2] == 0) begin    // SREG2 in ARF
                MuxASel <= 2'b01;
                RF_ScrSel <= 4'b1011;
                RF_FunSel <= 3'b010;
                case (SREG2[1:0])
                    2'b00: ARF_OutCSel <= 2'b00;
                    2'b01: ARF_OutCSel <= 2'b00;
                    2'b10: ARF_OutCSel <= 2'b11;
                    2'b11: ARF_OutCSel <= 2'b10;
                endcase
            end
            
            if (T[4]) begin
                RF_ScrSel <= 4'b1111;
                ALU_FunSel <= (D[22] == 1) ? 5'b10101: 5'b10100;
                if (D[25]) begin
                    ALU_WF <= 1;
                end
                 
                if (SREG1[2] == 1) begin
                    RF_OutASel <= {1'b0, SREG1[1:0]};
                end
                else begin
                    RF_OutASel <= 3'b100;
                end
                if (SREG2[2] == 1) begin
                    RF_OutBSel <= {1'b0, SREG2[1:0]};
                end
                else begin
                    RF_OutBSel <= 3'b101;
                end
                
                if (DSTREG[2] == 1) begin // DSTREG in RF
                    MuxASel <= 2'b00;
                    RF_FunSel <= 3'b010;
                
                    case (DSTREG[1:0])
                        2'b00: RF_RegSel <= 4'b0111;
                        2'b01: RF_RegSel <= 4'b1011;
                        2'b10: RF_RegSel <= 4'b1101;
                        2'b11: RF_RegSel <= 4'b1110;
                    endcase
                end
                else begin // DSTREG in ARF
                    MuxBSel <= 2'b00;
                    ARF_FunSel <= 3'b010;
                
                    case (DSTREG[1:0])
                        2'b00: ARF_RegSel <= 3'b011;
                        2'b01: ARF_RegSel <= 3'b011;
                        2'b10: ARF_RegSel <= 3'b110;
                        2'b11: ARF_RegSel <= 3'b101;
                    endcase                   
                end           
            end
            if (T[5]) begin
                ARF_RegSel <= 3'b111;
                RF_RegSel <= 4'b1111;
                ALU_WF <= 0;
                SC_Reset <= 1;
            end
        end
        /* ------------------------------------- */    

        /* Instruction: SUB: DSTREG <- SREG1 - SREG2 */
        if (D[23] || D[26]) begin
            if (T[2] && SREG1[2] == 0) begin    // SREG1 in ARF
                MuxASel <= 2'b01;
                RF_ScrSel <= 4'b0111;
                RF_FunSel <= 3'b010;
                case (SREG1[1:0])
                    2'b00: ARF_OutCSel <= 2'b00;
                    2'b01: ARF_OutCSel <= 2'b00;
                    2'b10: ARF_OutCSel <= 2'b11;
                    2'b11: ARF_OutCSel <= 2'b10;
                endcase
            end
            
            if (T[3] && SREG2[2] == 0) begin    // SREG2 in ARF
                MuxASel <= 2'b01;
                RF_ScrSel <= 4'b1011;
                RF_FunSel <= 3'b010;
                case (SREG2[1:0])
                    2'b00: ARF_OutCSel <= 2'b00;
                    2'b01: ARF_OutCSel <= 2'b00;
                    2'b10: ARF_OutCSel <= 2'b11;
                    2'b11: ARF_OutCSel <= 2'b10;
                endcase
            end
            
            if (T[4]) begin
                RF_ScrSel <= 4'b1111;
                ALU_FunSel <= 5'b10110;
                if (D[26]) begin
                    ALU_WF <= 1;
                end
                 
                if (SREG1[2] == 1) begin
                    RF_OutASel <= {1'b0, SREG1[1:0]};
                end
                else begin
                    RF_OutASel <= 3'b100;
                end
                if (SREG2[2] == 1) begin
                    RF_OutBSel <= {1'b0, SREG2[1:0]};
                end
                else begin
                    RF_OutBSel <= 3'b101;
                end
                
                if (DSTREG[2] == 1) begin // DSTREG in RF
                    MuxASel <= 2'b00;
                    RF_FunSel <= 3'b010;
                
                    case (DSTREG[1:0])
                        2'b00: RF_RegSel <= 4'b0111;
                        2'b01: RF_RegSel <= 4'b1011;
                        2'b10: RF_RegSel <= 4'b1101;
                        2'b11: RF_RegSel <= 4'b1110;
                    endcase
                end
                else begin // DSTREG in ARF
                    MuxBSel <= 2'b00;
                    ARF_FunSel <= 3'b010;
                
                    case (DSTREG[1:0])
                        2'b00: ARF_RegSel <= 3'b011;
                        2'b01: ARF_RegSel <= 3'b011;
                        2'b10: ARF_RegSel <= 3'b110;
                        2'b11: ARF_RegSel <= 3'b101;
                    endcase                   
                end           
            end
            if (T[5]) begin
                ARF_RegSel <= 3'b111;
                RF_RegSel <= 4'b1111;
                ALU_WF <= 0;
                SC_Reset <= 1;
            end
        end
        /* ------------------------------------- */
        
        /* Instruction: NOT: DSTREG <- NOT SREG1 */
        if (D[14]) begin
            if (T[2] && SREG1[2] == 0) begin    // SREG1 in ARF
                MuxASel <= 2'b01;
                RF_ScrSel <= 4'b0111;
                RF_FunSel <= 3'b010;
                case (SREG1[1:0])
                    2'b00: ARF_OutCSel <= 2'b00;
                    2'b01: ARF_OutCSel <= 2'b00;
                    2'b10: ARF_OutCSel <= 2'b11;
                    2'b11: ARF_OutCSel <= 2'b10;
                endcase
            end               
            if (T[3]) begin
                RF_ScrSel <= 4'b1111;
                ALU_FunSel <= 5'b10010;
                if (SREG1[2] == 1) begin
                    RF_OutASel <= {1'b0, SREG1[1:0]};
                end
                else begin
                    RF_OutASel <= 3'b100;
                end
                
                if (DSTREG[2] == 1) begin // DSTREG in RF
                    MuxASel <= 2'b00;
                    RF_FunSel <= 3'b010;
                
                    case (DSTREG[1:0])
                        2'b00: RF_RegSel <= 4'b0111;
                        2'b01: RF_RegSel <= 4'b1011;
                        2'b10: RF_RegSel <= 4'b1101;
                        2'b11: RF_RegSel <= 4'b1110;
                    endcase
                end
                else begin // DSTREG in ARF
                    MuxBSel <= 2'b00;
                    ARF_FunSel <= 3'b010;
                
                    case (DSTREG[1:0])
                        2'b00: ARF_RegSel <= 3'b011;
                        2'b01: ARF_RegSel <= 3'b011;
                        2'b10: ARF_RegSel <= 3'b110;
                        2'b11: ARF_RegSel <= 3'b101;
                    endcase                   
                end           
            end
            if (T[4]) begin
                ARF_RegSel <= 3'b111;
                RF_RegSel <= 4'b1111;
                SC_Reset <= 1;
            end               
        end
        /* ------------------------------------- */
    
        /* Instruction: LSL: DSTREG <- LSL SREG1 */
        if (D[7]) begin
            if (T[2] && SREG1[2] == 0) begin    // SREG1 in ARF
                MuxASel <= 2'b01;
                RF_ScrSel <= 4'b0111;
                RF_FunSel <= 3'b010;
                case (SREG1[1:0])
                    2'b00: ARF_OutCSel <= 2'b00;
                    2'b01: ARF_OutCSel <= 2'b00;
                    2'b10: ARF_OutCSel <= 2'b11;
                    2'b11: ARF_OutCSel <= 2'b10;
                endcase
            end               
            if (T[3]) begin
                RF_ScrSel <= 4'b1111;
                ALU_FunSel <= 5'b11011;
                if (SREG1[2] == 1) begin
                    RF_OutASel <= {1'b0, SREG1[1:0]};
                end
                else begin
                    RF_OutASel <= 3'b100;
                end
                
                if (DSTREG[2] == 1) begin // DSTREG in RF
                    MuxASel <= 2'b00;
                    RF_FunSel <= 3'b010;
                
                    case (DSTREG[1:0])
                        2'b00: RF_RegSel <= 4'b0111;
                        2'b01: RF_RegSel <= 4'b1011;
                        2'b10: RF_RegSel <= 4'b1101;
                        2'b11: RF_RegSel <= 4'b1110;
                    endcase
                end
                else begin // DSTREG in ARF
                    MuxBSel <= 2'b00;
                    ARF_FunSel <= 3'b010;
                
                    case (DSTREG[1:0])
                        2'b00: ARF_RegSel <= 3'b011;
                        2'b01: ARF_RegSel <= 3'b011;
                        2'b10: ARF_RegSel <= 3'b110;
                        2'b11: ARF_RegSel <= 3'b101;
                    endcase                   
                end           
            end
            if (T[4]) begin
                ARF_RegSel <= 3'b111;
                RF_RegSel <= 4'b1111;
                SC_Reset <= 1;
            end               
        end
        /* ------------------------------------- */    
 
        /* Instruction: LSR: DSTREG <- LSR SREG1 */
        if (D[8]) begin
            if (T[2] && SREG1[2] == 0) begin    // SREG1 in ARF
                MuxASel <= 2'b01;
                RF_ScrSel <= 4'b0111;
                RF_FunSel <= 3'b010;
                case (SREG1[1:0])
                    2'b00: ARF_OutCSel <= 2'b00;
                    2'b01: ARF_OutCSel <= 2'b00;
                    2'b10: ARF_OutCSel <= 2'b11;
                    2'b11: ARF_OutCSel <= 2'b10;
                endcase
            end               
            if (T[3]) begin
                RF_ScrSel <= 4'b1111;
                ALU_FunSel <= 5'b11100;
                if (SREG1[2] == 1) begin
                    RF_OutASel <= {1'b0, SREG1[1:0]};
                end
                else begin
                    RF_OutASel <= 3'b100;
                end
                
                if (DSTREG[2] == 1) begin // DSTREG in RF
                    MuxASel <= 2'b00;
                    RF_FunSel <= 3'b010;
                
                    case (DSTREG[1:0])
                        2'b00: RF_RegSel <= 4'b0111;
                        2'b01: RF_RegSel <= 4'b1011;
                        2'b10: RF_RegSel <= 4'b1101;
                        2'b11: RF_RegSel <= 4'b1110;
                    endcase
                end
                else begin // DSTREG in ARF
                    MuxBSel <= 2'b00;
                    ARF_FunSel <= 3'b010;
                
                    case (DSTREG[1:0])
                        2'b00: ARF_RegSel <= 3'b011;
                        2'b01: ARF_RegSel <= 3'b011;
                        2'b10: ARF_RegSel <= 3'b110;
                        2'b11: ARF_RegSel <= 3'b101;
                    endcase                   
                end           
            end
            if (T[4]) begin
                ARF_RegSel <= 3'b111;
                RF_RegSel <= 4'b1111;
                SC_Reset <= 1;
            end               
        end
        /* ------------------------------------- */     
    
        /* Instruction: ASR: DSTREG <- ASR SREG1 */
        if (D[9]) begin
            if (T[2] && SREG1[2] == 0) begin    // SREG1 in ARF
                MuxASel <= 2'b01;
                RF_ScrSel <= 4'b0111;
                RF_FunSel <= 3'b010;
                case (SREG1[1:0])
                    2'b00: ARF_OutCSel <= 2'b00;
                    2'b01: ARF_OutCSel <= 2'b00;
                    2'b10: ARF_OutCSel <= 2'b11;
                    2'b11: ARF_OutCSel <= 2'b10;
                endcase
            end               
            if (T[3]) begin
                RF_ScrSel <= 4'b1111;
                ALU_FunSel <= 5'b11101;
                if (SREG1[2] == 1) begin
                    RF_OutASel <= {1'b0, SREG1[1:0]};
                end
                else begin
                    RF_OutASel <= 3'b100;
                end
                
                if (DSTREG[2] == 1) begin // DSTREG in RF
                    MuxASel <= 2'b00;
                    RF_FunSel <= 3'b010;
                
                    case (DSTREG[1:0])
                        2'b00: RF_RegSel <= 4'b0111;
                        2'b01: RF_RegSel <= 4'b1011;
                        2'b10: RF_RegSel <= 4'b1101;
                        2'b11: RF_RegSel <= 4'b1110;
                    endcase
                end
                else begin // DSTREG in ARF
                    MuxBSel <= 2'b00;
                    ARF_FunSel <= 3'b010;
                
                    case (DSTREG[1:0])
                        2'b00: ARF_RegSel <= 3'b011;
                        2'b01: ARF_RegSel <= 3'b011;
                        2'b10: ARF_RegSel <= 3'b110;
                        2'b11: ARF_RegSel <= 3'b101;
                    endcase                   
                end           
            end
            if (T[4]) begin
                ARF_RegSel <= 3'b111;
                RF_RegSel <= 4'b1111;
                SC_Reset <= 1;
            end               
        end
        /* ------------------------------------- */   
        
        /* Instruction: CSL: DSTREG <- CSL SREG1 */
        if (D[10]) begin
            if (T[2] && SREG1[2] == 0) begin    // SREG1 in ARF
                MuxASel <= 2'b01;
                RF_ScrSel <= 4'b0111;
                RF_FunSel <= 3'b010;
                case (SREG1[1:0])
                    2'b00: ARF_OutCSel <= 2'b00;
                    2'b01: ARF_OutCSel <= 2'b00;
                    2'b10: ARF_OutCSel <= 2'b11;
                    2'b11: ARF_OutCSel <= 2'b10;
                endcase
            end               
            if (T[3]) begin
                RF_ScrSel <= 4'b1111;
                ALU_FunSel <= 5'b11110;
                if (SREG1[2] == 1) begin
                    RF_OutASel <= {1'b0, SREG1[1:0]};
                end
                else begin
                    RF_OutASel <= 3'b100;
                end
                
                if (DSTREG[2] == 1) begin // DSTREG in RF
                    MuxASel <= 2'b00;
                    RF_FunSel <= 3'b010;
                
                    case (DSTREG[1:0])
                        2'b00: RF_RegSel <= 4'b0111;
                        2'b01: RF_RegSel <= 4'b1011;
                        2'b10: RF_RegSel <= 4'b1101;
                        2'b11: RF_RegSel <= 4'b1110;
                    endcase
                end
                else begin // DSTREG in ARF
                    MuxBSel <= 2'b00;
                    ARF_FunSel <= 3'b010;
                
                    case (DSTREG[1:0])
                        2'b00: ARF_RegSel <= 3'b011;
                        2'b01: ARF_RegSel <= 3'b011;
                        2'b10: ARF_RegSel <= 3'b110;
                        2'b11: ARF_RegSel <= 3'b101;
                    endcase                   
                end           
            end
            if (T[4]) begin
                ARF_RegSel <= 3'b111;
                RF_RegSel <= 4'b1111;
                SC_Reset <= 1;
            end               
        end
        /* ------------------------------------- */           
    
        /* Instruction: CSR: DSTREG <- CSR SREG1 */
        if (D[11]) begin
            if (T[2] && SREG1[2] == 0) begin    // SREG1 in ARF
                MuxASel <= 2'b01;
                RF_ScrSel <= 4'b0111;
                RF_FunSel <= 3'b010;
                case (SREG1[1:0])
                    2'b00: ARF_OutCSel <= 2'b00;
                    2'b01: ARF_OutCSel <= 2'b00;
                    2'b10: ARF_OutCSel <= 2'b11;
                    2'b11: ARF_OutCSel <= 2'b10;
                endcase
            end               
            if (T[3]) begin
                RF_ScrSel <= 4'b1111;
                ALU_FunSel <= 5'b11111;
                if (SREG1[2] == 1) begin
                    RF_OutASel <= {1'b0, SREG1[1:0]};
                end
                else begin
                    RF_OutASel <= 3'b100;
                end
                
                if (DSTREG[2] == 1) begin // DSTREG in RF
                    MuxASel <= 2'b00;
                    RF_FunSel <= 3'b010;
                
                    case (DSTREG[1:0])
                        2'b00: RF_RegSel <= 4'b0111;
                        2'b01: RF_RegSel <= 4'b1011;
                        2'b10: RF_RegSel <= 4'b1101;
                        2'b11: RF_RegSel <= 4'b1110;
                    endcase
                end
                else begin // DSTREG in ARF
                    MuxBSel <= 2'b00;
                    ARF_FunSel <= 3'b010;
                
                    case (DSTREG[1:0])
                        2'b00: ARF_RegSel <= 3'b011;
                        2'b01: ARF_RegSel <= 3'b011;
                        2'b10: ARF_RegSel <= 3'b110;
                        2'b11: ARF_RegSel <= 3'b101;
                    endcase                   
                end           
            end
            if (T[4]) begin
                ARF_RegSel <= 3'b111;
                RF_RegSel <= 4'b1111;
                SC_Reset <= 1;
            end               
        end
        /* ------------------------------------- */
        
        /* Instruction: POP: Rx <-  M[SP], SP <- SP + 1 */
        if (D[3]) begin
            if (T[2]) begin
                // SP++
                ARF_RegSel <= 3'b110;
                ARF_FunSel <= 3'b001;           
            end
            if (T[3]) begin //Rx <-  M[SP]
                ARF_OutDSel <= 2'b11;
                Mem_CS <= 1'b0;
                Mem_WR <= 1'b0;
                MuxASel <= 2'b10;
                RF_FunSel <= 3'b101;
                case (RSEL)
                    2'b00: RF_RegSel <= 4'b0111;
                    2'b01: RF_RegSel <= 4'b1011;
                    2'b10: RF_RegSel <= 4'b1101;
                    2'b11: RF_RegSel <= 4'b1110;
                endcase
                // SP++
                ARF_RegSel <= 3'b110;
                ARF_FunSel <= 3'b001;                 
            end
            if (T[4]) begin
                ARF_OutDSel <= 2'b11;
                Mem_CS <= 1'b0;
                Mem_WR <= 1'b0;
                MuxASel <= 2'b10;
                RF_FunSel <= 3'b110;
                case (RSEL)
                    2'b00: RF_RegSel <= 4'b0111;
                    2'b01: RF_RegSel <= 4'b1011;
                    2'b10: RF_RegSel <= 4'b1101;
                    2'b11: RF_RegSel <= 4'b1110;
                endcase
                // SP++
                ARF_RegSel <= 3'b110;
                ARF_FunSel <= 3'b001;         
            end
            if (T[5]) begin
                ARF_RegSel <= 3'b111;
                RF_RegSel <= 4'b1111;
                Mem_CS <= 1'b1;
                SC_Reset <= 1;
            end               
        end
        /* ------------------------------------- */
        
        /* Instruction: PSH: M[SP] <- Rx, SP <- SP - 1 */
        if (D[4]) begin       
           if (T[2]) begin // M[SP]<- Rx
               RF_OutASel <= {1'b0, RSEL};
               ALU_FunSel <= 5'b10000;
               MuxCSel <= 1'b1;
               Mem_CS <= 1'b0;
               Mem_WR <= 1'b1;
               ARF_OutDSel <= 2'b11;
               
               // SP--
               ARF_RegSel <= 3'b110;
               ARF_FunSel <= 3'b000;                 
           end
           if (T[3]) begin // M[SP]<- Rx
               RF_OutASel <= {1'b0, RSEL};
               ALU_FunSel <= 5'b10000;
               MuxCSel <= 1'b0;
               Mem_CS <= 1'b0;
               Mem_WR <= 1'b1;
               ARF_OutDSel <= 2'b11;
               
               // SP--
               ARF_RegSel <= 3'b110;
               ARF_FunSel <= 3'b000;                 
           end
           if (T[4]) begin
               // SP--
                ARF_RegSel <= 3'b110;
                ARF_FunSel <= 3'b000;         
           end
           if (T[5]) begin
               ARF_RegSel <= 3'b111;
               RF_RegSel <= 4'b1111;
               Mem_CS <= 1'b1;
               SC_Reset <= 1;
           end               
       end
        /* ------------------------------------- */
       
        /* Instruction: LDR: Rx <-  M[AR] */
        if (D[18]) begin
           if (T[2]) begin //Rx <-  M[AR]
               ARF_OutDSel <= 2'b10;
               Mem_CS <= 1'b0;
               Mem_WR <= 1'b0;
               MuxASel <= 2'b10;
               RF_FunSel <= 3'b101;
               case (RSEL)
                   2'b00: RF_RegSel <= 4'b0111;
                   2'b01: RF_RegSel <= 4'b1011;
                   2'b10: RF_RegSel <= 4'b1101;
                   2'b11: RF_RegSel <= 4'b1110;
               endcase
               // AR++
               ARF_RegSel <= 3'b101;
               ARF_FunSel <= 3'b001;                 
           end
           if (T[3]) begin
               ARF_RegSel <= 3'b111;
               ARF_OutDSel <= 2'b10;
               Mem_CS <= 1'b0;
               Mem_WR <= 1'b0;
               MuxASel <= 2'b10;
               RF_FunSel <= 3'b110;
               case (RSEL)
                   2'b00: RF_RegSel <= 4'b0111;
                   2'b01: RF_RegSel <= 4'b1011;
                   2'b10: RF_RegSel <= 4'b1101;
                   2'b11: RF_RegSel <= 4'b1110;
               endcase       
           end
           if (T[4]) begin
               ARF_RegSel <= 3'b111;
               RF_RegSel <= 4'b1111;
               Mem_CS <= 1'b1;
               SC_Reset <= 1;
           end               
        end
        /* ------------------------------------- */      
 
        /* Instruction: STR: M[AR] <- Rx */
        if (D[19]) begin       
           if (T[2]) begin // M[SP]<- Rx
               RF_OutASel <= {1'b0, RSEL};
               ALU_FunSel <= 5'b10000;
               MuxCSel <= 1'b0;
               Mem_CS <= 1'b0;
               Mem_WR <= 1'b1;
               ARF_OutDSel <= 2'b10;
               
               // AR++
               ARF_RegSel <= 3'b101;
               ARF_FunSel <= 3'b001;                 
           end
           if (T[3]) begin // M[SP]<- Rx
               RF_OutASel <= {1'b0, RSEL};
               ALU_FunSel <= 5'b10000;
               MuxCSel <= 1'b1;
               Mem_CS <= 1'b0;
               Mem_WR <= 1'b1;
               ARF_OutDSel <= 2'b11;    
               ARF_RegSel <= 3'b111;           
           end
           if (T[4]) begin
               ARF_RegSel <= 3'b111;
               RF_RegSel <= 4'b1111;
               Mem_CS <= 1'b1;
               SC_Reset <= 1;
           end               
       end
        /* ------------------------------------- */             
 
        /* Instruction: MOVH: DSTREG[15:8] <- IMMEDIATE (8-bit) */
        if (D[17]) begin
        
            if (T[2]) begin
                MuxASel <= 2'b11;
                RF_FunSel <= 3'b110;
                case (RSEL)
                    2'b00: RF_RegSel <= 4'b0111;
                    2'b01: RF_RegSel <= 4'b1011;
                    2'b10: RF_RegSel <= 4'b1101;
                    2'b11: RF_RegSel <= 4'b1110;
                endcase
            end
            if (T[3]) begin
                RF_RegSel <= 4'b1111;
                ARF_RegSel <= 3'b111;
                SC_Reset <= 1;                
            end
        end
        /* ------------------------------------- */
        
        /* Instruction: MOVL: DSTREG[7:0] <- IMMEDIATE (8-bit) */
        if (D[20]) begin
       
           if (T[2]) begin
               MuxASel <= 2'b11;
               RF_FunSel <= 3'b101;
               case (RSEL)
                   2'b00: RF_RegSel <= 4'b0111;
                   2'b01: RF_RegSel <= 4'b1011;
                   2'b10: RF_RegSel <= 4'b1101;
                   2'b11: RF_RegSel <= 4'b1110;
               endcase
           end
           if (T[3]) begin
               RF_RegSel <= 4'b1111;
               ARF_RegSel <= 3'b111;
               SC_Reset <= 1;                
           end
       end
        /* ------------------------------------- */        
        
        /* Instruction: BL: PC <- M[SP] */
        if (D[31]) begin
            if (T[2]) begin
                ARF_OutDSel <= 2'b11;
                Mem_CS <= 1'b0;
                Mem_WR <= 1'b0;
                MuxBSel <= 2'b10;
                ARF_FunSel <= 3'b101;
                ARF_RegSel <= 3'b011;
            end
            if (T[3]) begin
                // SP++
                ARF_RegSel <= 3'b110;
                ARF_FunSel <= 3'b001;                
            end
            if (T[4]) begin
                ARF_OutDSel <= 2'b11;
                Mem_CS <= 1'b0;
                Mem_WR <= 1'b0;
                MuxBSel <= 2'b10;
                ARF_FunSel <= 3'b110;
                ARF_RegSel <= 3'b011;
            end            
            if (T[5]) begin
                RF_RegSel <= 4'b1111;
                ARF_RegSel <= 3'b111;
                SC_Reset <= 1;                
            end            
        end
        /* ------------------------------------- */  
        
        /* Instruction: LDRIM: Rx <- VALUE */
        if (D[32]) begin
            if (T[2]) begin
                MuxASel <= 2'b11;
                RF_FunSel <= 3'b010;
                RF_RegSel <= {1'b0, RSEL[1:0]};
            end
            if (T[3]) begin
                RF_RegSel <= 4'b1111;
                ARF_RegSel <= 3'b111;
                SC_Reset <= 1;                
            end            
        end            
    end
    
endmodule

module CPUSystem(
    Clock,
    Reset,
    T
    );
    input wire Clock;
    input wire Reset;
    output wire [7:0] T;

    wire [2:0] RF_OutASel, RF_OutBSel, RF_FunSel;
    wire [3:0] RF_RegSel, RF_ScrSel;
    wire [4:0] ALU_FunSel;
    wire ALU_WF; 
    wire [1:0] ARF_OutCSel, ARF_OutDSel;
    wire [2:0] ARF_FunSel, ARF_RegSel;
    wire IR_LH, IR_Write, Mem_WR, Mem_CS;
    wire [1:0] MuxASel, MuxBSel;
    wire MuxCSel;
    
    ArithmeticLogicUnitSystem _ALUSystem(
        .RF_OutASel(RF_OutASel),   .RF_OutBSel(RF_OutBSel), 
        .RF_FunSel(RF_FunSel),     .RF_RegSel(RF_RegSel),
        .RF_ScrSel(RF_ScrSel),     .ALU_FunSel(ALU_FunSel),
        .ALU_WF(ALU_WF),           .ARF_OutCSel(ARF_OutCSel), 
        .ARF_OutDSel(ARF_OutDSel), .ARF_FunSel(ARF_FunSel),
        .ARF_RegSel(ARF_RegSel),   .IR_LH(IR_LH),
        .IR_Write(IR_Write),       .Mem_WR(Mem_WR),
        .Mem_CS(Mem_CS),           .MuxASel(MuxASel),
        .MuxBSel(MuxBSel),         .MuxCSel(MuxCSel),
        .Clock(Clock)
    );
    
    initial begin
        _ALUSystem.RF.R1.Q = 16'h0;
        _ALUSystem.RF.R2.Q = 16'h0;
        _ALUSystem.RF.R3.Q = 16'h0;
        _ALUSystem.RF.R4.Q = 16'h0;
        _ALUSystem.RF.S1.Q = 16'h0;
        _ALUSystem.RF.S2.Q = 16'h0;
        _ALUSystem.RF.S3.Q = 16'h0;
        _ALUSystem.RF.S4.Q = 16'h0;
        _ALUSystem.ARF.PC.Q = 16'h0;
        _ALUSystem.ARF.AR.Q = 16'h0;
        _ALUSystem.ARF.SP.Q = 16'h0;
        _ALUSystem.IR.IROut = 16'h0;
        _ALUSystem.ALU.FlagsOut = 4'b0000; 
    end   
    
    wire [15:0] IROut = _ALUSystem.IR.IROut;
    wire [3:0] ALU_FlagReg = _ALUSystem.ALU.FlagsOut;
    
    control_unit CU (.clk(Clock), .IROut(IROut), .ARF_FunSel(ARF_FunSel), .ARF_RegSel(ARF_RegSel), .ARF_OutCSel(ARF_OutCSel), .ARF_OutDSel(ARF_OutDSel), 
    .ALU_FlagReg(ALU_FlagReg), .ALU_FunSel(ALU_FunSel), .RF_OutASel(RF_OutASel), .RF_OutBSel(RF_OutBSel), .RF_FunSel(RF_FunSel), .RF_RegSel(RF_RegSel), .RF_ScrSel(RF_ScrSel),
        .MuxASel(MuxASel), .MuxBSel(MuxBSel), .MuxCSel(MuxCSel), .Mem_CS(Mem_CS), .Mem_WR(Mem_WR), .IR_LH(IR_LH), .IR_Write(IR_Write), .SC_Reset(Reset), .ALU_WF(ALU_WF), .T(T));
    
endmodule
