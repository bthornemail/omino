`timescale 1ns / 1ps

module tb_eal_meta_assembler;
    reg         clk;
    reg         rst_n;
    reg  [3:0]  i_core_opcode;
    reg  [12:0] i_slot5040;
    reg  [7:0]  i_character_token;

    wire [15:0] o_machine_instruction;
    wire        o_is_centroid_core;
    wire        o_assembler_ready;

    integer failures;

    eal_meta_assembler dut (
        .clk(clk),
        .rst_n(rst_n),
        .i_core_opcode(i_core_opcode),
        .i_slot5040(i_slot5040),
        .i_character_token(i_character_token),
        .o_machine_instruction(o_machine_instruction),
        .o_is_centroid_core(o_is_centroid_core),
        .o_assembler_ready(o_assembler_ready)
    );

    initial begin
        clk = 1'b0;
        forever #5 clk = ~clk;
    end

    task apply_vector;
        input [3:0] opcode;
        input [12:0] slot5040;
        input [7:0] token;
        input [15:0] expected_word;
        input expected_centroid;
        input expected_ready;
        begin
            i_core_opcode = opcode;
            i_slot5040 = slot5040;
            i_character_token = token;
            @(posedge clk);
            #1;
            if (o_machine_instruction !== expected_word ||
                o_is_centroid_core !== expected_centroid ||
                o_assembler_ready !== expected_ready) begin
                $display("FAIL opcode=%h slot=%h token=%h word=%h/%h centroid=%b/%b ready=%b/%b",
                    opcode, slot5040, token,
                    o_machine_instruction, expected_word,
                    o_is_centroid_core, expected_centroid,
                    o_assembler_ready, expected_ready);
                failures = failures + 1;
            end
        end
    endtask

    initial begin
        failures = 0;
        i_core_opcode = 4'h0;
        i_slot5040 = 13'd0;
        i_character_token = 8'h00;

        rst_n = 1'b0;
        repeat (2) @(posedge clk);
        rst_n = 1'b1;

        apply_vector(4'h0, 13'd0, 8'h00, 16'h0000, 1'b1, 1'b1);
        apply_vector(4'h2, 13'd1780, 8'h3F, 16'h26F4, 1'b0, 1'b1);
        apply_vector(4'h9, 13'd5039, 8'h7F, 16'h93AF, 1'b0, 1'b1);
        apply_vector(4'h2, 13'd5040, 8'h3F, 16'h0000, 1'b1, 1'b0);
        apply_vector(4'h2, 13'd1, 8'h80, 16'h0000, 1'b1, 1'b0);

        if (failures == 0) begin
            $display("PASS eal_meta_assembler vectors");
            $finish;
        end

        $fatal(1, "FAIL eal_meta_assembler failures=%0d", failures);
    end
endmodule
