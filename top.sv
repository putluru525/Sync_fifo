typedef class fifo_tx;
typedef class fifo_common;
typedef class fifo_sbd;
typedef class fifo_mon;
typedef class fifo_cov;
typedef class fifo_bfm;
typedef class fifo_gen;
typedef class fifo_agent;
typedef class fifo_env;

`include "fifo_tx.sv";
`include "fifo_common.sv";
`include "fifo_intf.sv";
`include "fifo_sbd.sv";
`include "fifo_mon.sv";
`include "fifo_cov.sv";
`include "fifo_bfm.sv";
`include "fifo_gen.sv";
`include "fifo_agent.sv";
`include "fifo_env.sv";
`include "sync_fifo.v";
module top;
//steps to write the top module
//1.Declare clk,rst
//2.Generate the clk,rst
//3.instantiate the interface
//4.instantiate the dut
//5.logic to end the simulation
//6.logic to run the tb of env
bit clk,rst;
event e;
always #5 clk=~clk;
initial begin
	rst=1;
	repeat(2) @(posedge clk)
		rst=0;
	->e;
end
fifo_intf pif(clk,rst);
sync_fifo dut(.clk_i(pif.clk_i),
	      .rst_i(pif.rst_i),
	      .wdata_i(pif.wdata_i),
	      .rdata_o(pif.rdata_o),
	      .wr_en_i(pif.wr_en_i),
	      .rd_en_i(pif.rd_en_i),
	      .empty_o(pif.empty_o),
	      .full_o(pif.full_o),
	      .error_o(pif.error_o));
fifo_env env;
initial begin
	env=new();
	wait(e.triggered);
	$value$plusargs("testcase=%s",fifo_common::testcase);
	env.run();
end
initial begin
	//#345;
	fork
		wait((fifo_common::count*2)==(fifo_common::total_driven_tx));
		#10000;
	join_any
	#20;
	if((fifo_common::count_mismatches!=0) || (fifo_common::count_matches!=fifo_common::count)) begin
		$display("##### TEST FAILED #####");
		$display("count_mismatches=%0d",fifo_common::count_mismatches);
		$display("count_matches=%0d",fifo_common::count_matches);
	end
	else begin
		$display("##### TEST PASSED #####");
		$display("count_mismatches=%0d",fifo_common::count_mismatches);
		$display("count_matches=%0d",fifo_common::count_matches);
	end
	$finish();
      end
endmodule
