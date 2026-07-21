`timescale 1ns / 1ps

/*
 * Omnicron BQF Resolver
 * ---------------------------------------------------------------------------
 * Optional RTL block for COBS-CONS byte-surface classification and diagnostic
 * 4-scaled binary quadratic form evaluation.
 *
 * This block reports routing/interlock signals. It does not validate relations,
 * merge origins, or issue receipts.
 */
module omnicron_bqf_resolver (
    input  wire        clk,
    input  wire        rst_n,

    input  wire [7:0]  i_x_field,
    input  wire [7:0]  i_y_unit,
    input  wire [7:0]  i_stream_byte,

    output reg  [31:0] o_address_energy,
    output reg  [1:0]  o_byte_band,
    output reg         o_delineation_active,
    output reg         o_null_boundary_trap
);

    reg [15:0] w_x2;
    reg [15:0] w_y2;
    reg [15:0] w_xy;
    reg [31:0] w_term_x;
    reg [31:0] w_term_xy;
    reg [31:0] w_term_y;
    reg [31:0] w_energy_sum;
    reg [1:0]  w_band_comb;
    reg        w_delin_comb;
    reg        w_null_trap;

    always @(*) begin
        w_x2 = i_x_field * i_x_field;
        w_y2 = i_y_unit * i_y_unit;
        w_xy = i_x_field * i_y_unit;

        w_term_x = 32'd60 * w_x2;
        w_term_xy = {12'b0, w_xy, 4'b0000};
        w_term_y = {14'b0, w_y2, 2'b00};
        w_energy_sum = w_term_x + w_term_xy + w_term_y;

        w_null_trap = (i_stream_byte == 8'h00);
        w_delin_comb = (i_stream_byte[7:4] >= 4'hB);

        if (i_stream_byte <= 8'h1F) begin
            w_band_comb = 2'b00;
        end else if (i_stream_byte <= 8'h7F) begin
            w_band_comb = 2'b01;
        end else if (i_stream_byte <= 8'hAF) begin
            w_band_comb = 2'b11;
        end else begin
            w_band_comb = 2'b10;
        end
    end

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            o_address_energy     <= 32'd0;
            o_byte_band          <= 2'b00;
            o_delineation_active <= 1'b0;
            o_null_boundary_trap <= 1'b0;
        end else begin
            o_address_energy     <= w_energy_sum;
            o_byte_band          <= w_band_comb;
            o_delineation_active <= w_delin_comb;
            o_null_boundary_trap <= w_null_trap;
        end
    end
endmodule
