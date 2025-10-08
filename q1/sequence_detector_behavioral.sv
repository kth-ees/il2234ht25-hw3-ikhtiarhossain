module sequence_detector_behavioral (
    input logic clk,
    input logic rst_n,
    input logic input_sequence,
    output logic detected
);

    typedef enum logic [2:0] {
        S0, S1, S2, S3, S4
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
            S0: next_state = (input_sequence) ? S1 : S0;
            S1: next_state = (input_sequence) ? S2 : S0;
            S2: next_state = (input_sequence) ? S3 : S0;
            S3: next_state = (input_sequence) ? S4 : S0;
            S4: next_state = (input_sequence) ? S4 : S0;
            default: next_state = S0;
        endcase
    end

    always_comb begin
        detected = (present_state == S4 && input_sequence) ? 1 : 0;
    end

endmodule