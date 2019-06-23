`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: DARSHAN D SHANKAR
//
// Create Date:   19:28:09 06/08/2019
// Design Name:   pipe_MIPS32
// Module Name:  
// Project Name:  MIPS_32
// Target Device:  
// Tool versions:  
// Description: 
//
//
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module test_pipe_MIPS32;

	// Inputs
	reg clk1;
	reg clk2;
	integer k;

	parameter 	ADD = 6'b000000, SUB = 6'b000001, AND = 6'b000010, OR = 6'b000011,
					SLT = 6'b000100, MUL = 6'b000101, HLT = 6'b111111, LW = 6'b001000,
					SW  = 6'b001001, ADDI = 6'b001010, SUBI = 6'b001011, SLTI = 6'b001100,
					BNEQZ = 6'b001101, BEQZ =  6'b001110;

	parameter R0 = 5'd0, R1 = 5'd1, R2 = 5'd2, R3=5'd3, R4=5'd4, R5 = 5'd5, R6 = 5'd6, R7 = 5'd7, R8 = 5'd8, R9 = 5'd9,
			R10 = 5'd10, R11 = 5'd11, R12 = 5'd12, R13 = 5'd13, R14 = 5'd14, R15 = 5'd15, R16 = 5'd16, R17 = 5'd17, R18 = 5'd18,
			 R19 = 5'd19, R20 = 5'd20, R21 = 5'd21, R22 = 5'd22, R23 = 5'd23, R24 = 5'd24, R25 = 5'd25, R26 = 5'd26, R27 = 5'd27,
			R28 = 5'd28, R29 = 5'd29, R30 = 5'd30, R31 = 5'd31;		

	// Instantiate the Unit Under Test (UUT)
	pipe_MIPS32 uut (
		.clk1(clk1), 
		.clk2(clk2)
	);

	initial begin
		// Initialize Inputs
		uut.PC = 0;
		clk1 = 0;
		clk2 = 0;
		$monitor("PC = %d, IR = %h, ALUout = %d", uut.PC, uut.IF_ID_IR, uut.EX_MEM_ALUout);
		repeat(20)
			begin
				#5 clk1 = 1; #5 clk1 = 0;
				#5 clk2 = 1; #5 clk2 = 0;
			end
	end
	
	initial
		begin
			// for (k=0; k<31; k=k+1) uut.REG[k] = k; 
			uut.MEMORY[0] <= {ADDI,R0,R1,16'd10};
			uut.MEMORY[1] <= {ADDI,R0,R2,16'd20};
			uut.MEMORY[2] <= {ADDI,R0,R3,16'd25};
			uut.MEMORY[3] <= 32'h0ce77800;
			uut.MEMORY[4] <= 32'h0ce77800;
			uut.MEMORY[5] <= {ADD,R1,R2,R4,11'd0};
			uut.MEMORY[6] <= 32'h0ce77800;
			uut.MEMORY[7] <= {ADD,R4,R3,R5,11'd0};
			uut.MEMORY[8] <= {HLT,26'd0};

			// uut.MEMORY[0] <= {ADD,R2,R1,R28,11'd0};
			// uut.MEMORY[1] <= {HLT,26'd0};
			

			uut.HALTED = 0;
			uut.PC = 0;
			uut.TAKEN_BRANCH = 0;
			
			#280 for (k=0; k<6; k=k+1) $display ("R%1d - %2d ", k, uut.REG[k]);
		end
      
	initial
		begin
			$dumpfile ("mips.vcd");
			$dumpvars (0, test_pipe_MIPS32);
			#300 $finish;
		end	
endmodule

