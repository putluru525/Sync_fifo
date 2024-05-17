interface fifo_intf(input logic clk_i,rst_i);
	logic [WIDTH-1:0]wdata_i;
	logic [WIDTH-1:0]rdata_o;
	logic [ADDR_WIDTH-1:0]wr_ptr;
	logic wr_en_i;
	logic rd_en_i;
	logic empty_o;
	logic full_o;
	logic error_o; 
clocking bfm_cb@(posedge clk_i);
	default input #0 output #1;
	input rdata_o;
	input empty_o;
	input full_o;
	input error_o;
	output wdata_i;
	output wr_en_i;
	output rd_en_i;
endclocking
clocking mon_cb@(posedge clk_i);
	default input #0 output #1;
	input wdata_i;
	input rdata_o;
	input wr_en_i;
	input rd_en_i;
	input empty_o;
	input full_o;
	input error_o;
endclocking
endinterface
