module ALU (INPUT1, INPUT2, SELECT, OUTPUT);

	input [7:0] INPUT1, INPUT2;
	input [2:0] SELECT;
	output [7:0] OUTPUT;
	wire [0:7] w1, w2;
	reg [7:0] OUT;


	assign w1=INPUT1;
	assign w2=INPUT2;
	assign OUTPUT=OUT;

	always @(INPUT1 or INPUT2 or SELECT)
	begin
		case (SELECT)
			0:
				OUT=w1;
			1:
				OUT=w1+w2;
			2:
				OUT=w1 & w2;
			3:
				OUT=w1 | w2;
		endcase
	end
	 

endmodule


module tb_ALU;

	//inputs
	reg [7:0] INPUT1;
	reg [7:0] INPUT2;
	reg [2:0] SELECT;

	//output
	wire [7:0] OUTPUT;

	ALU alu_pass (INPUT1, INPUT2, SELECT, OUTPUT);
	initial begin
		INPUT1= 8'b00000011;
		INPUT2= 8'b00000001;

		SELECT=0; #10 $display("data 1= %b data 2= %b OPCODE=%b result=%b\n", INPUT1, INPUT2, SELECT, OUTPUT);
		SELECT=1; #10 $display("data 1= %b data 2= %b OPCODE=%b result= %b\n", INPUT1, INPUT2, SELECT, OUTPUT);
		SELECT=2; #10 $display("data 1= %b data 2= %b OPCODE=%b result= %b\n", INPUT1, INPUT2, SELECT, OUTPUT);
		SELECT=3; #10 $display("data 1= %b data 2= %b OPCODE=%b result= %b\n", INPUT1, INPUT2, SELECT, OUTPUT);
	end

endmodule

