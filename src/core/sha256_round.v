module sha256_round(
    input  wire [31:0] a, b, c, d, e, f, g, h,
    input  wire [31:0] w,
    input  wire [31:0] k,
    output wire [31:0] a_out, b_out, c_out, d_out,
    output wire [31:0] e_out, f_out, g_out, h_out
);

    // Include functions
    `include "sha256_functions.vh"

    wire [31:0] T1 = h + Sigma1(e) + Ch(e,f,g) + k + w;
    wire [31:0] T2 = Sigma0(a) + Maj(a,b,c);

    assign a_out = T1 + T2;
    assign b_out = a;
    assign c_out = b;
    assign d_out = c;
    assign e_out = d + T1;
    assign f_out = e;
    assign g_out = f;
    assign h_out = g;

endmodule
