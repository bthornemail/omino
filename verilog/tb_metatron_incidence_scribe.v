`timescale 1ns / 1ps

module tb_metatron_incidence_scribe;
    reg         clk;
    reg         rst_n;
    reg         i_step_cmd;
    reg  [7:0]  i_sector_prefix;
    reg  [7:0]  i_gauge_polarity;

    wire [15:0] o_gauge_register;
    wire [7:0]  o_incidence_witness;
    wire [23:0] o_plane_flags;
    wire        o_gauge_carry;

    integer failures;

    metatron_incidence_scribe dut (
        .clk(clk),
        .rst_n(rst_n),
        .i_step_cmd(i_step_cmd),
        .i_sector_prefix(i_sector_prefix),
        .i_gauge_polarity(i_gauge_polarity),
        .o_gauge_register(o_gauge_register),
        .o_incidence_witness(o_incidence_witness),
        .o_plane_flags(o_plane_flags),
        .o_gauge_carry(o_gauge_carry)
    );

    initial begin
        clk = 1'b0;
        forever #5 clk = ~clk;
    end

    task apply_vector;
        input step_cmd;
        input [7:0] sector_prefix;
        input [7:0] gauge_polarity;
        input [15:0] expected_gauge;
        input [7:0] expected_witness;
        input [23:0] expected_flags;
        input expected_carry;
        begin
            i_step_cmd = step_cmd;
            i_sector_prefix = sector_prefix;
            i_gauge_polarity = gauge_polarity;
            @(posedge clk);
            #1;
            if (o_gauge_register !== expected_gauge ||
                o_incidence_witness !== expected_witness ||
                o_plane_flags !== expected_flags ||
                o_gauge_carry !== expected_carry) begin
                $display("FAIL step=%b sector=%h polarity=%h gauge=%h/%h witness=%h/%h flags=%h/%h carry=%b/%b",
                    step_cmd, sector_prefix, gauge_polarity,
                    o_gauge_register, expected_gauge,
                    o_incidence_witness, expected_witness,
                    o_plane_flags, expected_flags,
                    o_gauge_carry, expected_carry);
                failures = failures + 1;
            end
        end
    endtask

    initial begin
        failures = 0;
        i_step_cmd = 1'b0;
        i_sector_prefix = 8'h00;
        i_gauge_polarity = 8'h00;

        rst_n = 1'b0;
        repeat (2) @(posedge clk);
        rst_n = 1'b1;

        apply_vector(1'b0, 8'h20, 8'hF0, 16'h0001, 8'h18, 24'hFC0000, 1'b0);
        apply_vector(1'b1, 8'h20, 8'hF0, 16'h0010, 8'h18, 24'hFC0000, 1'b0);
        apply_vector(1'b1, 8'h40, 8'h0F, 16'h0100, 8'h18, 24'h03F000, 1'b0);
        apply_vector(1'b1, 8'h60, 8'hFF, 16'h1000, 8'h18, 24'hFFF000, 1'b0);
        apply_vector(1'b1, 8'h00, 8'h00, 16'h0000, 8'h18, 24'h000000, 1'b1);
        apply_vector(1'b0, 8'h15, 8'hF0, 16'h0000, 8'h00, 24'hFC0000, 1'b0);

        if (failures == 0) begin
            $display("PASS metatron_incidence_scribe vectors");
            $finish;
        end

        $fatal(1, "FAIL metatron_incidence_scribe failures=%0d", failures);
    end
endmodule
