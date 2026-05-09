`timescale 1ns/1ps

module alu_tb #(parameter N = 4);

reg [N-1:0] in1, in2;
reg [2:0] opcode;
reg enable;

wire [N-1:0] out;
wire carry;

alu_behavioral #(N) DUT(
	.A(in1), 
	.B(in2),
	.opcode(opcode),
	.enable(enable),
	.alu_out(out),
	.carry(carry)
);

reg [N-1:0] exp_out;
reg exp_carry;

task test;
input [N-1:0] a, b;
input[2:0] op;
begin
	in1 = a;
	in2 = b;
	opcode = op;
	enable = 1;
	#10;
	
	exp_out = 0;
	exp_carry = 0;
	
	case(op)
		3'b000: {exp_carry, exp_out} = a + b;      
 		3'b001: {exp_carry, exp_out} = a - b;      
            	3'b010: exp_out = a & b;                   
            	3'b011: exp_out = a | b;                  
            	3'b100: exp_out = a ^ b;                 
            	3'b101: exp_out = ~a;  
		default: exp_out = 0;
	endcase

	if(out == exp_out && carry == exp_carry) 
		$display("Pass: A=%d B =%d Opcode=%d \n Output=%d Carry=%d", a, b, op, out, carry);
	else
		$display("Fail: A=%d B =%d Opcode=%d \n Exp out =%d Exp carry=%d \n Obtained out =%d Obtained carry=%d", a, b, op, exp_out, exp_carry, out, carry);
	
	#10;
end
endtask

initial begin
	$display ("---Airthmetic Logic Unit Test---");
	enable = 0;
	in1 = 0;
	in2 = 0;
	opcode = 0;
	#10;

	$display ("ADD OPERATION");
	test(4'd4, 4'd6, 3'b000);
	$display ("SUBTRACT OPERATION");
       	test(4'd9, 4'd4, 3'b001); 
	$display ("AND OPERATION");
        test(4'd6, 4'd3, 3'b010); 
	$display ("OR OPERATION");
        test(4'd6, 4'd3, 3'b011); 
	$display ("XOR OPERATION");
        test(4'd6, 4'd3, 3'b100); 
	$display ("N0T OPERATION");
        test(4'd6, 4'd0, 3'b101);
	
	enable = 0;
	#10;

	$display("---Test Completed---");
	#20;
end
endmodule
	
