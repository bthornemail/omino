`timescale 1ns / 1ps

module tb_eal_metamorphic_export_validator;
    reg       clk;
    reg       rst_n;
    reg [7:0] i_eal_byte;
    reg       i_eal_valid;
    reg [7:0] i_void_byte;
    reg       i_void_valid;

    wire      o_export_identity_ok;
    wire      o_bus_interlock_lock;

    integer failures;

    eal_metamorphic_export_validator dut (
        .clk(clk),
        .rst_n(rst_n),
        .i_eal_byte(i_eal_byte),
        .i_eal_valid(i_eal_valid),
        .i_void_byte(i_void_byte),
        .i_void_valid(i_void_valid),
        .o_export_identity_ok(o_export_identity_ok),
        .o_bus_interlock_lock(o_bus_interlock_lock)
    );

    initial begin
        clk = 1'b0;
        forever #5 clk = ~clk;
    end

    task apply_vector;
        input [7:0] eal_byte;
        input eal_valid;
        input [7:0] void_byte;
        input void_valid;
        input expected_ok;
        input expected_lock;
        begin
            i_eal_byte = eal_byte;
            i_eal_valid = eal_valid;
            i_void_byte = void_byte;
            i_void_valid = void_valid;
            @(posedge clk);
            #1;
            if (o_export_identity_ok !== expected_ok ||
                o_bus_interlock_lock !== expected_lock) begin
                $display("FAIL eal=%h/%b void=%h/%b ok=%b/%b lock=%b/%b",
                    eal_byte, eal_valid, void_byte, void_valid,
                    o_export_identity_ok, expected_ok,
                    o_bus_interlock_lock, expected_lock);
                failures = failures + 1;
            end
        end
    endtask

    initial begin
        failures = 0;
        i_eal_byte = 8'h00;
        i_eal_valid = 1'b0;
        i_void_byte = 8'h00;
        i_void_valid = 1'b0;

        rst_n = 1'b0;
        repeat (2) @(posedge clk);
        rst_n = 1'b1;

        apply_vector(8'h00, 1'b0, 8'hFF, 1'b0, 1'b1, 1'b0);
        apply_vector(8'hF8, 1'b1, 8'hF8, 1'b1, 1'b1, 1'b0);
        apply_vector(8'h1C, 1'b1, 8'h1C, 1'b1, 1'b1, 1'b0);
        apply_vector(8'h45, 1'b1, 8'h00, 1'b1, 1'b0, 1'b1);
        apply_vector(8'h20, 1'b1, 8'h20, 1'b1, 1'b1, 1'b1);
        apply_vector(8'hAA, 1'b1, 8'h55, 1'b0, 1'b1, 1'b1);

        rst_n = 1'b0;
        @(posedge clk);
        #1;
        if (o_export_identity_ok !== 1'b1 || o_bus_interlock_lock !== 1'b0) begin
            $display("FAIL reset did not clear metamorphic export validator");
            failures = failures + 1;
        end

        if (failures == 0) begin
            $display("PASS eal_metamorphic_export_validator vectors");
            $finish;
        end

        $fatal(1, "FAIL eal_metamorphic_export_validator failures=%0d", failures);
    end
endmodule
