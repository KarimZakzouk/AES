module round(datain,dataout,key);
input [127:0] datain;
output [127:0] dataout;
input [127:0] key;

wire [127:0] ma;
wire [127:0] sa;
wire [127:0] ss;

subBytes sb(datain,ss);
ShiftBytes shb(ss,sa);
mixColumns mc(sa,ma);
Addroundkey ark(ma,key,dataout);

endmodule