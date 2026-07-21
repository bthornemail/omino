`timescale 1ns / 1ps

/*
 * EAL Octahedral Face Router
 * ---------------------------------------------------------------------------
 * Optional RTL projection of the canonical 8-selector table onto the
 * Knowledge Triple octahedral face view.
 *
 * This module is a router/projection backend. It does not validate relations,
 * emit receipts, or replace .o provenance.
 */
module eal_octahedral_face_router (
    input  wire        clk,
    input  wire        rst_n,
    input  wire [15:0] i_cons_address,

    output reg  [2:0]  o_active_face,
    output reg         o_interface_6_4,
    output reg         o_interface_8_3,
    output reg         o_centroid_lock
);

    wire [7:0] w_compressed;
    wire [3:0] w_row_nibble;
    wire [3:0] w_col_nibble;
    wire [2:0] w_face_comb;

    /* Compress 16-bit 0xY0X0 into 8-bit 0xYX. The canonical selector law
     * reads two high row bits and one high column bit:
     *
     *   face[2:1] = row_nibble[3:2]
     *   face[0]   = col_nibble[3]
     */
    assign w_compressed = {i_cons_address[15:12], i_cons_address[7:4]};
    assign w_row_nibble = w_compressed[7:4];
    assign w_col_nibble = w_compressed[3:0];
    assign w_face_comb = {w_row_nibble[3:2], w_col_nibble[3]};

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            o_active_face   <= 3'd0;
            o_interface_6_4 <= 1'b1;
            o_interface_8_3 <= 1'b0;
            o_centroid_lock <= 1'b1;
        end else begin
            o_active_face   <= w_face_comb;
            o_interface_6_4 <= ~w_face_comb[2];
            o_interface_8_3 <= w_face_comb[2];
            o_centroid_lock <= (i_cons_address == 16'h0000);
        end
    end
endmodule
