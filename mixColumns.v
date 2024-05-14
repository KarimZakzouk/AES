module mixColumns(input [127:0] state,output reg  [127:0]out);
integer i;
integer j;
reg [127:0]temp;

always @(*)
begin

for ( i=  0 ; i <=24 ;i=i+8) begin :loop
	for( j = 0 ; j <=24 ;j=j+8)begin :loop
		temp[127-4*i-j-:8]= xtime(state[127-4*i-j-:8]);
	end

out[127-4*i-:8]=temp[127-4*i-:8]^(state[119-4*i-:8]^temp[119-4*i-:8])^state[111-4*i-:8]^state[103-4*i-:8] ;
out[119-4*i-:8]= state[127-4*i-:8]^ temp[119-4*i-:8]^(state[111-4*i-:8]^temp[111-4*i-:8])^state[103-4*i-:8];
out[111-4*i-:8]= state[127-4*i-:8]^state[119-4*i-:8]^ temp[111-4*i-:8]^(state[103-4*i-:8]^temp[103-4*i-:8]);
out[103-4*i-:8]=(state[127-4*i-:8]^temp[127-4*i-:8])^state[119-4*i-:8]^state[111-4*i-:8]^temp[103-4*i-:8];

end
end

function [7:0] xtime(input  [7:0] x );

 xtime=(x[7])?(x<<1)^(8'h1b):x<<1 ;

endfunction
endmodule