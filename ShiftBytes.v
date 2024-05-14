module ShiftBytes (in,shifted);
input [127:0] in;
output [127:0] shifted;
  
assign shifted  [127:120]= in[127:120];
assign shifted  [95:88]= in[95:88];
assign shifted  [63:56]= in[63:56];
assign shifted  [31:24]= in[31:24];
     
assign shifted  [119:112]= in[87:80];
assign shifted  [87:80]= in[55:48];
assign shifted  [55:48]= in[23:16];
assign shifted  [23:16]= in[119:112];
      
assign shifted  [111:104]= in[47:40];
assign shifted  [79:72]= in[15:8];
assign shifted  [47:40]= in[111:104];
assign shifted  [15:8]= in[79:72];
      
assign shifted  [103:96]= in[7:0];
assign shifted  [71:64]= in[103:96];
assign shifted  [39:32]= in[71:64];
assign shifted  [7:0]= in[39:32];
endmodule