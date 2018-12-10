module fulladd(sum,c_out,a,b,c_in);
output sum,c_out;
input a,b,c_in;

xor x1(o1,a,b);
xor x2(sum,o1,c_in);
and A1(o2,a,b);
and A2(o3,c_in,o1);

or O1(c_out,o2,o3);

endmodule

module fulladd4(sum,c_out,a,b,c_in);
output[3:0] sum;
output c_out;
input[3:0] a,b;
input c_in;

fulladd A0(sum[0],co0,a[0],b[0],c_in);
fulladd A1(sum[1],co1,a[1],b[1],co0);
fulladd A2(sum[2],co2,a[2],b[2],co1);
fulladd A3(sum[3],c_out,a[3],b[3],co2);

endmodule



module compliment(numin,numout);
output[3:0] numout;
input[3:0] numin;
wire[3:0] n;
not inverter[3:0](n,numin);
fulladd4 fd4(numout,c_out,n,4'b0001,0);

endmodule


module subtractor4(out,a,b);
output[3:0] out;
wire c_out;
input[3:0] a,b;
wire[3:0] bc,sum,csum,o1,o2;
input c_in;
not invert[3:0](bc,b);

fulladd4 fd4(sum,c_out,a,bc,1'b1);
compliment cm1(sum,csum);

not(ic_out,c_out);
and(o1[0],ic_out,csum[0]);
and(o2[0],c_out,sum[0]);

and(o1[1],ic_out,csum[1]);
and(o2[1],c_out,sum[1]);

and(o1[2],ic_out,csum[2]);
and(o2[2],c_out,sum[2]);

and(o1[3],ic_out,csum[3]);
and(o2[3],c_out,sum[3]);

or orgate[3:0](out,o1,o2);


endmodule

module btand(out,a,b);
input[3:0] a,b;
output[3:0] out;

and agate[3:0](out,a,b);

endmodule

module btor(out,a,b);
input[3:0] a,b;
output[3:0] out;

or ogate[3:0](out,a,b);

endmodule


module multiplier(out,a,b);
input[3:0] a,b;
output[7:0] out;
wire[3:0] wa0,wa1,wa2,wa3,wa4,wa5,sum1,sum2,sum3;

and(out[0],a[0],b[0]);
and(wa0[0],a[0],b[1]);
and(wa0[1],a[0],b[2]);
and(wa0[2],a[0],b[3]);
not(wa0[3],1'b1);

and(wa1[0],a[1],b[0]);
and(wa1[1],a[1],b[1]);
and(wa1[2],a[1],b[2]);
and(wa1[3],a[1],b[3]);

fulladd4 adder1(sum1,c_out1,wa1,wa0,1'b0);
and(out[1],sum1[0],1'b1);

and(wa2[0],a[2],b[0]);
and(wa2[1],a[2],b[1]);
and(wa2[2],a[2],b[2]);
and(wa2[3],a[2],b[3]);

and(wa3[0],sum1[1],1'b1);
and(wa3[1],sum1[2],1'b1);
and(wa3[2],sum1[3],1'b1);
and(wa3[3],c_out1,1'b1);

fulladd4 adder2(sum2,c_out2,wa2,wa3,1'b0);
and(out[2],sum2[0],1'b1);

and(wa4[0],a[3],b[0]);
and(wa4[1],a[3],b[1]);
and(wa4[2],a[3],b[2]);
and(wa4[3],a[3],b[3]);

and(wa5[0],sum2[1],1'b1);
and(wa5[1],sum2[2],1'b1);
and(wa5[2],sum2[3],1'b1);
and(wa5[3],c_out2,1'b1);

fulladd4 adder3(sum3,c_out3,wa4,wa5,1'b0);

and(out[3],sum3[0],1'b1);
and(out[4],sum3[1],1'b1);
and(out[5],sum3[2],1'b1);
and(out[6],sum3[3],1'b1);
and(out[7],c_out3,1'b1);

endmodule


// Module 8-to-1 multiplexer. This is a synthesizable module
module mux8_to_1 (out, i,s);
	
	// Port declarations
	output out; // Output of the MUX
	input[7:0] i; // Inputs to the MUX
	input[2:0] s; // Select signals
	
	// Internal wire declarations
	wire[2:0] sn;
	wire[7:0] y;
	
	// Gate instantiations
	// Create s1n and s0n signals.
	not invert[2:0] (sn, s);
	
	
	// 3-input and gates instantiated
	and (y[0], i[0], sn[0], sn[1],sn[2]);
	and (y[1], i[1], s[0], sn[1],sn[2]);
	and (y[2], i[2], sn[0], s[1],sn[2]);
	and (y[3], i[3], s[0], s[1],sn[2]);
    and (y[4], i[4], sn[0], sn[1],s[2]);
	and (y[5], i[5], s[0], sn[1],s[2]);
	and (y[6], i[6], sn[0], s[1],s[2]);
	and (y[7], i[7], s[0], s[1],s[2]);
	
	// 4-input or gate instantiated
	or (out, y[0], y[1], y[2], y[3],y[4],y[5],y[6],y[7]);
	
endmodule

module alu(out,a,b,s);
input[3:0] a,b;
input[2:0] s;
output[3:0] out;

wire[3:0] oca,ocb,oad,osb,oand,oor;
wire[7:0] omp;
wire[7:0] i0,i1,i2,i3;

compliment ca(a,oca);

compliment cb(b,ocb);

fulladd4   add(oad,c_out,a,b,1'b0);

subtractor4 sb(osb,a,b);

btand   bta(oand,a,b);

btor    bto(oor,a,b);

multiplier mp(omp,a,b);

and(i0[0],oca[0],1'b1);
and(i0[1],ocb[0],1'b1);
and(i0[2],oad[0],1'b1);
and(i0[3],osb[0],1'b1);
and(i0[4],oand[0],1'b1);
and(i0[5],oor[0],1'b1);
and(i0[6],omp[0],1'b1);
and(i0[7],omp[4],1'b1);

and(i1[0],oca[1],1'b1);
and(i1[1],ocb[1],1'b1);
and(i1[2],oad[1],1'b1);
and(i1[3],osb[1],1'b1);
and(i1[4],oand[1],1'b1);
and(i1[5],oor[1],1'b1);
and(i1[6],omp[1],1'b1);
and(i1[7],omp[5],1'b1);

and(i2[0],oca[2],1'b1);
and(i2[1],ocb[2],1'b1);
and(i2[2],oad[2],1'b1);
and(i2[3],osb[2],1'b1);
and(i2[4],oand[2],1'b1);
and(i2[5],oor[2],1'b1);
and(i2[6],omp[2],1'b1);
and(i2[7],omp[6],1'b1);

and(i3[0],oca[3],1'b1);
and(i3[1],ocb[3],1'b1);
and(i3[2],oad[3],1'b1);
and(i3[3],osb[3],1'b1);
and(i3[4],oand[3],1'b1);
and(i3[5],oor[3],1'b1);
and(i3[6],omp[3],1'b1);
and(i3[7],omp[7],1'b1);

mux8_to_1 mux0(out[0],i0,s);
mux8_to_1 mux1(out[1],i1,s);
mux8_to_1 mux2(out[2],i2,s);
mux8_to_1 mux3(out[3],i3,s);

endmodule

module test;


        reg[3:0] A,B;
        reg [2:0] S;
        wire[3:0] OUT;
        

        alu sb(OUT,A,B,S);


        initial 
        
        begin



        

        $monitor($time," a=%b b=%b s=%b out=%b",A,B,S,OUT);
        A=4'b0000;B=4'b0000;S=3'b000;
        #5 A=4'b0001;B=4'b0000;S=3'b001;
        #5 A=4'b0000;B=4'b0001;S=3'b110;
        #5 A=4'b0001;B=4'b0000;S=3'b000;
        #5 A=4'b0001;B=4'b0001;S=3'b000;
        #5 A=4'b0010;B=4'b0001;S=3'b000;
        #5 A=4'b0001;B=4'b0000;S=3'b000;
        #5 A=4'b0001;B=4'b0000;S=3'b000;
        #5 A=4'b0000;B=4'b0001;S=3'b000;
        #5 A=4'b0001;B=4'b0000;S=3'b000;
        #5 A=4'b0001;B=4'b0001;S=3'b000;
        #5 A=4'b1010;B=4'b0101;S=3'b000;
        #5 A=4'b0101;B=4'b0100;S=3'b000;
        #5 A=4'b1010;B=4'b0101;S=3'b110;
        #5 A=4'b0000;B=4'b1111;S=3'b000;

        end

endmodule
