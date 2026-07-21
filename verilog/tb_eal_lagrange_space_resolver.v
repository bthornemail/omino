`timescale 1ns / 1ps

module tb_eal_lagrange_space_resolver;
    reg       clk;
    reg       rst_n;
    reg [7:0] i_stream_byte;
    reg [4:0] i_manual_slot;
    reg [1:0] i_manual_band;
    reg       i_trigger_fold;

    wire [1:0]  o_unfolded_band;
    wire [4:0]  o_unfolded_slot;
    wire [7:0]  o_folded_byte;
    wire [15:0] o_canvas_x;
    wire [15:0] o_canvas_y;
    wire        o_byte_bounds_fault;

    integer failures;

    eal_lagrange_space_resolver dut (
        .clk(clk),
        .rst_n(rst_n),
        .i_stream_byte(i_stream_byte),
        .i_manual_slot(i_manual_slot),
        .i_manual_band(i_manual_band),
        .i_trigger_fold(i_trigger_fold),
        .o_unfolded_band(o_unfolded_band),
        .o_unfolded_slot(o_unfolded_slot),
        .o_folded_byte(o_folded_byte),
        .o_canvas_x(o_canvas_x),
        .o_canvas_y(o_canvas_y),
        .o_byte_bounds_fault(o_byte_bounds_fault)
    );

    initial begin
        clk = 1'b0;
        forever #5 clk = ~clk;
    end

    task apply_vector;
        input [7:0] stream_byte;
        input [4:0] manual_slot;
        input [1:0] manual_band;
        input trigger_fold;
        input [1:0] expected_band;
        input [4:0] expected_slot;
        input [7:0] expected_folded;
        input [15:0] expected_x;
        input [15:0] expected_y;
        input expected_fault;
        begin
            i_stream_byte = stream_byte;
            i_manual_slot = manual_slot;
            i_manual_band = manual_band;
            i_trigger_fold = trigger_fold;
            @(posedge clk);
            #1;
            if (o_unfolded_band !== expected_band ||
                o_unfolded_slot !== expected_slot ||
                o_folded_byte !== expected_folded ||
                o_canvas_x !== expected_x ||
                o_canvas_y !== expected_y ||
                o_byte_bounds_fault !== expected_fault) begin
                $display("FAIL lagrange byte=%h band=%h/%h slot=%h/%h folded=%h/%h x=%d/%d y=%d/%d fault=%b/%b",
                    stream_byte,
                    o_unfolded_band, expected_band,
                    o_unfolded_slot, expected_slot,
                    o_folded_byte, expected_folded,
                    o_canvas_x, expected_x,
                    o_canvas_y, expected_y,
                    o_byte_bounds_fault, expected_fault);
                failures = failures + 1;
            end
        end
    endtask

    initial begin
        failures = 0;
        i_stream_byte = 8'h00;
        i_manual_slot = 5'd0;
        i_manual_band = 2'd0;
        i_trigger_fold = 1'b0;

        rst_n = 1'b0;
        repeat (2) @(posedge clk);
        rst_n = 1'b1;

        apply_vector(8'h00, 5'd0, 2'd0, 1'b0, 2'd0, 5'd0, 8'h00, 16'd0, 16'd0, 1'b0);
        apply_vector(8'h1F, 5'd0, 2'd0, 1'b0, 2'd0, 5'd31, 8'h1F, 16'd0, 16'd496, 1'b0);
        apply_vector(8'h20, 5'd0, 2'd0, 1'b0, 2'd1, 5'd0, 8'h20, 16'd0, 16'd0, 1'b0);
        apply_vector(8'h3A, 5'd0, 2'd0, 1'b0, 2'd1, 5'd26, 8'h3A, 16'd416, 16'd0, 1'b0);
        apply_vector(8'h40, 5'd0, 2'd0, 1'b0, 2'd2, 5'd0, 8'h40, 16'd512, 16'd0, 1'b0);
        apply_vector(8'h5F, 5'd0, 2'd0, 1'b0, 2'd2, 5'd31, 8'h5F, 16'd512, 16'd496, 1'b0);
        apply_vector(8'h60, 5'd0, 2'd0, 1'b0, 2'd3, 5'd0, 8'h60, 16'd0, 16'd512, 1'b0);
        apply_vector(8'h7F, 5'd0, 2'd0, 1'b0, 2'd3, 5'd31, 8'h7F, 16'd496, 16'd512, 1'b0);
        apply_vector(8'h12, 5'd21, 2'd3, 1'b1, 2'd0, 5'd18, 8'h75, 16'd0, 16'd288, 1'b0);
        apply_vector(8'h80, 5'd0, 2'd0, 1'b0, 2'd0, 5'd0, 8'h00, 16'd0, 16'd0, 1'b1);

        if (failures == 0) begin
            $display("PASS eal_lagrange_space_resolver vectors");
            $finish;
        end

        $fatal(1, "FAIL eal_lagrange_space_resolver failures=%0d", failures);
    end
endmodule
