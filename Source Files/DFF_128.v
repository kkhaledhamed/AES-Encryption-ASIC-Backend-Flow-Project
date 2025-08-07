module DFF_128(
    input clk,
    input [127:0] D,
    output reg [127:0] Q
);
always @(posedge clk) begin
    Q <= D;
end
endmodule