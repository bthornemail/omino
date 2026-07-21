`timescale 1ns / 1ps

module omino_visual_matrix_projector (
    input  wire       clk,
    input  wire       rst_n,
    input  wire [3:0] i_local_nibble,

    output reg  [3:0] o_matrix_row_x,
    output reg  [3:0] o_matrix_col_y,
    output reg        o_view_is_inert
);
    reg [3:0] w_row_x_comb;
    reg [3:0] w_col_y_comb;

    always @(*) begin
        w_row_x_comb = {2'b00, i_local_nibble[3:2]};
        w_col_y_comb = {2'b00, i_local_nibble[1:0]};
    end

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            o_matrix_row_x  <= 4'd0;
            o_matrix_col_y  <= 4'd0;
            o_view_is_inert <= 1'b1;
        end else begin
            o_matrix_row_x  <= w_row_x_comb;
            o_matrix_col_y  <= w_col_y_comb;
            o_view_is_inert <= 1'b1;
        end
    end
endmodule
