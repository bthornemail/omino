`timescale 1ns / 1ps

module tb_eal_layer4_multiplicity_calc;
    reg        clk;
    reg        rst_n;
    reg [3:0]  i_local_nibble;

    wire [3:0] o_tetra_weight;
    wire       o_is_compact_branch;
    wire       o_is_extended_branch;

    integer failures;

    eal_layer4_multiplicity_calc dut (
        .clk(clk),
        .rst_n(rst_n),
        .i_local_nibble(i_local_nibble),
        .o_tetra_weight(o_tetra_weight),
        .o_is_compact_branch(o_is_compact_branch),
        .o_is_extended_branch(o_is_extended_branch)
    );

    initial begin
        clk = 1'b0;
        forever #5 clk = ~clk;
    end

    task apply_vector;
        input [3:0] nibble;
        input [3:0] expected_weight;
        input expected_compact;
        input expected_extended;
        begin
            i_local_nibble = nibble;
            @(posedge clk);
            #1;
            if (o_tetra_weight !== expected_weight ||
                o_is_compact_branch !== expected_compact ||
                o_is_extended_branch !== expected_extended) begin
                $display("FAIL nibble=%h weight=%h/%h compact=%b/%b extended=%b/%b",
                    nibble,
                    o_tetra_weight, expected_weight,
                    o_is_compact_branch, expected_compact,
                    o_is_extended_branch, expected_extended);
                failures = failures + 1;
            end
        end
    endtask

    initial begin
        failures = 0;
        i_local_nibble = 4'h0;

        rst_n = 1'b0;
        repeat (2) @(posedge clk);
        rst_n = 1'b1;

        apply_vector(4'h0, 4'd0,  1'b1, 1'b0);
        apply_vector(4'h1, 4'd1,  1'b1, 1'b0);
        apply_vector(4'h2, 4'd4,  1'b1, 1'b0);
        apply_vector(4'h3, 4'd4,  1'b1, 1'b0);
        apply_vector(4'h4, 4'd6,  1'b1, 1'b0);
        apply_vector(4'h5, 4'd4,  1'b1, 1'b0);
        apply_vector(4'h6, 4'd4,  1'b1, 1'b0);
        apply_vector(4'h7, 4'd1,  1'b1, 1'b0);
        apply_vector(4'h8, 4'd4,  1'b0, 1'b1);
        apply_vector(4'h9, 4'd4,  1'b0, 1'b1);
        apply_vector(4'hA, 4'd6,  1'b0, 1'b1);
        apply_vector(4'hB, 4'd12, 1'b0, 1'b1);
        apply_vector(4'hC, 4'd4,  1'b0, 1'b1);
        apply_vector(4'hD, 4'd4,  1'b0, 1'b1);
        apply_vector(4'hE, 4'd6,  1'b0, 1'b1);
        apply_vector(4'hF, 4'd1,  1'b0, 1'b1);

        if (failures == 0) begin
            $display("PASS eal_layer4_multiplicity_calc vectors");
            $finish;
        end

        $fatal(1, "FAIL eal_layer4_multiplicity_calc failures=%0d", failures);
    end
endmodule
