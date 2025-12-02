module sha256_pipeline (
    input clk,
    input rst,
    input start,
    input [511:0] block_data,  // Block header
    output reg [255:0] hash_out,  // Final hash output
    output reg done
);

    // Internal state variables (initial state of SHA-256)
    reg [31:0] a, b, c, d, e, f, g, h;
    reg [31:0] W [0:63];  // Message schedule array

    integer round;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            round <= 0;
            done <= 0;
            a <= 32'h6a09e667;
            b <= 32'hbb67ae85;
            c <= 32'h3c6ef372;
            d <= 32'ha54ff53a;
            e <= 32'h510e527f;
            f <= 32'h9b05688c;
            g <= 32'h1f83d9ab;
            h <= 32'h5be0cd19;
        end
        else if (start && round < 64) begin
            // Process each round, apply SHA-256 round function
            sha256_round_stage round_stage (
                .a(a), .b(b), .c(c), .d(d), .e(e), .f(f), .g(g), .h(h),
                .w(W[round]), .k(K[round]),
                .a_out(a_next), .b_out(b_next), .c_out(c_next), .d_out(d_next),
                .e_out(e_next), .f_out(f_next), .g_out(g_next), .h_out(h_next)
            );

            // Update state variables for the next round
            a <= a_next;
            b <= b_next;
            c <= c_next;
            d <= d_next;
            e <= e_next;
            f <= f_next;
            g <= g_next;
            h <= h_next;

            round <= round + 1;
        end
        else if (round == 64) begin
            done <= 1;
            // Final hash output after all rounds (add to initial values)
            hash_out <= { a + 32'h6a09e667, b + 32'hbb67ae85, c + 32'h3c6ef372, d + 32'ha54ff53a,
                          e + 32'h510e527f, f + 32'h9b05688c, g + 32'h1f83d9ab, h + 32'h5be0cd19 };
        end
    end

endmodule
