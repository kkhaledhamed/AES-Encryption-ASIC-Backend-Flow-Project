module mux(a1,a2,s,b
    );
	 input [127:0] a1,a2;
	 input s;
	 output reg [127:0]b;
	 
	 always @(*)
	 begin
		if(s==0)
			b =a1;
		else
			b=a2;
	 end
endmodule
