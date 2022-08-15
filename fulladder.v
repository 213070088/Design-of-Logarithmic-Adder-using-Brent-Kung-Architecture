module fulladder(sum,c_out,a,b,c);

input a,b,c;
output sum,c_out;

assign sum=a ^ b ^ c ;
assign c_out = ( a & b ) | ( b & c ) | ( c & a );
































endmodule 