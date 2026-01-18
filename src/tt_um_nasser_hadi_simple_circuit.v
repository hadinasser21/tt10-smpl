/*
 * Copyright (c) 2024 Your Name
 * SPDX-License-Identifier: Apache-2.0
 */

`default_nettype none

module tt_um_nasser_hadi_simple_circuit (
    input wire clk,	//add clk for synchronous piplining
    input wire A, B, C,
    output reg x, y
);

    // Stage 1: Combinational logic
    wire e_temp;
    wire y_temp;

    assign e_temp = A & B;
    assign y_temp = ~C;

    // Registers for pipelining (Stage 1 -> Stage 2)
    reg reg_e, reg_y; //use reg_e and reg_y to store results of first stage

    always @(posedge clk) begin
        // Stage 1: latch intermediate values
        reg_e <= e_temp;
        reg_y <= y_temp;

        // Stage 2: compute final outputs
        x <= reg_e | reg_y; //Output x is computed in the second stage
        y <= reg_y;  // y = ~C, passed through 1-cycle delay //Output y is also registered to maintain timing consistency
    end

endmodule
