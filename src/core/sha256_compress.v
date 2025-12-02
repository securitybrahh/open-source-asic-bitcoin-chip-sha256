module sha256_compress(
    input  wire         clk,
    input  wire         rst,
    input  wire         start,
    input  wire [511:0] block,
    output reg  [255:0] hash,
    output reg          done
);

    // SHA256 constants
    reg [31:0] K [0:63];
    initial $readmemh("sha256_k.hex", K);

    reg [31:0] W [0:63];
    integer i;

    // Working variables
    reg [31:0] a,b,c,d,e,f,g,h;
    reg [6:0]  round;

    // State machine
    reg busy;

    always @(posedge clk) begin
        if (rst) begin
            round <= 0;
            busy  <= 0;
            done  <= 0;
        end
        else if (start && !busy) begin

            // Message schedule W[0..15]
            for (i = 0; i < 16; i = i+1)
                W[i] <= block[511 - 32*i -: 32];

            round <= 0;
            busy  <= 1;
            done  <= 0;

            // Initial SHA256 state
            a <= 32'h6a09e667;
            b <= 32'hbb67ae85;
            c <= 32'h3c6ef372;
            d <= 32'ha54ff53a;
            e <= 32'h510e527f;
            f <= 32'h9b05688c;
            g <= 32'h1f83d9ab;
            h <= 32'h5be0cd19;

        end
        else if (busy) begin

            // Expand message schedule
            if (round >= 16)
                W[round] <= sigma1(W[round-2]) + W[round-7] +
                            sigma0(W[round-15]) + W[round-16];

            // Perform round
            {a,b,c,d,e,f,g,h} <= sha256_step(
                a,b,c,d,e,f,g,h,
                W[round], K[round]
            );

            round <= round + 1;

            if (round == 63) begin
                busy <= 0;
                done <= 1;

                hash <= {
                    32'h6a09e667 + a,
                    32'hbb67ae85 + b,
                    32'h3c6ef372 + c,
                    32'ha54ff53a + d,
                    32'h510e527f + e,
                    32'h9b05688c + f,
                    32'h1f83d9ab + g,
                    32'h5be0cd19 + h
                };
            end
        end
    end

endmodule
