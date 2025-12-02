// Example of the pipeline register logic
module pipeline_register (
    input clk, rst, enable,
    input [31:0] a_in, b_in, c_in, d_in, e_in, f_in, g_in, h_in,
    output reg [31:0] a_out, b_out, c_out, d_out, e_out, f_out, g_out, h_out
);

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            a_out <= 32'h6a09e667; // Initial value
            b_out <= 32'hbb67ae85;
            // Other initializations
        end
        else if (enable) begin
            a_out <= a_in;
            b_out <= b_in;
            c_out <= c_in;
            d_out <= d_in;
            e_out <= e_in;
            f_out <= f_in;
            g_out <= g_in;
            h_out <= h_in;
        end
    end

endmodule
