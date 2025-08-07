module AES_Encryption(
    input clk,
    input [127:0] Data_in,
    input [127:0] key_in,
    output [127:0] cipher_out
);

    // ===== ALL WIRE DECLARATIONS =====
    wire [127:0] key_out[10:0];
    wire [127:0] key_out_reg[10:0];
    wire [127:0] data_in;
    wire [127:0] mux_out1[10:0];
    wire [127:0] sb[10:0];
    wire [127:0] sr[10:0];
    wire [127:0] df1[10:0];
    wire [127:0] round_out[10:0];
    wire [127:0] round_out1[10:0];  // CRITICAL MISSING DECLARATION
    wire [127:0] mc[9:0];
    wire [127:0] mc_sr[10:0];

    // ===== INITIAL ROUND =====
    assign data_in = key_in ^ Data_in;

    Key k0 (.rc(4'b0000), .k_in(key_in), .k_out(key_out[0]));
    MUX2_1 MUX0 (.A1(data_in), .A2(round_out[0]), .S(1'b0), .B(mux_out1[0]));
    Sub_Bytes sb0 (.A(mux_out1[0]), .B1(sb[0]));
    DFF_128 dff0 (.clk(clk), .D(sb[0]), .Q(df1[0]));
    Shift_Rows sr0 (.b_in(df1[0]), .b_out(sr[0]));
    Mix_Column mc0 (.c_in1(sr[0]), .c_out(mc[0]));
    mux mux0 (.a1(sr[0]), .a2(mc[0]), .s(1'b1), .b(mc_sr[0]));
    Sub_Key sk0 (.key_in(key_out[0]), .mc_sr_out(mc_sr[0]), .data_out(round_out1[0]));
    Round_reg r0 (.clk(clk), .r_in(round_out1[0]), .r_out(round_out[0]), 
               .key_in(key_out[0]), .key_out(key_out_reg[0]));

    // ===== ROUNDS 1-9 =====
    genvar i;
    generate
        for (i=1; i<=9; i=i+1) begin : AES_Rounds
            if (i < 9) begin
                Key k_i (.rc(i[3:0]), .k_in(key_out_reg[i-1]), .k_out(key_out[i]));
                MUX2_1 MUX_i (.A1(128'b0), .A2(round_out[i-1]), .S(1'b1), .B(mux_out1[i]));
                Sub_Bytes sb_i (.A(mux_out1[i]), .B1(sb[i]));
                DFF_128 dff_i (.clk(clk), .D(sb[i]), .Q(df1[i]));
                Shift_Rows sr_i (.b_in(df1[i]), .b_out(sr[i]));
                Mix_Column mc_i (.c_in1(sr[i]), .c_out(mc[i]));
                mux mux_i (.a1(sr[i]), .a2(mc[i]), .s(1'b1), .b(mc_sr[i]));
                Sub_Key sk_i (.key_in(key_out[i]), .mc_sr_out(mc_sr[i]), .data_out(round_out1[i]));
                Round_reg r_i (.clk(clk), .r_in(round_out1[i]), .r_out(round_out[i]), 
                             .key_in(key_out[i]), .key_out(key_out_reg[i]));
            end
            else begin  // Final round
                Key k_f (.rc(i[3:0]), .k_in(key_out_reg[i-1]), .k_out(key_out[i]));
                MUX2_1 MUX_f (.A1(128'b0), .A2(round_out[i-1]), .S(1'b1), .B(mux_out1[i]));
                Sub_Bytes sb_f (.A(mux_out1[i]), .B1(sb[i]));
                DFF_128 dff_f (.clk(clk), .D(sb[i]), .Q(df1[i]));
                Shift_Rows sr_f (.b_in(df1[i]), .b_out(sr[i]));
                mux mux_f (.a1(sr[i]), .a2(128'b0), .s(1'b0), .b(mc_sr[i]));
                Sub_Key sk_f (.key_in(key_out[i]), .mc_sr_out(mc_sr[i]), .data_out(round_out1[i]));
                Round_reg r_f (.clk(clk), .r_in(round_out1[i]), .r_out(cipher_out), 
                         .key_in(key_out[9]), .key_out(key_out_reg[10]));
            end
        end
    endgenerate
endmodule