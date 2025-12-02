`timescale 1ns / 1ps

module tb_sha256;

    // Inputs to the SHA-256 core
    reg clk;
    reg rst;
    reg start;
    reg [511:0] block_data;  // 512-bit block data (Block Header + Nonce)

    // Outputs from the SHA-256 core
    wire [255:0] hash_out;
    wire done;

    // Instantiate the SHA-256 pipeline module
    sha256_pipeline uut (
        .clk(clk),
        .rst(rst),
        .start(start),
        .block_data(block_data),
        .hash_out(hash_out),
        .done(done)
    );

    // Clock generation
    always begin
        #5 clk = ~clk;  // Generate a clock with a period of 10ns
    end

    // Testbench stimulus
    initial begin
        // Initialize signals
        clk = 0;
        rst = 0;
        start = 0;
        block_data = 512'h00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000;  // Example block header

        // Apply reset
        rst = 1;
        #10 rst = 0;

        // Start the hashing process
        start = 1;
        #10 start = 0;

        // Wait until the hashing is done
        wait(done);

        // Check the output hash (this is just an example, you would compare with the expected value)
        $display("SHA-256 Hash Output: %h", hash_out);

        // Finish simulation
        #20 $finish;
    end

endmodule
