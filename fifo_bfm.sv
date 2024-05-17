class fifo_bfm;
	fifo_tx tx;
	virtual fifo_intf vif;
	function new();
		vif=top.pif;
	endfunction
task run();
	$display("fifo_bfm RUN TASK called");
	forever begin
		fifo_common::gen2bfm.get(tx);
		drive_tx(tx);
		fifo_common::total_driven_tx++;
		//tx.print("fifo_bfm");
	end
endtask
task drive_tx(fifo_tx tx);
	//convert tx level to interface level
	//@(posedge vif.clk_i)
	@(vif.bfm_cb)
	vif.bfm_cb.wr_en_i <= tx.wr_en_i;
	vif.bfm_cb.rd_en_i <= tx.rd_en_i;
	if(tx.wr_en_i==1 && tx.rd_en_i==0)//write operation
		vif.bfm_cb.wdata_i <= tx.wdata_i;
	if(tx.rd_en_i==1 && tx.wr_en_i==0)//read operation
		tx.rdata_o = vif.bfm_cb.rdata_o;
	tx.empty_o=vif.bfm_cb.empty_o;
	tx.full_o=vif.bfm_cb.full_o;
	tx.error_o=vif.bfm_cb.error_o;
endtask
endclass
