//assign 2 smithrm3
//q3
module ALU(input[7:0]a, input[7:0]b, input add_sub, input set_low, input set_high, output reg[7:0]result);
always @(*)
begin
	if (set_low==1)
	begin
		result[7:4]=a[7:4];
		result[3:0]=b[3:0];
	end
	else if (set_high==1)
	begin
		result[7:4]=b[7:4];
		result[3:0]=a[3:0];
	end
	else
	begin
	if (add_sub==1)
		result=a-b;
	else
		result=a+b;
	end
end
endmodule

//q4
module PC (input clock, input parameter reset_n, input branch, 
	input newpc, input increment, output[7:0] pc);

reg[7:0] pc;

always@(posedge clock)
begin
	if(reset_n==0)
	begin
		pc<=0;
	end
	else if (branch==1)
	begin
		pc<=newpc;
	end
	else if (increment==1)
	begin
		pc<=pc+1;
	end
end
endmodule

//q5
module register (input clock, input reset_n, input write, 
	input[1:0]wr_select, input[7:0]data, input[1:0]select0, output[7:0] selected0);

reg[7:0] selected0, reg0, reg1, reg2;

always@(posedge clock)
begin
	if (reset_n==0)
	begin
		reg0<=0;
		reg1<=0;
		reg2<=0;
	end
	else if (write==1)
	begin
		if (wr_select==2'b00) reg0<=data;
		else if (wr_select==2'b01) reg1<=data;
		else if (wr_select==2'b10) reg2<=data;
	end
	if (select0==2'b00) selected0<=reg0;
	else if (select0==2'b01) selected0<=reg1;
	else if (select0==2'b10) selected0<=reg2;
end
endmodule

//q6
module delay_counter (input clock, input reset_n, input start, input enable
	input[7:0] delay, output reg done);

reg[7:0] up, down;

always@(posedge clock)
begin
	if (reset_n==0)
	begin
		up<=0;
		down<=0;
	end
	else if (start==1)
	begin
		down<=delay*10;//convert from 1/100s to ms
		up<=0;
	end
	else if (enable==1)
	begin
		up<=up+1; //increment upcounter
		//1 MHz clock want to decrement downcounter once per ms, therefore 1000 clock cycles
		if (up>=1000)
		begin
			up=0; //want to block here to reset upcounter
			down<=down-1;
		end
		if (down==0) 
		begin
			done <=1;
			enable=0; //block to end loop
		end
		else done<=0;
	end
end
endmodule

