module brentkung ( a,b,cin,sum ,c_out);

input [15:0] a,b;
input cin;
output c_out;

output [15:0] sum;
	
wire [16:0] c;
assign c[0]=cin;

wire [15:0] fst_ord_pp,fst_ord_gg ;
wire [7:0] scnd_ord_pp,scnd_ord_gg;
wire [3:0] thd_ord_pp,thd_ord_gg;
wire [1:0] frth_ord_pp,frth_ord_gg;
wire  [0:0] fift_ord_pp,fift_ord_gg;
genvar i;

//first order
generate
for (i=0;i<=15;i=i+1)
begin :venkatesh
xor_module x1(fst_ord_pp[i],a[i],b[i]);
and_module a1( fst_ord_gg[i],a[i],b[i]);
end
endgenerate

////second order

generate 
for (i=0;i<=7;i=i+1)
begin :venkatesh1
aplusbc_module ap2(scnd_ord_gg[i],fst_ord_gg[2*i+1],fst_ord_pp[2*i+1],fst_ord_gg[2*i]);
and_module a2 (scnd_ord_pp[i],fst_ord_pp[2*i+1],fst_ord_pp[2*i]);
end
endgenerate

//third order

generate 
for (i=0;i<=3;i=i+1)
begin :venkatesh2
 assign thd_ord_gg[i] = scnd_ord_gg[2*i+1] | (scnd_ord_pp[2*i+1]&scnd_ord_gg[2*i]);
//aplusbc_module q11(thd_ord_gg[i],scnd_ord_gg[2*i+1],scnd_ord_pp[2*i+1],scnd_ord_gg[2*i]);
and_module a3(thd_ord_pp[i],scnd_ord_pp[2*i+1],scnd_ord_pp[2*i]);
end
endgenerate

//forth order

generate 
for (i=0;i<=1;i=i+1)
begin :venkatesh3
aplusbc_module ap4(frth_ord_gg[i],thd_ord_gg[2*i+1],thd_ord_pp[2*i+1],thd_ord_gg[2*i]);
and_module a4(frth_ord_pp[i],thd_ord_pp[2*i+1],thd_ord_pp[2*i]);
end
endgenerate


//fifth order

generate 
for (i=0;i<=0;i=i+1)
begin :venkatesh4
aplusbc_module ap5(fift_ord_gg[i],frth_ord_gg[2*i+1],frth_ord_pp[2*i+1],frth_ord_gg[2*i]);
and_module a5(fift_ord_pp[i],frth_ord_pp[2*i+1],frth_ord_pp[2*i]);
end
endgenerate


//first_order_ c calculations

assign c[1]=fst_ord_gg[0] | ( fst_ord_pp[0] & c[0] );
assign c[2]=scnd_ord_gg[0] | ( scnd_ord_pp[0] & c[0] );
assign c[4]=thd_ord_gg[0] | ( thd_ord_pp[0] & c[0] );
assign c[8]=frth_ord_gg[0] | ( frth_ord_pp[0] & c[0] );
assign c[16]=fift_ord_gg[0] | ( fift_ord_pp[0] & c[0] );

//second order c calculations

assign c[3]=fst_ord_gg[2] | ( fst_ord_pp[2] & c[2] );
assign c[5]=fst_ord_gg[4] | ( fst_ord_pp[4] & c[4] );
assign c[9]=fst_ord_gg[8] | ( fst_ord_pp[8] & c[8] );
assign c[6]=scnd_ord_gg[2] | ( scnd_ord_pp[2] & c[4] );
assign c[10]=scnd_ord_gg[4] | ( scnd_ord_pp[4] & c[8] );
assign c[12]=thd_ord_gg[2] | ( thd_ord_pp[2] & c[8] );

//third order c calculations

assign c[7]=fst_ord_gg[6] | ( fst_ord_pp[6] & c[6] );
assign c[11]=fst_ord_gg[10] | ( fst_ord_pp[10] & c[10] );
assign c[13]=fst_ord_gg[12] | ( fst_ord_pp[12] & c[12] );
assign c[14]=scnd_ord_gg[6] | ( scnd_ord_pp[6] & c[12] );

// final order c calculations

assign c[15]=fst_ord_gg[14] | ( fst_ord_pp[14] & c[14] );


generate
for (i=0;i<=15;i=i+1)
begin :venkatesh5
xor_module x2(sum[i],fst_ord_pp[i],c[i]);
end
endgenerate



assign c_out = c[16];





























endmodule
