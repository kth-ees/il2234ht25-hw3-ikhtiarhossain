module sin_datapath (
    input  logic                    clk,
    input  logic                    rst_n,
    input  logic                    load_xpowertwo,
    input  logic                    init_xpowertwo,
    input  logic                    load_mult_reg,
    input  logic                    init_mult_reg,
    input  logic                    load_result,
    input  logic                    init_result,
    input  logic                    inc_counter,
    input  logic                    init_counter,
    input  logic                    sel_mult_in,
    output logic                    co,
    input  logic [15:0]             x,
    output logic [15:0]             result
); 

    logic [15:0] x_reg, xpowertwo_reg, mult_reg, result_reg;
    logic [2:0]  counter;

    logic [2:0] lut_addr;
    logic [15:0] coeff;
    
    sin_coeff_lut lut (
        .addr(lut_addr),
        .data(coeff)
    );

    logic [15:0] mult_in;
    logic [31:0] x_sqr, mult_out;

    always_comb begin
        mult_in = 0;
        x_sqr = 0;
        mult_out = 0;
        lut_addr = counter;

        x_sqr =  x_reg * x_reg;
        mult_in = sel_mult_in ? coeff : xpowertwo_reg;
        mult_out = mult_reg * mult_in;
    end

    always_ff @( posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            x_reg <= 0;
            xpowertwo_reg <= 0;
            mult_reg <= 0;
            result_reg <= 0;
            counter <= 0;
        end else begin
            x_reg <= x;

            if (init_xpowertwo)
                xpowertwo_reg <= x_sqr[30:15];
            else if (load_xpowertwo)
                xpowertwo_reg <= x_sqr[30:15]; 

            if (init_mult_reg)
                mult_reg <= x_reg;
            else if (load_mult_reg)
                mult_reg <= mult_out[30:15]; 

            if (init_result)
                result_reg <= x_reg;
            else if (load_result) begin
                if (counter[0] == 1'b0)
                    result_reg <= result_reg + mult_reg;
                else
                    result_reg <= result_reg - mult_reg;
            end 

            if (init_counter)
                counter <= 0;
            else if (inc_counter)
                counter <= counter + 1; 
        end
    end

    assign co = &counter;
    assign result = result_reg;

endmodule
