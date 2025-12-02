`timescale 1ns / 1ps

module tb_bitcoin;

    // Inputs to the double-SHA256 core
    reg clk;
    reg rst;
    reg start;
    reg [639:0] block_header;  // 640-bit block header + nonce (80 bytes + nonce 4 bytes)

    // Outputs from the double-SHA256 core
    wire [255:0] final_hash;
    wire done;

    // Instantiate the Bitcoin double-SHA256 module
    bitcoin_double_sha256 uut (
        .clk(clk),
        .rst(rst),
        .start(start),
        .block_header(block_header),
        .final_hash(final_hash),
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
        block_header = 640'h00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000;  // Example block header with nonce

        // Apply reset
        rst = 1;
        #10 rst = 0;

        // Start the double-SHA256 process
        start = 1;
        #10 start = 0;

        // Wait until the hashing is done
        wait(done);

        // Check the final hash (this is just an example, you would compare with the expected value)
        $display("Final Bitcoin Double-SHA256 Hash: %h", final_hash);

        // Finish simulation
        #20 $finish;
    end

endmodule
