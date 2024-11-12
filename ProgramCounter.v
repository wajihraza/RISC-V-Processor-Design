`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/25/2022 01:11:01 PM
// Design Name: 
// Module Name: ProgramCounter
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


module ProgramCounter(
input [7:0] br_instruction,
input we,
input j_pc,
input br_sig,
input clk,
output reg [7:0] instraddr,
output [7:0] ret_addr
    );
    
    initial instraddr=8'h00;
    assign ret_addr=instraddr+8'h04;
    always@(posedge clk)begin 
    
    if ((br_sig && we)||(j_pc)) begin
    instraddr=br_instruction;
    end
    else instraddr = ret_addr;
    end
endmodule
