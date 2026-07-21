`timescale 1ns / 1ps

/*
 * Backplane Interlock Monitor
 * ---------------------------------------------------------------------------
 * Optional RTL monitor for Section 30/42-style backplane signals.
 *
 * This block asserts an active-low lockout when phase, Tetragrammatron sum,
 * or Hamming double-error signatures drift. It is an interlock monitor only:
 * it does not validate relations, merge origins, or issue attestations.
 */
module backplane_interlock_monitor (
    input  wire        clk,
    input  wire        rst_n,

    input  wire [7:0]  i_local_azimuth,
    input  wire [7:0]  i_remote_azimuth,

    input  wire [12:0] i_tetra_sum,
    input  wire        i_hamming_double_err,

    output reg         o_lockout_n,
    output reg  [1:0]  o_diagnose_fault_id
);

    localparam [7:0]  OMI_MIRROR_INVOLUTION = 8'h80;
    localparam [12:0] TETRA_SYSTEM_WITNESS  = 13'd120;

    reg        w_phase_fault;
    reg        w_tetra_fault;
    reg        w_global_trip;
    reg [1:0]  w_fault_id;

    always @(*) begin
        w_phase_fault = ((i_local_azimuth ^ i_remote_azimuth) != OMI_MIRROR_INVOLUTION);
        w_tetra_fault = (i_tetra_sum != TETRA_SYSTEM_WITNESS);

        if (i_hamming_double_err) begin
            w_fault_id = 2'b11;
            w_global_trip = 1'b1;
        end else if (w_tetra_fault) begin
            w_fault_id = 2'b10;
            w_global_trip = 1'b1;
        end else if (w_phase_fault) begin
            w_fault_id = 2'b01;
            w_global_trip = 1'b1;
        end else begin
            w_fault_id = 2'b00;
            w_global_trip = 1'b0;
        end
    end

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            o_lockout_n         <= 1'b1;
            o_diagnose_fault_id <= 2'b00;
        end else begin
            o_diagnose_fault_id <= w_fault_id;
            o_lockout_n <= (w_global_trip) ? 1'b0 : 1'b1;
        end
    end
endmodule
