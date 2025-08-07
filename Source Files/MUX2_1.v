module MUX2_1(A1,A2,S,B
    );
	 input [127:0] A1,A2;
	 input S;
	 output reg [127:0]B;
	 
	 always @(*)
	 begin
			if(S==0)
				B=A1;
			else
				B=A2;
	 end
endmodule
