class fifo_gen;
	fifo_tx tx;
	task run();
		$display("fifo_gen RUN TASK called");
		case(fifo_common::testcase)
			"test_one_tx":begin
				tx=new();
				assert(tx.randomize() with {tx.wr_en_i==1 && tx.rd_en_i==0;});
				fifo_common::gen2bfm.put(tx);
				tx.print("fifo_gen");
			end
			"test_rand_wr_rd":begin
				for(int i=0;i<fifo_common::count;i++) begin
					tx=new();
					assert(tx.randomize() with {tx.wr_en_i==1 && tx.rd_en_i==0;});
					fifo_common::gen2bfm.put(tx);
					tx.print("fifo_write_gen");
				end
				for(int i=0;i<fifo_common::count;i++) begin
					tx=new();
					tx.wdata_i.rand_mode(0);
					assert(tx.randomize() with {tx.rd_en_i==1 && tx.wr_en_i==0;});
					fifo_common::gen2bfm.put(tx);
					tx.print("fifo_read_gen");
				end
			end
		endcase
	endtask
endclass
