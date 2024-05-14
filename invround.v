module invround(datain,dataout,key);
input [127:0] datain;
output [127:0] dataout;
input [127:0] key;

wire [127:0] sa;
wire [127:0] ss;
wire [127:0] ma;

invShiftBytes ishb(datain,sa);
invsubBytes is(sa,ss);
Addroundkey ark(ss,key,ma);
invMixColumns imc(ma,dataout);
endmodule