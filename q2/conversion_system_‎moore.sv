module conversion_system_moore (
    input logic clk,
    input logic rst_n,
    input logic x,
    output logic z
);

    typedef enum logic {
        S0, S1
    } state;
	
    state present_state, next_state;

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            present_state <= S0;
        else
            present_state <= next_state;
    end

    always_comb begin
        case (present_state)
            S0: next_state = x ? S0 : S1;
            S1: next_state = x ? S1 : S0;
            default: next_state = S0;
        endcase
    end

    always_comb begin
        z = (present_state == S0) ? 1 : 0;
    end

endmodule
