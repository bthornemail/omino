`timescale 1ns / 1ps

module eal_metamorphic_export_validator (
    input  wire       clk,
    input  wire       rst_n,

    input  wire [7:0] i_eal_byte,
    input  wire       i_eal_valid,
    input  wire [7:0] i_void_byte,
    input  wire       i_void_valid,

    output reg        o_export_identity_ok,
    output reg        o_bus_interlock_lock
);
    reg w_match_comb;
    reg w_lock_comb;

    always @(*) begin
        if (i_eal_valid && i_void_valid) begin
            w_match_comb = (i_eal_byte == i_void_byte);
            w_lock_comb = (i_eal_byte != i_void_byte);
        end else begin
            w_match_comb = 1'b1;
            w_lock_comb = 1'b0;
        end
    end

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            o_export_identity_ok <= 1'b1;
            o_bus_interlock_lock <= 1'b0;
        end else begin
            o_export_identity_ok <= w_match_comb;
            if (w_lock_comb) begin
                o_bus_interlock_lock <= 1'b1;
            end
        end
    end
endmodule
