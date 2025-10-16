module average_calc_controller #(parameter n = 4) (
    input logic clk,
    input logic rst_n,
    input logic start,
    output logic init_sum,
    output logic init_shift,
    output logic load,
    output logic shift,
    output logic done
);

    localparam int k = $clog2(n);

    typedef enum logic [1:0] {IDLE, INIT, LOAD, SHIFT} state_t;

    state_t current_state, next_state;
    logic [k-1:0] count;
    logic init_counter, inc_counter, co;
    
    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            current_state <= IDLE;
        else
            current_state <= next_state;
    end

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            count <= 0;
        else if (init_counter)
            count <= 0;
        else if (inc_counter)
            count <= count + 1;
    end

    assign co = (count == n-1);

    always_comb begin
        next_state = current_state;
        init_sum = 0;
        init_shift = 0;
        load = 0;
        shift = 0;
        done = 0;
        init_counter = 0;
        inc_counter = 0;

        case(current_state)
            IDLE: begin
                done = 1;
                next_state = (start) ? INIT : IDLE;
            end
            INIT: begin
                init_sum = 1;
                init_shift = 1;
                init_counter = 1;
                next_state = (start) ? INIT : LOAD;
            end
            LOAD: begin
                load = 1;
                inc_counter = 1;
                next_state = (co) ? SHIFT : LOAD;
            end
            SHIFT: begin
                shift = 1;
                next_state = IDLE;
            end
        endcase
    end

endmodule