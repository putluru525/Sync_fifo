class fifo_mon;
	fifo_tx tx;
	virtual fifo_intf vif;
	function new();
		tx=new();
		vif=top.pif;
	endfunction
	task run();
		$display("fifo_mon RUN TASK called");
		forever begin
			//convert interface lvel to tx level
			//@(posedge vif.clk_i)
			@(vif.mon_cb)
			tx.wr_en_i = vif.mon_cb.wr_en_i;
			tx.rd_en_i = vif.mon_cb.rd_en_i;
			if(tx.wr_en_i==1 && tx.rd_en_i==0)//write operation
				tx.wdata_i = vif.mon_cb.wdata_i;
			if(tx.rd_en_i==1 && tx.wr_en_i==0)//read operation
				tx.rdata_o = vif.mon_cb.rdata_o;
			tx.empty_o = vif.mon_cb.empty_o;
			tx.full_o = vif.mon_cb.full_o;
			tx.error_o = vif.mon_cb.error_o;
			tx.print("fifo_mon");
			fifo_common::mon2cov.put(tx);
			fifo_common::mon2sbd.put(tx);
		end
	endtask
endclass
