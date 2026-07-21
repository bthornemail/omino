`timescale 1ns / 1ps

module tb_omino_visual_matrix_projector;
    reg       clk;
    reg       rst_n;
    reg [3:0] i_local_nibble;

    wire [3:0] o_matrix_row_x;
    wire [3:0] o_matrix_col_y;
    wire       o_view_is_inert;

    integer failures;
    integer i;

    omino_visual_matrix_projector dut (
        .clk(clk),
        .rst_n(rst_n),
        .i_local_nibble(i_local_nibble),
        .o_matrix_row_x(o_matrix_row_x),
        .o_matrix_col_y(o_matrix_col_y),
        .o_view_is_inert(o_view_is_inert)
    );

    initial begin
        clk = 1'b0;
        forever #5 clk = ~clk;
    end

    task apply_vector;
        input [3:0] nibble;
        input [3:0] expected_row;
        input [3:0] expected_col;
        begin
            i_local_nibble = nibble;
            @(posedge clk);
            #1;
            if (o_matrix_row_x !== expected_row ||
                o_matrix_col_y !== expected_col ||
                o_view_is_inert !== 1'b1) begin
                $display("FAIL visual nibble=%h row=%h/%h col=%h/%h inert=%b",
                    nibble,
                    o_matrix_row_x, expected_row,
                    o_matrix_col_y, expected_col,
                    o_view_is_inert);
                failures = failures + 1;
            end
        end
    endtask

    initial begin
        failures = 0;
        i_local_nibble = 4'h0;

        rst_n = 1'b0;
        repeat (2) @(posedge clk);
        if (o_view_is_inert !== 1'b1) begin
            $display("FAIL visual reset did not keep inert view high");
            failures = failures + 1;
        end
        rst_n = 1'b1;

        for (i = 0; i < 16; i = i + 1) begin
            apply_vector(i[3:0], {2'b00, i[3:2]}, {2'b00, i[1:0]});
        end

        if (failures == 0) begin
            $display("PASS omino_visual_matrix_projector vectors");
            $finish;
        end

        $fatal(1, "FAIL omino_visual_matrix_projector failures=%0d", failures);
    end
endmodule
