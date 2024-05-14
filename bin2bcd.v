module bin2bcd(bin,bcd);
input [7:0] bin;
output [11:0] bcd;
    
reg [11 : 0] bcd; 
reg [3:0] i;   

always @* begin
	bcd = 0; 
	for (i = 0; i < 8; i = i+1) begin //run for 8 iterations
		bcd = {bcd[10:0],bin[7-i]}; 
                    
//if a hex digit of 'bcd' is more than 4, add 3 to it.  
		if(i < 7 && bcd[3:0] > 4) 
			bcd[3:0] = bcd[3:0] + 3;
		if(i < 7 && bcd[7:4] > 4)
			bcd[7:4] = bcd[7:4] + 3;
		if(i < 7 && bcd[11:8] > 4)
			bcd[11:8] = bcd[11:8] + 3;  
	end
end     
                
endmodule