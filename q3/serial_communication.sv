module serial_communication(
    input logic clk,
    input logic rst_n,
    input logic serData,
    output logic outValid
);

    typedef enum logic [2:0] {
        S0, S1, S2, S3, S4, S5, S6
    } state;
	
    state present_state, next_state;
    logic [4:0] Count;
    logic En_counter, Co;

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            present_state <= S0;
            Count <= 5'b0;
        end else begin
            present_state <= next_state;
            if (En_counter)
                Count <= Count + 1;
            else
                Count <= 5'b0;
        end
    end

    always_comb begin
        En_counter = 0;
        case (present_state)
            S0: next_state = (serData) ? S0 : S1;
            S1: next_state = (serData) ? S2 : S1;
            S2: next_state = (serData) ? S3 : S1;
            S3: next_state = (serData) ? S0 : S4;
            S4: next_state = (serData) ? S5 : S1;
            S5: next_state = (serData) ? S0 : S6;
            S6: begin
                En_counter = 1;
                if (Co) begin
                    next_state = S0;
                    En_counter = 0;
                end else
                    next_state = S6;
            end
            default: next_state = S0;
        endcase
    end

    assign outValid = (present_state == S6);
    assign Co = &Count;

endmodule