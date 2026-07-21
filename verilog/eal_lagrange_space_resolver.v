`timescale 1ns / 1ps

module eal_lagrange_space_resolver (
    input  wire       clk,
    input  wire       rst_n,

    input  wire [7:0] i_stream_byte,
    input  wire [4:0] i_manual_slot,
    input  wire [1:0] i_manual_band,
    input  wire       i_trigger_fold,

    output reg  [1:0] o_unfolded_band,
    output reg  [4:0] o_unfolded_slot,
    output reg  [7:0] o_folded_byte,
    output reg [15:0] o_canvas_x,
    output reg [15:0] o_canvas_y,
    output reg        o_byte_bounds_fault
);
    reg [1:0]  w_band_comb;
    reg [4:0]  w_slot_comb;
    reg [7:0]  w_byte_comb;
    reg [15:0] w_proj_x;
    reg [15:0] w_proj_y;
    reg        w_fault_comb;

    always @(*) begin
        w_fault_comb = i_stream_byte[7];
        w_band_comb = i_stream_byte[6:5];
        w_slot_comb = i_stream_byte[4:0];

        if (i_trigger_fold) begin
            w_byte_comb = {1'b0, i_manual_band, i_manual_slot};
        end else begin
            w_byte_comb = {1'b0, i_stream_byte[6:0]};
        end

        case (w_band_comb)
            2'b00: begin
                w_proj_x = 16'd0;
                w_proj_y = {7'd0, w_slot_comb, 4'b0000};
            end
            2'b01: begin
                w_proj_x = {7'd0, w_slot_comb, 4'b0000};
                w_proj_y = 16'd0;
            end
            2'b10: begin
                w_proj_x = 16'd512;
                w_proj_y = {7'd0, w_slot_comb, 4'b0000};
            end
            default: begin
                w_proj_x = {7'd0, w_slot_comb, 4'b0000};
                w_proj_y = 16'd512;
            end
        endcase
    end

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            o_unfolded_band    <= 2'b00;
            o_unfolded_slot    <= 5'b00000;
            o_folded_byte      <= 8'h00;
            o_canvas_x         <= 16'd0;
            o_canvas_y         <= 16'd0;
            o_byte_bounds_fault <= 1'b0;
        end else begin
            o_unfolded_band    <= w_band_comb;
            o_unfolded_slot    <= w_slot_comb;
            o_folded_byte      <= w_byte_comb;
            o_canvas_x         <= w_proj_x;
            o_canvas_y         <= w_proj_y;
            o_byte_bounds_fault <= w_fault_comb;
        end
    end
endmodule
