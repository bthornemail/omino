`timescale 1ns / 1ps

/*
 * EAL Lambda Canon Core
 * ---------------------------------------------------------------------------
 * Optional RTL backend for the Lambda Canon Block interlock described in:
 *
 *   dev-docs/Nibble-Interleaved Knowledge Triple Matrix - Native Projection Plan.md
 *
 * This module is not an authority replacement. It is a synthesizable candidate
 * for the deterministic interlock law and must match conformance vectors before
 * being treated as a conforming backend.
 */
module eal_lambda_canon_core (
    input  wire        clk,
    input  wire        rst_n,

    input  wire [15:0] i_x_omi,
    input  wire [15:0] i_y_imo,
    input  wire [7:0]  i_character_token,
    input  wire        i_received_omnion,

    output reg  [31:0] o_parabolic_eval,
    output reg         o_is_void_centroid,
    output reg         o_observer_boundary,
    output reg         o_is_admissible
);

    reg [17:0] w_4x;
    reg [17:0] w_2y;
    reg [17:0] w_linear_sum;
    reg        w_void_check;
    reg        w_obs_check;
    reg        w_omnion_check;

    always @(*) begin
        w_4x = {i_x_omi, 2'b00};
        w_2y = {1'b0, i_y_imo, 1'b0};
        w_linear_sum = w_4x + w_2y;

        w_void_check = (w_linear_sum == 18'd0);
        w_obs_check = (i_character_token == 8'h80);
        w_omnion_check = (i_received_omnion == ^{i_x_omi, i_y_imo, i_character_token});
    end

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            o_parabolic_eval    <= 32'd0;
            o_is_void_centroid  <= 1'b1;
            o_observer_boundary <= 1'b0;
            o_is_admissible     <= 1'b0;
        end else begin
            o_is_void_centroid  <= w_void_check;
            o_observer_boundary <= w_obs_check;

            if (i_character_token <= 8'h7F && w_omnion_check) begin
                o_is_admissible  <= 1'b1;
                o_parabolic_eval <= w_linear_sum * w_linear_sum;
            end else begin
                o_is_admissible  <= 1'b0;
                o_parabolic_eval <= 32'd0;
            end
        end
    end
endmodule
