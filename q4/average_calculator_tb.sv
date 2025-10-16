module average_calculator_tb;
	parameter m = 8;
	parameter n = 4;
	
	logic clk;
	logic rst_n;    
	logic start;
	logic [m-1:0] inputx;
	logic [m-1:0] result;
	logic done;
	logic init_sum, init_shift, load, shift; //
	logic [m+$clog2(n)-1:0] sum_reg_test; //

	average_calculator #(m, n) dut (
		.clk(clk),
		.rst_n(rst_n),
		.start(start),
		.inputx(inputx),
		.result(result),
		.init_sum(init_sum), .init_shift(init_shift), .load(load), .shift(shift), //
		.sum_reg_test(sum_reg_test), //
		.done(done)
	);

    // Clock: 10 ns period
    initial clk = 0;
    always #5 clk = ~clk;

    // Small monitor to help see progress
    always @(posedge clk) begin
        $display("T=%0t start=%b inputx=%0d done=%b result=%0d",
                 $time, start, inputx, done, result);
    end

    initial begin
        // reset
        rst_n = 0;
        start = 0;
        inputx = 7;
        #10;
        rst_n = 1;
        start  = 1;
        @(posedge clk);
		inputx = 5;
		#5;
		start = 0;
        @(posedge clk);
		inputx = 3;
        @(posedge clk);
		inputx = 2;
        @(posedge clk);
		inputx = 6;
        @(posedge clk);
		inputx = 9;
        @(posedge clk);
		inputx = 12;
        @(posedge clk);
		inputx = 13;

		#20
        $display("\nFinal computed average = %0d\n", result);
        $finish;
    end
	
endmodule
