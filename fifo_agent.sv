class fifo_agent;
	fifo_gen gen;
	fifo_bfm bfm;
	fifo_mon mon;
	function new();
		gen = new();
		bfm = new();
		mon = new();
	endfunction
	task run();
		fork
			gen.run();
			bfm.run();
			mon.run();
		join
	endtask
endclass
