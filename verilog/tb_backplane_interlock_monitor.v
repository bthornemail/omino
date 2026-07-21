`timescale 1ns / 1ps

module tb_backplane_interlock_monitor;
    reg         clk;
    reg         rst_n;
    reg  [7:0]  i_local_azimuth;
    reg  [7:0]  i_remote_azimuth;
    reg  [12:0] i_tetra_sum;
    reg         i_hamming_double_err;

    wire        o_lockout_n;
    wire [1:0]  o_diagnose_fault_id;

    integer failures;

    backplane_interlock_monitor dut (
        .clk(clk),
        .rst_n(rst_n),
        .i_local_azimuth(i_local_azimuth),
        .i_remote_azimuth(i_remote_azimuth),
        .i_tetra_sum(i_tetra_sum),
        .i_hamming_double_err(i_hamming_double_err),
        .o_lockout_n(o_lockout_n),
        .o_diagnose_fault_id(o_diagnose_fault_id)
    );

    initial begin
        clk = 1'b0;
        forever #5 clk = ~clk;
    end

    task apply_vector;
        input [7:0] local_azimuth;
        input [7:0] remote_azimuth;
        input [12:0] tetra_sum;
        input hamming_double_err;
        input expected_lockout_n;
        input [1:0] expected_fault_id;
        begin
            i_local_azimuth = local_azimuth;
            i_remote_azimuth = remote_azimuth;
            i_tetra_sum = tetra_sum;
            i_hamming_double_err = hamming_double_err;
            @(posedge clk);
            #1;
            if (o_lockout_n !== expected_lockout_n ||
                o_diagnose_fault_id !== expected_fault_id) begin
                $display("FAIL local=%h remote=%h tetra=%0d ham=%b lockout=%b/%b fault=%b/%b",
                    local_azimuth, remote_azimuth, tetra_sum, hamming_double_err,
                    o_lockout_n, expected_lockout_n,
                    o_diagnose_fault_id, expected_fault_id);
                failures = failures + 1;
            end
        end
    endtask

    initial begin
        failures = 0;
        i_local_azimuth = 8'h00;
        i_remote_azimuth = 8'h80;
        i_tetra_sum = 13'd120;
        i_hamming_double_err = 1'b0;

        rst_n = 1'b0;
        repeat (2) @(posedge clk);
        rst_n = 1'b1;

        apply_vector(8'h00, 8'h80, 13'd120, 1'b0, 1'b1, 2'b00);
        apply_vector(8'h20, 8'hA0, 13'd120, 1'b0, 1'b1, 2'b00);
        apply_vector(8'h00, 8'h00, 13'd120, 1'b0, 1'b0, 2'b01);
        apply_vector(8'h00, 8'h80, 13'd119, 1'b0, 1'b0, 2'b10);
        apply_vector(8'h00, 8'h00, 13'd119, 1'b0, 1'b0, 2'b10);
        apply_vector(8'h00, 8'h80, 13'd120, 1'b1, 1'b0, 2'b11);
        apply_vector(8'h00, 8'h00, 13'd119, 1'b1, 1'b0, 2'b11);

        if (failures == 0) begin
            $display("PASS backplane_interlock_monitor vectors");
            $finish;
        end

        $fatal(1, "FAIL backplane_interlock_monitor failures=%0d", failures);
    end
endmodule
