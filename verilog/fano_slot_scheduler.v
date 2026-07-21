`timescale 1ns / 1ps

/*
 * Fano 7! Slot Scheduler
 * ---------------------------------------------------------------------------
 * Optional RTL block for the 5040-state replay index decomposition:
 *
 *   slot5040 = fano7 * 720 + role3 * 240 + local240
 *
 * This is a scheduler/index projection. It does not validate relations, merge
 * origins, or issue attestations.
 */
module fano_slot_scheduler (
    input  wire        clk,
    input  wire        rst_n,

    input  wire [2:0]  i_fano7,
    input  wire [1:0]  i_role3,
    input  wire [7:0]  i_local240,

    output reg  [12:0] o_slot5040,
    output reg         o_bounds_fault
);

    reg [12:0] w_fano_term;
    reg [12:0] w_role_term;
    reg [12:0] w_total_sum;
    reg        w_fault_comb;

    always @(*) begin
        w_fano_term = ({10'b0, i_fano7} << 9) +
                      ({10'b0, i_fano7} << 7) +
                      ({10'b0, i_fano7} << 6) +
                      ({10'b0, i_fano7} << 4);

        w_role_term = ({11'b0, i_role3} << 7) +
                      ({11'b0, i_role3} << 6) +
                      ({11'b0, i_role3} << 5) +
                      ({11'b0, i_role3} << 4);

        w_total_sum = w_fano_term + w_role_term + {5'b0, i_local240};
        w_fault_comb = (i_fano7 > 3'd6) || (i_role3 > 2'd2) || (i_local240 >= 8'd240);
    end

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            o_slot5040     <= 13'd0;
            o_bounds_fault <= 1'b0;
        end else begin
            o_bounds_fault <= w_fault_comb;
            if (w_fault_comb) begin
                o_slot5040 <= 13'd0;
            end else begin
                o_slot5040 <= w_total_sum;
            end
        end
    end
endmodule
