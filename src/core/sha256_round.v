module sha256_round_stage (
    input [31:0] a, b, c, d, e, f, g, h,  // Current state variables
    input [31:0] w,                       // Current message schedule value
    input [31:0] k,                       // SHA256 constant for this round
    output [31:0] a_out, b_out, c_out, d_out, e_out, f_out, g_out, h_out
);

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
