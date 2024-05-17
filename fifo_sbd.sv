class fifo_sbd;
	//decalre an associative array
	bit [WIDTH-1:0]assoc_arr[int];
	fifo_tx tx;
	task run();
		forever begin
		$display("fifo_sbd RUN TASK called");
		fifo_common::mon2sbd.get(tx);
			if(tx.wr_en_i==1 && tx.rd_en_i==0) begin
					assoc_arr[tx.wr_ptr]=tx.wdata_i;
					tx.wr_ptr++;
			end
			else if(tx.rd_en_i==1 && tx.wr_en_i==0) begin
					if(assoc_arr[tx.wr_ptr]==tx.rdata_o) begin
						fifo_common::count_matches++;
						$display("matches=%d",fifo_common::count_matches);
						$display("assoc_arr[%h]=%h is matching with tx.rdata_o=%h",tx.wr_ptr,assoc_arr[tx.wr_ptr],tx.rdata_o);
					end
			        	else begin
						fifo_common::count_mismatches++;
						$display("mismatches=%d",fifo_common::count_mismatches);
						$display("assoc_arr[%h]=%h is not matching with tx.rdata_o=%h",tx.wr_ptr,assoc_arr[tx.wr_ptr],tx.rdata_o);
					end
					tx.wr_ptr++;
			end
		end
	endtask
endclass
