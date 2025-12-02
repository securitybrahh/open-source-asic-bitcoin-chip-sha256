// SHA256 basic functions
module sha256_functions;

    // Rotate right
    function [31:0] ROTR;
        input [31:0] x;
        input [4:0] n;
        begin
            ROTR = (x >> n) | (x << (32 - n));
        end
    endfunction

    // Sigma0
    function [31:0] Sigma0;
        input [31:0] x;
        begin
            Sigma0 = ROTR(x, 2) ^ ROTR(x, 13) ^ ROTR(x, 22);
        end
    endfunction

    // Sigma1
    function [31:0] Sigma1;
        input [31:0] x;
        begin
            Sigma1 = ROTR(x, 6) ^ ROTR(x, 11) ^ ROTR(x, 25);
        end
    endfunction

    // sigma0
    function [31:0] sigma0;
        input [31:0] x;
        begin
            sigma0 = ROTR(x, 7) ^ ROTR(x, 18) ^ (x >> 3);
        end
    endfunction

    // sigma1
    function [31:0] sigma1;
        input [31:0] x;
        begin
            sigma1 = ROTR(x, 17) ^ ROTR(x, 19) ^ (x >> 10);
        end
    endfunction

    // Choice function
    function [31:0] Ch;
        input [31:0] x, y, z;
        begin
            Ch = (x & y) ^ (~x & z);
        end
    endfunction

    // Majority function
    function [31:0] Maj;
        input [31:0] x, y, z;
        begin
            Maj = (x & y) ^ (x & z) ^ (y & z);
        end
    endfunction

endmodule
