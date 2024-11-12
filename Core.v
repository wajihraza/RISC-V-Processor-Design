`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/25/2022 04:03:19 PM
// Design Name: 
// Module Name: Core
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


module Core(input clk,
output out
    );
    wire [7:0] instraddr;
    wire [31:0] instrcode;
    wire [31:0] rs1;
    wire [31:0] rs2;
    wire [31:0] ALU_result;
    wire [31:0] datamem_out; 
    wire br_sig;
    wire [7:0] ret_addr;
    //control signals
    wire we_regfile;
    wire we_datamem;
    wire re_datamem;
    wire [2:0] ALU_sel_1;
    wire ALU_sel_2;
    wire we_pc;
    wire j_pc;
    wire [1:0] operand1_sel;
    wire operand2_sel;
    wire [1:0] rd_sel;
    //registers
    reg [31:0] rd;
    reg [31:0] operand1;
    reg [31:0] operand2;
    reg [31:0] imm;
    
    //reg [7:0] br_instruction;
    //reg [7:0] dataaddr;
    
    assign out=ALU_result;
    always@(*)begin
    
    case(instrcode[6:0])
    //r type
            7'b0110011:begin
            imm=32'b0;
            end
            
            //i type
            7'b0010011: begin
            if (instrcode[31])begin
                imm ={20'hfffff,instrcode[31:20]};
                end 
                else imm ={20'h00000,instrcode[31:20]};
            end            
            //s type
            7'b0100011:begin
            if (instrcode[31])begin
            imm ={20'hfffff,instrcode[31:25], instrcode[11:7]};
            end 
            else imm ={20'h00000,instrcode[31:25], instrcode[11:7]};            
            end            
            //L type
            7'b0000011 :begin
            if (instrcode[31])begin
            imm ={20'hfffff,instrcode[31:20]};
            end 
            else imm ={20'h00000,instrcode[31:20]};
            end           
            //B type
            7'b1100011:begin
            if (instrcode[31])begin
            imm ={19'h7ffff,instrcode[31], instrcode[7], instrcode[30:25], instrcode[11:8],1'b0};
            end 
            else imm ={19'h00000,instrcode[31], instrcode[7], instrcode[30:25], instrcode[11:8],1'b0};
            end                     
            //JAL
            7'b1101111: begin
            if (instrcode[31])begin
            imm ={11'h7ff,instrcode[31], instrcode[19:12], instrcode[20], instrcode[30:21],1'b0};
            end 
            else imm ={11'h000,instrcode[31], instrcode[19:12], instrcode[20], instrcode[30:21],1'b0};            
            end
            //JALR
            7'b1100111:begin
            if (instrcode[31])begin
            imm ={20'hfffff,instrcode[31:20]};
            end 
            else imm ={20'h00000,instrcode[31:20]};
            end
            //LUI
            7'b0110111:begin
            imm={instrcode[31:12],12'h000};
            end
            //AUIPC
            7'b0010111:begin
            imm={instrcode[31:12],12'h000};     
            end
            endcase
            
            case(operand1_sel)
            2'b00:operand1=rs1;
            2'b01:operand1=instraddr;
            2'b10:operand1=32'h00000000;
            endcase
            
            case(operand2_sel)
            1'b0:operand2=rs2;
            1'b1:operand2=imm;
            endcase
            
            case(rd_sel)
            2'b00:rd=ALU_result;
            2'b01:rd=datamem_out;
            2'b10:rd=ret_addr;
            endcase
            end
            
            
            
            
            
ProgramCounter u0 (.clk(clk), .instraddr(instraddr), .br_instruction(ALU_result), .we(we_pc), .br_sig(br_sig), .j_pc(j_pc), .ret_addr(ret_addr));
Instruction_Memory u1 (.instraddr(instraddr), .instrcode(instrcode));
RegFile u3 (
.rs1_sel(instrcode[19:15]), 
.rs2_sel(instrcode[24:20]), 
.rd_sel(instrcode[11:7]), 
.rd(rd), 
.rs1(rs1), 
.rs2(rs2), 
.clk(clk),
.we(we_regfile)
);
ALU u4(.funct3(ALU_sel_1), .operand1(operand1), .operand2(operand2), .funct7_bit5(ALU_sel_2), .ALU_result(ALU_result)
);

DataMem u5 (
.datamem_in(rs2),
.we(we_datamem),
.addr_sel(ALU_result),
.funct_3(instrcode[14:12]),
.re(re_datamem),
.datamem_out(datamem_out)
);

Comparator u6 (
.funct_3(instrcode[14:12]),
.operand1(rs1),
.operand2(rs2),
.br_sig(br_sig)
);

InstrDecoder u7 (
.we_regfile(we_regfile),
.we_datamem(we_datamem),
.re_datamem(re_datamem),
.we_pc(we_pc),
.j_pc(j_pc),
.ALU_sel_1(ALU_sel_1),
.ALU_sel_2(ALU_sel_2),
.operand1_sel(operand1_sel),
.operand2_sel(operand2_sel),
.rd_sel(rd_sel),
.instrcode(instrcode)
);


endmodule
