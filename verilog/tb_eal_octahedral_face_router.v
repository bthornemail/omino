`timescale 1ns / 1ps

module tb_eal_octahedral_face_router;
    reg         clk;
    reg         rst_n;
    reg  [15:0] i_cons_address;

    wire [2:0] o_active_face;
    wire       o_interface_6_4;
    wire       o_interface_8_3;
    wire       o_centroid_lock;

    integer failures;

    eal_octahedral_face_router dut (
        .clk(clk),
        .rst_n(rst_n),
        .i_cons_address(i_cons_address),
        .o_active_face(o_active_face),
        .o_interface_6_4(o_interface_6_4),
        .o_interface_8_3(o_interface_8_3),
        .o_centroid_lock(o_centroid_lock)
    );

    initial begin
        clk = 1'b0;
        forever #5 clk = ~clk;
    end

    task apply_vector;
        input [15:0] address;
        input [2:0] expected_face;
        input expected_local;
        input expected_remote;
        input expected_centroid;
        begin
            i_cons_address = address;
            @(posedge clk);
            #1;
            if (o_active_face !== expected_face ||
                o_interface_6_4 !== expected_local ||
                o_interface_8_3 !== expected_remote ||
                o_centroid_lock !== expected_centroid) begin
                $display("FAIL addr=%h face=%0d/%0d local=%b/%b remote=%b/%b centroid=%b/%b",
                    address,
                    o_active_face, expected_face,
                    o_interface_6_4, expected_local,
                    o_interface_8_3, expected_remote,
                    o_centroid_lock, expected_centroid);
                failures = failures + 1;
            end
        end
    endtask

    initial begin
        failures = 0;
        i_cons_address = 16'h0000;

        rst_n = 1'b0;
        repeat (2) @(posedge clk);
        rst_n = 1'b1;

        apply_vector(16'h0000, 3'd0, 1'b1, 1'b0, 1'b1);
        apply_vector(16'h0070, 3'd0, 1'b1, 1'b0, 1'b0);
        apply_vector(16'h0080, 3'd1, 1'b1, 1'b0, 1'b0);
        apply_vector(16'h4070, 3'd2, 1'b1, 1'b0, 1'b0);
        apply_vector(16'h4080, 3'd3, 1'b1, 1'b0, 1'b0);
        apply_vector(16'h8070, 3'd4, 1'b0, 1'b1, 1'b0);
        apply_vector(16'h8080, 3'd5, 1'b0, 1'b1, 1'b0);
        apply_vector(16'hC070, 3'd6, 1'b0, 1'b1, 1'b0);
        apply_vector(16'hC080, 3'd7, 1'b0, 1'b1, 1'b0);
        apply_vector(16'hA28B, 3'd5, 1'b0, 1'b1, 1'b0);

        if (failures == 0) begin
            $display("PASS eal_octahedral_face_router vectors");
            $finish;
        end

        $fatal(1, "FAIL eal_octahedral_face_router failures=%0d", failures);
    end
endmodule
