`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/22/2022 04:01:40 PM
// Design Name: 
// Module Name: tb
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


module tb(


    );
    reg clk;
    Core c1 (.clk(clk));
    always #50 clk=~clk;
    initial clk=0;
    
    /*
    reg [31:0] instrcode;
    reg [4:0] rs1_sel;
    reg [4:0] rs2_sel;
       reg [2:0] funct3;
    reg sel;
    reg [4:0] rd_sel;
    reg [31:0] rd;
    wire [31:0] out;
    wire [31:0] rs1;
    wire [31:0] rs2;
    reg [31:0] operand2;
    reg [31:0] sign_extnd;
    
    RegFile RF (.rs1_sel(instrcode[19:15]), .rs2_sel(instrcode[24:20]),
    .rd_sel(instrcode[11:7]), .rd(rd), .rs1(rs1), .rs2(rs2), .clk(clk));
    ALU a1(.funct3(instrcode[14:12]), .rs1(rs1), .rs2(rs2), .funct7_bit5(instrcode[30]), .rd(out));
    always@(out)begin
    rd=out;
    end
    always@(*)begin
    case(instrcode[6:0])
        7'b0110011: operand2=rs2;
        7'b0010011:
        begin
        if (instrcode[31])begin
            sign_extnd={20'hfffff,instrcode[31:20]};
            end
        else begin
            sign_extnd={20'h00000,imm[11:0]};
        end   
    endcase
    operand2=sign_extnd;
    end
    always #50 clk=~clk;
    initial begin
    clk=0;
    #100 instrcode=32'h00a00193; 
    #100 instrcode=32'h00419213;
    end*/
    
endmodule