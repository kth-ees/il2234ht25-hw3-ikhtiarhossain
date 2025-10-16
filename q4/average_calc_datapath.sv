module average_calc_datapath #(
    parameter m=8,
    parameter n=4) (
    input logic clk,
    input logic rst_n,
    input logic load,
    input logic shift, 
    input logic init_sum,
    input logic init_shift,
    input logic [m-1:0] inputx,
    output logic [m+$clog2(n)-1:0] sum_reg_test,
    output logic [m-1:0] result
);

    localparam k = $clog2(n);
    localparam WIDTH = m + k;
    
    logic [WIDTH-1:0] inputx_ext, sum_reg, shifted_sum;
    logic [m-1:0] avg_reg;

    assign sum_reg_test = sum_reg;

    assign inputx_ext = {{k{1'b0}}, inputx};

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            sum_reg <= 0;
        else if (init_sum)
            sum_reg <= 0;
        else if (load)
            sum_reg <= sum_reg + inputx_ext;
    end

    assign shifted_sum = sum_reg >> k;

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            avg_reg <= 0;
        else if (init_shift)
            avg_reg <= 0;
        else if (shift)
            avg_reg <= shifted_sum[m-1:0];
    end

    assign result = avg_reg;
	
endmodule
