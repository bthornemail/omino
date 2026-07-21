`timescale 1ns / 1ps

module tb_fano_slot_scheduler;
    reg         clk;
    reg         rst_n;
    reg  [2:0]  i_fano7;
    reg  [1:0]  i_role3;
    reg  [7:0]  i_local240;

    wire [12:0] o_slot5040;
    wire        o_bounds_fault;

    integer failures;

    fano_slot_scheduler dut (
        .clk(clk),
        .rst_n(rst_n),
        .i_fano7(i_fano7),
        .i_role3(i_role3),
        .i_local240(i_local240),
        .o_slot5040(o_slot5040),
        .o_bounds_fault(o_bounds_fault)
    );

    initial begin
        clk = 1'b0;
        forever #5 clk = ~clk;
    end

    task apply_vector;
        input [2:0] fano7;
        input [1:0] role3;
        input [7:0] local240;
        input [12:0] expected_slot;
        input expected_fault;
        begin
            i_fano7 = fano7;
            i_role3 = role3;
            i_local240 = local240;
            @(posedge clk);
            #1;
            if (o_slot5040 !== expected_slot || o_bounds_fault !== expected_fault) begin
                $display("FAIL fano=%h role=%h local=%h slot=%h/%h fault=%b/%b",
                    fano7, role3, local240,
                    o_slot5040, expected_slot,
                    o_bounds_fault, expected_fault);
                failures = failures + 1;
            end
        end
    endtask

    initial begin
        failures = 0;
        i_fano7 = 3'd0;
        i_role3 = 2'd0;
        i_local240 = 8'd0;

        rst_n = 1'b0;
        repeat (2) @(posedge clk);
        rst_n = 1'b1;

        apply_vector(3'd0, 2'd0, 8'd0, 13'd0, 1'b0);
        apply_vector(3'd2, 2'd1, 8'd100, 13'd1780, 1'b0);
        apply_vector(3'd6, 2'd2, 8'd239, 13'd5039, 1'b0);
        apply_vector(3'd7, 2'd0, 8'd0, 13'd0, 1'b1);
        apply_vector(3'd4, 2'd3, 8'd0, 13'd0, 1'b1);
        apply_vector(3'd4, 2'd1, 8'd250, 13'd0, 1'b1);

        if (failures == 0) begin
            $display("PASS fano_slot_scheduler vectors");
            $finish;
        end

        $fatal(1, "FAIL fano_slot_scheduler failures=%0d", failures);
    end
endmodule
