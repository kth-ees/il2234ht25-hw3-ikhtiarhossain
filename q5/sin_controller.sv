module sin_controller (
    input  logic        clk,
    input  logic        rst_n,
    input  logic        start,
    input  logic        co,
    output logic        done,
    output logic        load_xpowertwo,
    output logic        init_xpowertwo,
    output logic        load_mult_reg,
    output logic        init_mult_reg,
    output logic        load_result,
    output logic        init_result,
    output logic        inc_counter,
    output logic        init_counter,
    output logic        sel_mult_in
);

	typedef enum logic [2:0] {IDLE, INIT, LOAD, MULT1, MULT2, ADD} state_t;

    state_t present_state, next_state;

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            present_state <= IDLE;
        else
            present_state <= next_state;        
    end

    always_comb begin
        done            = 1'b0; 
        load_xpowertwo   = 1'b0; 
        init_xpowertwo  = 1'b0; 
        load_mult_reg    = 1'b0; 
        init_mult_reg   = 1'b0; 
        load_result      = 1'b0;
        init_result     = 1'b0; 
        inc_counter      = 1'b0;
        init_counter    = 1'b0; 
        sel_mult_in      = 1'b0;

        case (present_state)
            IDLE: begin
                next_state = (start)  ? INIT : IDLE;
                done  = 1'b1;
            end
            INIT: begin
                next_state = (start)  ? INIT : LOAD;
                init_counter    = 1'b1;
                init_result     = 1'b1;
                init_mult_reg   = 1'b1;
                init_xpowertwo  = 1'b1;
            end
            LOAD: begin
                next_state = MULT1;
                load_xpowertwo = 1'b1;
            end
            MULT1: begin
                next_state = MULT2;
                sel_mult_in = 1'b0;
                load_mult_reg = 1'b1;
            end
            MULT2: begin
                next_state = ADD;
                sel_mult_in = 1'b1;
                load_mult_reg = 1'b1;
            end
            ADD: begin
                next_state = (co) ? IDLE : MULT1;
                load_result   = 1'b1;
                inc_counter   = 1'b1;
            end 
            default: begin
                next_state = IDLE;
                done            = 1'b0; 
                load_xpowertwo   = 1'b0; 
                init_xpowertwo  = 1'b0; 
                load_mult_reg    = 1'b0; 
                init_mult_reg   = 1'b0; 
                load_result      = 1'b0;
                init_result     = 1'b0; 
                inc_counter      = 1'b0;
                init_counter    = 1'b0; 
                sel_mult_in      = 1'b0;
            end
        endcase
    end

endmodule