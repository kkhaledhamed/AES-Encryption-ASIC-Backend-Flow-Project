module Round_reg(
    input clk,
    input [127:0] r_in,
    input [127:0] key_in,
    output reg [127:0] r_out,
    output reg [127:0] key_out
);
always @(posedge clk) begin
    r_out <= r_in;       // Register the round output
    key_out <= key_in;   // Register the key
end
endmodule