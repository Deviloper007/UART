`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:13:01 07/26/2022 
// Design Name: 
// Module Name:    uart_tx 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module uart_tx
#(parameter clk_per_bit = 217)(
    input [7:0] databus,
    input valid,
    input clk,
    output reg outSerial
    );
	 
	parameter  IDLE = 2'b00, START_BIT = 2'b01, DATA_BIT =  2'b10, STOP_BIT = 2'b11;

	reg[7:0] clk_count;
	reg[2:0] index;
	reg[1:0] next_state;
	
	always@(posedge clk)
	begin
	
	case(next_state)
	
	IDLE:
	begin
	clk_count <= 8'b0;
	index <= 3'b0;
	next_state = valid ? START_BIT : IDLE;
	end
	
	START_BIT:
	begin
	outSerial <= 1'b0;
	if(clk_count < (clk_per_bit-1))
	begin
	clk_count <= clk_count + 1'b1;
	next_state <= START_BIT;
	end
	else
	begin
	clk_count <= 8'b0;
	next_state <= DATA_BIT;
	end
	end
	
	DATA_BIT:
	begin
	outSerial <= databus[index];
	if(clk_count < (clk_per_bit-1))
	begin
	clk_count <= clk_count + 1'b1;
	next_state <= DATA_BIT;
	end
	else
	begin
	clk_count <= 8'b0;
	if(index<3'b111)
	begin
	index <= index + 1'b1;
	next_state <= DATA_BIT;
	end
	else
	begin
	index <= 3'b0;
	clk_count <= 8'b0;
	next_state <= STOP_BIT;
	end
	end
	end
	
	STOP_BIT:
	begin
	outSerial <= 1'b1;
	if(clk_count < (clk_per_bit-1))
	begin
	clk_count <= clk_count + 1'b1;
	next_state <= STOP_BIT;
	end
	else
	begin
	next_state <= IDLE;
	end
	end
	
	endcase
	end
endmodule
