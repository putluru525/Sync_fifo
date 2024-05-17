class fifo_cov;
	fifo_tx tx;
covergroup fifo_cg;
	WR_CP:coverpoint tx.wr_en_i{
		bins WR_BIN={1};
		bins RD_BIN={0};
		}
	RD_CP:coverpoint tx.rd_en_i{
		bins RD_BIN={1};
		bins WR_BIN={0};
		}
	WR_CP_X_RD_CP:cross WR_CP,RD_CP;
endgroup
function new();
	fifo_cg=new();
endfunction
	task run();
		$display("fifo_cov RUN TASK called");
		forever begin
			fifo_common::mon2cov.get(tx);
			fifo_cg.sample();
		end
	endtask
endclass
