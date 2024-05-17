class fifo_common;
	static string testcase;
	static mailbox#(fifo_tx) gen2bfm = new();
	static mailbox#(fifo_tx) mon2cov = new();
	static mailbox#(fifo_tx) mon2sbd = new();
	static int count_matches;
	static int count_mismatches;
	static int count=DEPTH;
	static int total_driven_tx;
endclass
