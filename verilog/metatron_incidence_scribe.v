`timescale 1ns / 1ps

/*
 * Metatron Incidence Scribe
 * ---------------------------------------------------------------------------
 * Isolated RTL block for place-value inscription and gauge-plane tracking.
 *
 * This module records route/place information. It is not the Tetragrammatron
 * validation gate and does not accept relations or emit attestations.
 */
module metatron_incidence_scribe (
    input  wire        clk,
    input  wire        rst_n,

    input  wire        i_step_cmd,
    input  wire [7:0]  i_sector_prefix,
    input  wire [7:0]  i_gauge_polarity,

    output reg  [15:0] o_gauge_register,
    output reg  [7:0]  o_incidence_witness,
    output reg  [23:0] o_plane_flags,
    output reg         o_gauge_carry
);

    localparam [15:0] GAUGE_FS = 16'h0001;
    localparam [7:0]  WITNESS_MASK = 8'h18;

    reg [15:0] r_next_gauge;
    reg [23:0] r_next_flags;
    reg        r_carry_comb;
    reg [7:0]  r_witness_comb;
    reg        r_sector_valid;

    always @(*) begin
        if (i_step_cmd) begin
            {r_carry_comb, r_next_gauge} = {1'b0, o_gauge_register} << 4;
        end else begin
            r_next_gauge = o_gauge_register;
            r_carry_comb = 1'b0;
        end

        r_sector_valid = (i_sector_prefix == 8'h00) ||
                         (i_sector_prefix == 8'h20) ||
                         (i_sector_prefix == 8'h40) ||
                         (i_sector_prefix == 8'h60);

        r_witness_comb = i_sector_prefix ^
                         (i_sector_prefix ^ 8'h1B) ^
                         (i_sector_prefix ^ 8'h1C) ^
                         (i_sector_prefix ^ 8'h1F);

        r_next_flags = {
            (i_gauge_polarity[7] & i_gauge_polarity[6]),
            (i_gauge_polarity[7] & i_gauge_polarity[5]),
            (i_gauge_polarity[7] & i_gauge_polarity[4]),
            (i_gauge_polarity[6] & i_gauge_polarity[5]),
            (i_gauge_polarity[6] & i_gauge_polarity[4]),
            (i_gauge_polarity[5] & i_gauge_polarity[4]),
            (i_gauge_polarity[3] & i_gauge_polarity[2]),
            (i_gauge_polarity[3] & i_gauge_polarity[1]),
            (i_gauge_polarity[3] & i_gauge_polarity[0]),
            (i_gauge_polarity[2] & i_gauge_polarity[1]),
            (i_gauge_polarity[2] & i_gauge_polarity[0]),
            (i_gauge_polarity[1] & i_gauge_polarity[0]),
            12'b0
        };
    end

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            o_gauge_register    <= GAUGE_FS;
            o_incidence_witness <= 8'h00;
            o_plane_flags       <= 24'd0;
            o_gauge_carry       <= 1'b0;
        end else begin
            o_gauge_register <= r_next_gauge;
            o_plane_flags    <= r_next_flags;
            o_gauge_carry    <= r_carry_comb;

            if (r_sector_valid && r_witness_comb == WITNESS_MASK) begin
                o_incidence_witness <= WITNESS_MASK;
            end else begin
                o_incidence_witness <= 8'h00;
            end
        end
    end
endmodule
