`timescale 1ns / 1ps

module tb_omnicron_bqf_resolver;
    reg         clk;
    reg         rst_n;
    reg  [7:0]  i_x_field;
    reg  [7:0]  i_y_unit;
    reg  [7:0]  i_stream_byte;

    wire [31:0] o_address_energy;
    wire [1:0]  o_byte_band;
    wire        o_delineation_active;
    wire        o_null_boundary_trap;

    integer failures;

    omnicron_bqf_resolver dut (
        .clk(clk),
        .rst_n(rst_n),
        .i_x_field(i_x_field),
        .i_y_unit(i_y_unit),
        .i_stream_byte(i_stream_byte),
        .o_address_energy(o_address_energy),
        .o_byte_band(o_byte_band),
        .o_delineation_active(o_delineation_active),
        .o_null_boundary_trap(o_null_boundary_trap)
    );

    initial begin
        clk = 1'b0;
        forever #5 clk = ~clk;
    end

    task apply_vector;
        input [7:0] x_field;
        input [7:0] y_unit;
        input [7:0] stream_byte;
        input [31:0] expected_energy;
        input [1:0] expected_band;
        input expected_delineation;
        input expected_null_trap;
        begin
            i_x_field = x_field;
            i_y_unit = y_unit;
            i_stream_byte = stream_byte;
            @(posedge clk);
            #1;
            if (o_address_energy !== expected_energy ||
                o_byte_band !== expected_band ||
                o_delineation_active !== expected_delineation ||
                o_null_boundary_trap !== expected_null_trap) begin
                $display("FAIL x=%h y=%h byte=%h energy=%h/%h band=%b/%b delin=%b/%b null=%b/%b",
                    x_field, y_unit, stream_byte,
                    o_address_energy, expected_energy,
                    o_byte_band, expected_band,
                    o_delineation_active, expected_delineation,
                    o_null_boundary_trap, expected_null_trap);
                failures = failures + 1;
            end
        end
    endtask

    initial begin
        failures = 0;
        i_x_field = 8'h00;
        i_y_unit = 8'h00;
        i_stream_byte = 8'h00;

        rst_n = 1'b0;
        repeat (2) @(posedge clk);
        rst_n = 1'b1;

        apply_vector(8'd15, 8'd4, 8'h3F, 32'd14524, 2'b01, 1'b0, 1'b0);
        apply_vector(8'd0, 8'd0, 8'h00, 32'd0, 2'b00, 1'b0, 1'b1);
        apply_vector(8'd1, 8'd1, 8'h1F, 32'd80, 2'b00, 1'b0, 1'b0);
        apply_vector(8'd15, 8'd4, 8'h80, 32'd14524, 2'b11, 1'b0, 1'b0);
        apply_vector(8'd15, 8'd4, 8'hAF, 32'd14524, 2'b11, 1'b0, 1'b0);
        apply_vector(8'd15, 8'd4, 8'hB0, 32'd14524, 2'b10, 1'b1, 1'b0);
        apply_vector(8'd255, 8'd255, 8'hFF, 32'd5202000, 2'b10, 1'b1, 1'b0);

        if (failures == 0) begin
            $display("PASS omnicron_bqf_resolver vectors");
            $finish;
        end

        $fatal(1, "FAIL omnicron_bqf_resolver failures=%0d", failures);
    end
endmodule
