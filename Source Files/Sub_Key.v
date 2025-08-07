module Sub_Key(key_in,mc_sr_out,data_out
    );
	 input [127:0]key_in;
	 input [127:0]mc_sr_out;
	 output [127:0]data_out;

	assign data_out=key_in^mc_sr_out;

endmodule
