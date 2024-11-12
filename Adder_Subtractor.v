`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/22/2022 11:56:46 AM
// Design Name: 
// Module Name: Adder_Subtractor
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


/*module Adder_Subtractor(
    input [31:0] rs1,
    input [31:0] rs2,
    output reg [31:0] rd,
    input funct7_bit5
    );
    //reg result;
    always@(*)
    begin
    case(funct7_bit5)
    1'b0: rd=rs1+rs2;
    1'b1: rd=rs1-rs2;
    endcase
    end
    //assign rd=result;
endmodule*/

module SLL(
   input [31:0] operand1,
   input [31:0] operand2,
   output reg [31:0] result
);
reg [31:0]      shift_left_1_r;
reg [31:0]      shift_left_2_r;
reg [31:0]      shift_left_4_r;
reg [31:0]      shift_left_8_r;

always@(operand1 or operand2)
begin
            if (operand2[0] == 1'b1)
                shift_left_1_r = {operand1[30:0],1'b0};
            else
                shift_left_1_r = operand1;

            if (operand2[1] == 1'b1)
                shift_left_2_r = {shift_left_1_r[29:0],2'b00};
            else
                shift_left_2_r = shift_left_1_r;

            if (operand2[2] == 1'b1)
                shift_left_4_r = {shift_left_2_r[27:0],4'b0000};
            else
                shift_left_4_r = shift_left_2_r;

            if (operand2[3] == 1'b1)
                shift_left_8_r = {shift_left_4_r[23:0],8'b00000000};
            else
                shift_left_8_r = shift_left_4_r;

            if (operand2[4] == 1'b1)
                result = {shift_left_8_r[15:0],16'b0000000000000000};
            else
                result = shift_left_8_r;
       end
endmodule

module ShiftRight(
   input [31:0] operand1,
   input [31:0] operand2,
   input funct7_bit5,
   output reg [31:0] result
);
reg [31:16]     shift_right_fill_r;
reg [31:0]      shift_right_1_r;
reg [31:0]      shift_right_2_r;
reg [31:0]      shift_right_4_r;
reg [31:0]      shift_right_8_r;
always@(operand1 or operand2 or funct7_bit5)

begin
            // Arithmetic shift? Fill with 1's if MSB set
            if (operand1[31] == 1'b1 && funct7_bit5 == 1'b1)
                shift_right_fill_r = 16'b1111111111111111;
            else
                shift_right_fill_r = 16'b0000000000000000;

            if (operand2[0] == 1'b1)
                shift_right_1_r = {shift_right_fill_r[31], operand1[31:1]};
            else
                shift_right_1_r = operand1;

            if (operand2[1] == 1'b1)
                shift_right_2_r = {shift_right_fill_r[31:30], shift_right_1_r[31:2]};
            else
                shift_right_2_r = shift_right_1_r;

            if (operand2[2] == 1'b1)
                shift_right_4_r = {shift_right_fill_r[31:28], shift_right_2_r[31:4]};
            else
                shift_right_4_r = shift_right_2_r;

            if (operand2[3] == 1'b1)
                shift_right_8_r = {shift_right_fill_r[31:24], shift_right_4_r[31:8]};
            else
                shift_right_8_r = shift_right_4_r;

            if (operand2[4] == 1'b1)
                result = {shift_right_fill_r[31:16], shift_right_8_r[31:16]};
            else
                result = shift_right_8_r;
       end       

endmodule