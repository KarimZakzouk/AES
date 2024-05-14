module AES_Encrypt#(parameter N,parameter Nr,parameter Nk)(datain,key,state,reset,clk,start);
input [127:0] datain;
input [N-1:0] key;
output reg [127:0] state;
input reset;
input clk;
output reg start;

wire [(128*(Nr+1))-1:0] keys;
reg [127:0] a1;
wire [127:0] a2;
wire [127:0] a3;
reg [127:0] a4;
wire [127:0] b1;
wire [127:0] b2;
wire [127:0] b3;

	  
	 	 integer j = 0;
				always @(posedge clk or posedge reset)begin
				if(reset) begin
						j = 0;
						state<=128'hx;
						a1 <= 128'hx;
						a4 <= 128'hx;
						start <= 0;
				end
				else begin
				if( j == 0)begin
						a1 <= a3;
						state<=a3;
						j = j + 1;
						start <= 1;
				end
				else if(j>0 && j < Nr - 1) begin
						a1 <= a2;
						state<=a2;
						j = j + 1;
						start <= 1;
				end
				else if(j == Nr - 1) begin
						a4<=a2;
						state<=a2;
						j = j + 1;
						start <= 1;
				end
				else if(j >= Nr) begin
						state<=b3;
						start <= 1;
				end
				end
				end
	 
KeyExpansion #(N,Nr,Nk) ke (key, keys);
Addroundkey ark1(datain, keys[128*(Nr)+:128], a3);

   round r(a1, a2, keys[128 * (Nr-j) +: 128]);

subBytes sb(a4,b1);
ShiftBytes shb(b1,b2);
Addroundkey ark2(b2,keys[128 * 0 +: 128],b3);
endmodule