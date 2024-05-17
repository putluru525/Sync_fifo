class fifo_env;
	fifo_agent agent;
	fifo_cov cov;
	fifo_sbd sbd;
	function new();
		agent=new();
		cov=new();
		sbd=new();
	endfunction
	task run();
		fork
			agent.run();
			cov.run();
			sbd.run();
		join
	endtask
endclass
