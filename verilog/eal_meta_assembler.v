`timescale 1ns / 1ps

/*
 * EAL Meta Assembler
 * ---------------------------------------------------------------------------
 * Optional RTL block that packs a modeled Core IR opcode and slot payload into
 * a 16-bit machine word after checking slot and 7-bit token bounds.
 */
module eal_meta_assembler (
    input  wire        clk,
    input  wire        rst_n,

    input  wire [3:0]  i_core_opcode,
    input  wire [12:0] i_slot5040,
    input  wire [7:0]  i_character_token,

    output reg  [15:0] o_machine_instruction,
    output reg         o_is_centroid_core,
    output reg         o_assembler_ready
);

    reg [15:0] w_compiled_word;
    reg        w_ready_comb;
    reg        w_void_comb;

    always @(*) begin
        w_compiled_word = {i_core_opcode, i_slot5040[11:0]};
        w_void_comb = (w_compiled_word == 16'h0000);
        w_ready_comb = (i_slot5040 < 13'd5040) && (i_character_token <= 8'h7F);
    end

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            o_machine_instruction <= 16'h0000;
            o_is_centroid_core    <= 1'b1;
            o_assembler_ready     <= 1'b0;
        end else begin
            o_assembler_ready <= w_ready_comb;

            if (w_ready_comb) begin
                o_machine_instruction <= w_compiled_word;
                o_is_centroid_core    <= w_void_comb;
            end else begin
                o_machine_instruction <= 16'h0000;
                o_is_centroid_core    <= 1'b1;
            end
        end
    end
endmodule
