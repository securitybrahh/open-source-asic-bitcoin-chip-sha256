module bitcoin_double_sha256 (
    input clk,
    input rst,
    input start,
    input [639:0] block_header,  // Bitcoin Block Header (80 bytes header + nonce)
    output reg [255:0] final_hash,
    output reg done
);

    wire [255:0] first_hash;
    wire first_done;

    wire [255:0] second_hash;
    wire second_done;

    // First SHA-256 pass on the block header
    sha256_pipeline first_sha256 (
        .clk(clk),
        .rst(rst),
        .start(start),
        .block_data(block_header),
        .hash_out(first_hash),
        .done(first_done)
    );

    // Second SHA-256 pass on the result of the first pass
    sha256_pipeline second_sha256 (
        .clk(clk),
        .rst(rst),
        .start(first_done),
        .block_data(first_hash),
        .hash_out(second_hash),
        .done(second_done)
    );

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            done <= 0;
            final_hash <= 0;
        end
        else if (second_done) begin
            done <= 1;
            final_hash <= second_hash;  // Output the final hash (double-SHA256)
        end
    end

endmodule
