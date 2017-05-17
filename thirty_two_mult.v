`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:00:13 03/22/2017 
// Design Name: 
// Module Name:    thirty_two_mult 
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
module thirty_two_mult(
    input [31:0]mplr_i,
    input [31:0]mcand_i,
    output reg [63:0]prod,
    output reg cout
    );
	 
	reg	[63:0]prod_t;
	reg	[31:0]mcand;
	reg 	[31:0]mplr;
	reg	sign;
	integer i;
	
	always @(*)
		begin
		sign = (mcand_i[31] == 1'b1 ^ mplr_i[31] == 1'b1) ? 1:0;
		if (mcand_i[31] == 1'b1)
			begin
			mcand =  {32'b0, ~mcand_i+1};
			end
		else
			begin
			mcand  = {32'b0, mcand_i};
			end
		if (mplr_i[31] == 1'b1)
			begin
			mplr = ~mplr_i+1;
			end
		else
			begin
			mplr  = mplr_i;
			end

		prod_t[63:32] = 32'b0;
		prod_t[31:0] = mplr;
		for (i=0;i<32;i=i+1)
			begin
			if (prod_t[0] == 1)
				begin
				prod_t[63:32] = prod_t[63:32] + mcand[31:0];
				end
			prod_t = prod_t >> 1;
			end
		
		if (sign == 1)
			begin
			prod = ~prod_t+1;
			end
		else
			begin
			prod = prod_t;
			end
		cout = (sign == prod[63])?0:1;
		end
endmodule
