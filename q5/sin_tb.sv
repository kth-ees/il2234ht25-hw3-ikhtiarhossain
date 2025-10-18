module sin_tb;
    logic        clk;
    logic        rst_n;
    logic [15:0] x;
    logic        start;
    logic [15:0] result;
    logic        done;

    sin uut (
        .clk(clk),
        .rst_n(rst_n),
        .x(x),
        .start(start),
        .result(result),
        .done(done)
    );

    initial clk = 0;
    always #5 clk = ~clk;

    initial begin
        // Initialize
        rst_n = 0;
        start = 0;
        x = 0;
        
        // Reset
        #20;
        rst_n = 1;
        #10;
        
        // Test case 1: x = 0
        x = 16'h0000;
        start = 1;
        #10;
        start = 0;
        wait(done);
        $display("sin(0) = %h", result);
        #20;
        
        // Test case 2: x = π/4 (approx)
        x = 16'h2000;
        start = 1;
        #10;
        start = 0;
        wait(done);
        $display("sin(π/4) = %h", result);
        #20;
        
        // Test case 3: x = π/2 (approx)
        x = 16'h4000;
        start = 1;
        #10;
        start = 0;
        wait(done);
        $display("sin(π/2) = %h", result);
        #20;
        
        $finish;
    end

endmodule


     