`timescale 1ns/1ps
module AES_Encryption_tb;
    reg clk;
    reg [127:0] Data_in;
    reg [127:0] key_in;
    wire [127:0] cipher_out;

    AES_Encryption dut (.clk(clk), .Data_in(Data_in), 
                      .key_in(key_in), .cipher_out(cipher_out));

    // 100MHz clock
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
        // Initialize
        Data_in = 0;
        key_in = 0;
        #100; // Wait for reset
        
        // NIST Test Vector
        Data_in = 128'h3243f6a8885a308d313198a2e0370734;
        key_in = 128'h2b7e151628aed2a6abf7158809cf4f3c;
        
        #220; // Wait for 11 cycles (10 rounds + initial)
        
        $display("Final Ciphertext = %h", cipher_out);
        if (cipher_out === 128'h3925841d02dc09fbdc118597196a0b32)
            $display("=== TEST PASSED ===");
        else
            $display("=== TEST FAILED ===");
        $finish;
    end

    // VCD Dump
    initial begin
        $dumpfile("AES.vcd");
        $dumpvars;
    end
endmodule