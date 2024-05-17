parameter DEPTH=16;
parameter WIDTH=4;
parameter ADDR_WIDTH=$clog2(DEPTH);
class fifo_tx;
	rand bit wr_en_i;
	rand bit rd_en_i;
	rand bit [WIDTH-1:0]wdata_i;
	bit [WIDTH-1:0]rdata_o;
	bit [ADDR_WIDTH-1:0]wr_ptr;
	bit empty_o,full_o,error_o;
	function void print(string name="fifo_tx");
		$display("printing from %s",name);
		$display("wr_en_i=%b",wr_en_i);
		$display("rd_en_i=%b",rd_en_i);
		$display("wdata_i=%b",wdata_i);
		$display("rdata_o=%b",rdata_o);
		$display("empty_o=%b",empty_o);
		$display("full_o=%b",full_o);
		$display("error_o=%b",error_o);
		$display("wr_ptr=%h",wr_ptr);
	endfunction
endclass
