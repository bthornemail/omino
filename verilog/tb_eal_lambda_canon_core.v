`timescale 1ns / 1ps

module tb_eal_lambda_canon_core;
    reg         clk;
    reg         rst_n;
    reg  [15:0] i_x_omi;
    reg  [15:0] i_y_imo;
    reg  [7:0]  i_character_token;
    reg         i_received_omnion;

    wire [31:0] o_parabolic_eval;
    wire        o_is_void_centroid;
    wire        o_observer_boundary;
    wire        o_is_admissible;

    integer failures;

    eal_lambda_canon_core dut (
        .clk(clk),
        .rst_n(rst_n),
        .i_x_omi(i_x_omi),
        .i_y_imo(i_y_imo),
        .i_character_token(i_character_token),
        .i_received_omnion(i_received_omnion),
        .o_parabolic_eval(o_parabolic_eval),
        .o_is_void_centroid(o_is_void_centroid),
        .o_observer_boundary(o_observer_boundary),
        .o_is_admissible(o_is_admissible)
    );

    initial begin
        clk = 1'b0;
        forever #5 clk = ~clk;
    end

    task apply_vector;
        input [15:0] x;
        input [15:0] y;
        input [7:0] token;
        input omnion;
        input [31:0] expected_eval;
        input expected_void;
        input expected_observer;
        input expected_admissible;
        begin
            i_x_omi = x;
            i_y_imo = y;
            i_character_token = token;
            i_received_omnion = omnion;
            @(posedge clk);
            #1;
            if (o_parabolic_eval !== expected_eval ||
                o_is_void_centroid !== expected_void ||
                o_observer_boundary !== expected_observer ||
                o_is_admissible !== expected_admissible) begin
                $display("FAIL x=%h y=%h token=%h omnion=%b eval=%h/%h void=%b/%b obs=%b/%b adm=%b/%b",
                    x, y, token, omnion,
                    o_parabolic_eval, expected_eval,
                    o_is_void_centroid, expected_void,
                    o_observer_boundary, expected_observer,
                    o_is_admissible, expected_admissible);
                failures = failures + 1;
            end
        end
    endtask

    initial begin
        failures = 0;
        i_x_omi = 16'h0000;
        i_y_imo = 16'h0000;
        i_character_token = 8'h00;
        i_received_omnion = 1'b0;

        rst_n = 1'b0;
        repeat (2) @(posedge clk);
        rst_n = 1'b1;

        apply_vector(16'h0000, 16'h0000, 8'h00, 1'b0, 32'h00000000, 1'b1, 1'b0, 1'b1);
        apply_vector(16'h0001, 16'h0000, 8'h20, 1'b0, 32'h00000010, 1'b0, 1'b0, 1'b1);
        apply_vector(16'h0000, 16'h0001, 8'h20, 1'b0, 32'h00000004, 1'b0, 1'b0, 1'b1);
        apply_vector(16'h0001, 16'h0001, 8'h20, 1'b1, 32'h00000024, 1'b0, 1'b0, 1'b1);
        apply_vector(16'h0002, 16'h0003, 8'h7F, 1'b0, 32'h000000C4, 1'b0, 1'b0, 1'b1);
        apply_vector(16'h0002, 16'h0003, 8'h80, 1'b0, 32'h00000000, 1'b0, 1'b1, 1'b0);
        apply_vector(16'h0002, 16'h0003, 8'h20, 1'b1, 32'h00000000, 1'b0, 1'b0, 1'b0);

        if (failures == 0) begin
            $display("PASS eal_lambda_canon_core vectors");
            $finish;
        end

        $fatal(1, "FAIL eal_lambda_canon_core failures=%0d", failures);
    end
endmodule
