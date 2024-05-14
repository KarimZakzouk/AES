module AES(A,B,reset,clk,L1,L2,L3,H,T,O);

input A;            		  //Selector 1    S0
input B;            		  //Selector 2    S1
input reset;
input clk;
output reg L1;            //Led 1 idication for 128
output reg L2;            //Led 2 idication for 192
output reg L3;            //Led 3 idication for 256
output [6:0] H;           //Hundredths
output [6:0] T;           //Tenths
output [6:0] O;           //Ones

wire [127:0] indata = 128'h_00112233445566778899aabbccddeeff;											//Input from document

wire [127:0] k1 = 128'h_000102030405060708090a0b0c0d0e0f;												//128 from document
wire [191:0] k2 = 192'h_000102030405060708090a0b0c0d0e0f1011121314151617;							//192 from document
wire [255:0] k3 = 256'h_000102030405060708090a0b0c0d0e0f101112131415161718191a1b1c1d1e1f;		//256 from document

wire [127:0] outfinal11;	//Output of 128 Encryption
wire [127:0] outfinal12;	//Output of 128 Decryption
wire [127:0] outfinal21;	//Output of 192 Encryption
wire [127:0] outfinal22;	//Output of 192 Decryption
wire [127:0] outfinal31;	//Output of 256 Encryption
wire [127:0] outfinal32;	//Output of 256 Decryption

reg [127:0] outfinal1;		//Final Output for AES 128
reg [127:0] outfinal2;		//Final Output for AES 192
reg [127:0] outfinal3;		//Final Output for AES 256

reg [127:0] final;			//Final Output
wire [11:0] bcd;

wire start11, start12, start21, start22, start31, start32;

bin2bcd b2b(final [7:0],bcd);

//[HEX0,HEX1,HEX2,HEX3,HEX4,HEX5,HEX6]
segment7 s1(bcd[11:8],H);
segment7 s2(bcd[7:4],T);
segment7 s3(bcd[3:0],O);

AES_Encrypt #(128,10,4)a1(indata,k1,outfinal11,reset,clk,start11);
AES_Encrypt #(192,12,6)a2(indata,k2,outfinal21,reset,clk,start21);
AES_Encrypt #(256,14,8)a3(indata,k3,outfinal31,reset,clk,start31);


AES_Decrypt #(128,10,4)da1(outfinal11,k1,outfinal12,reset,clk,start12);
AES_Decrypt #(192,12,6)da2(outfinal21,k2,outfinal22,reset,clk,start22);
AES_Decrypt #(256,14,8)da3(outfinal31,k3,outfinal32,reset,clk,start32);



always @* begin

    // Output selection for AES 128
    if(start12) outfinal1 <= outfinal12;
    else if(start11) outfinal1 <= outfinal11;
    else outfinal1 <= indata;
    
    // Output selection for AES 192
    if(start22) outfinal2 <= outfinal22;
    else if(start21) outfinal2 <= outfinal21;
    else outfinal2 <= indata;
    
    // Output selection for AES 256
    if(start32) outfinal3 <= outfinal32;
    else if(start31) outfinal3 <= outfinal31;
    else outfinal3 <= indata;

    // Output selection based on A and B
    if(!A && !B) final <= outfinal1;			//0 0 -> AES 128
    else if(A && !B) final <= outfinal2;		//0 1 -> AES 192
    else if(!A && B) final <= outfinal3;		//1 0 -> AES 256
    else final <= indata;							//1 1 -> Indata  optional 

    // Checks if operation is done
    L1 <= (outfinal1 == indata) ? 1 : 0;
    L2 <= (outfinal2 == indata) ? 1 : 0;
    L3 <= (outfinal3 == indata) ? 1 : 0;

end
endmodule