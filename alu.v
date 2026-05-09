module alu_behavioral #(parameter N = 4) (
	input [N-1:0] A, B,
	input enable,
	input [2:0]opcode,
	output reg [N-1:0] alu_out,
	output reg carry
);

parameter 
	ADD = 3'b000,
	SUB = 3'b001,
	AND = 3'b010,
	OR = 3'b011,
	XOR = 3'b100,
	NOT = 3'b101;


always @(*) begin
	if (enable) begin
		case(opcode)
			ADD: begin 
				{carry, alu_out} = A + B; 
			end
			SUB: begin 
				{carry, alu_out} = A - B; 
			end
			AND:alu_out = A & B; 
			OR: alu_out = A | B; 
			XOR: alu_out = A ^ B; 
			NOT: alu_out = ~A;
			default: alu_out = 0;
		endcase
	end
end

endmodule
