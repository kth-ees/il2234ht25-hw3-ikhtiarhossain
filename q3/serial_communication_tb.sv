`timescale 1ns/1ps

module serial_communication_tb;

    logic clk;
    logic rst_n;
    logic serData;
    logic outValid;

    serial_communication dut (
        .clk(clk),
        .rst_n(rst_n),
        .serData(serData),
        .outValid(outValid)
    );

    initial clk = 0;
    always #5 clk = ~clk;

    initial begin
        rst_n = 0;
        serData = 1'b0;

        #20;
        rst_n = 1;

        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);

        serData = 0; @(posedge clk);
        serData = 1; @(posedge clk);
        serData = 1; @(posedge clk);
        serData = 0; @(posedge clk);
        serData = 1; @(posedge clk);
        serData = 0; @(posedge clk);

        serData = 1; @(posedge clk);
        serData = 0; @(posedge clk);
        serData = 1; @(posedge clk);
        serData = 1; @(posedge clk);
        serData = 0; @(posedge clk);
        serData = 1; @(posedge clk);
        serData = 0; @(posedge clk);
        serData = 0; @(posedge clk);
        serData = 1; @(posedge clk);
        serData = 1; @(posedge clk);
        serData = 0; @(posedge clk);
        serData = 1; @(posedge clk);
        serData = 0; @(posedge clk);
        serData = 0; @(posedge clk);
        serData = 1; @(posedge clk);
        serData = 0; @(posedge clk);
        serData = 1; @(posedge clk);
        serData = 0; @(posedge clk);
        serData = 1; @(posedge clk);
        serData = 1; @(posedge clk);
        serData = 1; @(posedge clk);
        serData = 0; @(posedge clk);
        serData = 0; @(posedge clk);
        serData = 1; @(posedge clk);
        serData = 1; @(posedge clk);
        serData = 0; @(posedge clk);
        serData = 0; @(posedge clk);
        serData = 1; @(posedge clk);
        serData = 0; @(posedge clk);
        serData = 1; @(posedge clk);
        serData = 1; @(posedge clk);
        serData = 0; @(posedge clk);

        serData = 1; @(posedge clk);
        serData = 1; @(posedge clk);
        serData = 1; @(posedge clk);
        serData = 1; @(posedge clk);
        serData = 1; @(posedge clk);

        #20;
        $finish;
    end

    initial begin
        $display("Time\tclk\tserData\toutValid");
        $monitor("%0t\t%b\t%b\t%b", $time, clk, serData, outValid);
    end

endmodule