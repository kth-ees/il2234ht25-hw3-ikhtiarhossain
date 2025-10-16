module average_calculator #(parameter m = 8, parameter n = 4) (
    input logic clk,
    input logic rst_n,
    input logic start,
    input logic [m-1:0] inputx,
    output logic [m-1:0] result,
    output logic init_sum, init_shift, load, shift,//
    output logic [m+$clog2(n)-1:0] sum_reg_test,
    output logic done
);

    localparam int k = $clog2(n);

    // logic init_sum, init_shift, load, shift;

    average_calc_datapath #(.m(m), .n(n)) dp (
        .clk        (clk),
        .rst_n      (rst_n),
        .load       (load),
        .shift      (shift),
        .init_sum   (init_sum),
        .init_shift (init_shift),
        .inputx     (inputx),
        .sum_reg_test (sum_reg_test), //
        .result     (result)
    );

    average_calc_controller #(.n(n)) ctrl (
        .clk        (clk),
        .rst_n      (rst_n),
        .start      (start),
        .init_sum   (init_sum),
        .init_shift (init_shift),
        .load       (load),
        .shift      (shift),
        .done       (done)
    );

	
endmodule

