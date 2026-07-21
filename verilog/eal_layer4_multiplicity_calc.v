`timescale 1ns / 1ps

module eal_layer4_multiplicity_calc (
    input  wire        clk,
    input  wire        rst_n,
    input  wire [3:0]  i_local_nibble,

    output reg  [3:0]  o_tetra_weight,
    output reg         o_is_compact_branch,
    output reg         o_is_extended_branch
);
    reg [3:0] w_weight_comb;
    reg       w_compact_comb;
    reg       w_extended_comb;

    always @(*) begin
        w_compact_comb  = ~i_local_nibble[3];
        w_extended_comb =  i_local_nibble[3];

        case (i_local_nibble)
            4'h0: w_weight_comb = 4'd0;
            4'h1, 4'h7, 4'hF: w_weight_comb = 4'd1;
            4'h2, 4'h3, 4'h5, 4'h6, 4'h8, 4'h9, 4'hC, 4'hD:
                w_weight_comb = 4'd4;
            4'h4, 4'hA, 4'hE:
                w_weight_comb = 4'd6;
            4'hB:
                w_weight_comb = 4'd12;
            default:
                w_weight_comb = 4'd0;
        endcase
    end

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            o_tetra_weight       <= 4'd0;
            o_is_compact_branch  <= 1'b1;
            o_is_extended_branch <= 1'b0;
        end else begin
            o_tetra_weight       <= w_weight_comb;
            o_is_compact_branch  <= w_compact_comb;
            o_is_extended_branch <= w_extended_comb;
        end
    end
endmodule
