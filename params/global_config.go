package params

var (
	BlockInterval      = 5000   // generate new block interval  Millisecond
	MaxBlockSizeGlobal = 2000   // the block contains the maximum number of transactions
	InjectSpeed        = 2000   // the transaction inject speed
	TotalDataSize      = 100000 // the total number of txs
	BatchSize          = 16000  // supervisor read a batch of txs then send them, it should be larger than inject speed
	BrokerNum          = 10
	NodesInShard       = 4
	ShardNum           = 4
	DataWrite_path     = "result" // measurement data result output path
	//DataWrite_path     = "./result_broker/" // measurement data result output path
	LogWrite_path = "log" // log output path
	//LogWrite_path      = "./log_broker"     // log output path
	SupervisorAddr = "127.0.0.1:18800" //supervisor ip address
	//FileInput           = `../2000000to2999999_BlockTransaction.csv` //the raw BlockTransaction data path
	FileInput      = `./dataset/2000000to2999999_BlockTransaction.csv` //the raw BlockTransaction data path
	UseShardWeight = false
	ShardWeight    = make(map[uint64]uint64)
	//每个分片权重等于  shardNum+1
	RecordFileName = "record"
	RunMode        = ""
)
