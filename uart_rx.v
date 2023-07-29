`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:29:41 07/25/2022 
// Design Name: 
// Module Name:    uart_rx 
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
module uart_rx
#(parameter clk_per_bit = 217)(
    input clk,
    input serialData,
    output reg[7:0] dataout
    );
	 
	parameter IDLE = 2'b00, START_BIT = 2'b01, DATA_BITS = 2'b10, STOP_BIT = 2'b11; 
	 
	reg[2:0] index;
	reg[1:0] next_state;
	reg[7:0] clk_count;
	
	always@(posedge clk)
	begin
	
	case(next_state)
	
	IDLE:
	begin
	clk_count <= 8'b0;
	index <= 3'b0;
	next_state = serialData ? IDLE : START_BIT;
	end
	
	START_BIT:
	begin
	if(clk_count < (clk_per_bit-1)/2)
	begin
	clk_count <= clk_count + 1'b1;
	next_state <= START_BIT;
	end
	else
	begin
	if(serialData == 1'b0)
	begin
	clk_count <= 8'b0;
	next_state <= DATA_BITS;
	end
	else
	begin
	next_state <= IDLE;
	clk_count <= 8'b0;
	end
	end
	end
	
	DATA_BITS:
	begin
	if(clk_count < (clk_per_bit-1))
	begin
	clk_count <= clk_count + 1;
	next_state <= DATA_BITS;
	end
	else
	begin
	dataout[index] = serialData;
	clk_count <= 8'b0;
	if(index < 3'b111)
	begin
	index <= index + 1'b1;
	next_state <= DATA_BITS;
	end
	else
	begin
	index <= 3'b0;
	next_state <= STOP_BIT;
	end
	end
	end
	
	STOP_BIT:
	begin
	if(clk_count < (clk_per_bit-1))
	begin
	clk_count <= clk_count + 1'b1;
	next_state <= STOP_BIT;
	end
	else
	begin
	if(serialData == 1)
	begin
	next_state <= IDLE;
	end
	else
	begin
	clk_count <= 8'b0;
	next_state <= STOP_BIT;
	end
	end
	end
	
	default: next_state <= IDLE;
	endcase
	
	end

endmodule
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:29:41 07/25/2022 
// Design Name: 
// Module Name:    uart_rx 
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
module uart_rx
#(parameter clk_per_bit = 217)(
    input clk,
    input serialData,
    output reg[7:0] dataout
    );
	  
	parameter IDLE = 2'b00, START_BIT = 2'b01, DATA_BITS = 2'b10, STOP_BIT = 2'b11; 
	 
	reg[2:0] index;
	reg[1:0] next_state;
	reg[7:0] clk_count;
	
	always@(posedge clk)
	begin
	
	case(next_state)
	
	IDLE:
	begin
	clk_count <= 8'b0;
	index <= 3'b0;
	next_state = serialData ? IDLE : START_BIT;
	end
	
	START_BIT:
	begin
	if(clk_count < (clk_per_bit-1)/2)
	begin
	clk_count <= clk_count + 1'b1;
	next_state <= START_BIT;
	end
	else
	begin
	if(serialData == 1'b0)
	begin
	clk_count <= 8'b0;
	next_state <= DATA_BITS;
	end
	else
	begin
	next_state <= IDLE;
	clk_count <= 8'b0;
	end
	end
	end
	
	DATA_BITS:
	begin
	if(clk_count < (clk_per_bit-1))
	begin
	clk_count <= clk_count + 1;
	next_state <= DATA_BITS;
	end
	else
	begin
	dataout[index] = serialData;
	clk_count <= 8'b0;
	if(index < 3'b111)
	begin
	index <= index + 1'b1;
	next_state <= DATA_BITS;
	end
	else
	begin
	index <= 3'b0;
	next_state <= STOP_BIT;
	end
	end
	end
	
	STOP_BIT:
	begin
	if(clk_count < (clk_per_bit-1))
	begin
	clk_count <= clk_count + 1'b1;
	next_state <= STOP_BIT;
	end
	else
	begin
	if(serialData == 1)
	begin
	next_state <= IDLE;
	end
	else
	begin
	clk_count <= 8'b0;
	next_state <= STOP_BIT;
	end
	end
	end
	
	default: next_state <= IDLE;
	endcase
	
	end

endmodule
