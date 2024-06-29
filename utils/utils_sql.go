package utils

import (
	"database/sql"
	_ "github.com/go-sql-driver/mysql"
	"log"
)

type InsertData struct {
	Shard_num                   int
	Node_num                    int // request message
	Run_mod                     string
	Use_shard_weight            bool
	Inject_speed                int
	Total_data_size             int
	Average_tps                 string
	Cross_transaction_ratio     string
	Transaction_confirm_latency string
	Tx_number                   string
}

// func insertMeasureMetrics(ShardNum int, NodesInShard int, modID int, isUseShardWeight bool, avgTPS float64, crossTxRatio float64, confirmLatency float64, txNumber float64) {
func InsertMeasureMetrics(data InsertData) {

	db, err := sql.Open("mysql", "root:qweasd@tcp(localhost:3306)/block_chain")
	if err != nil {
		log.Fatal(err)
	}
	defer db.Close()

	insertStmt := `
		INSERT INTO emulator (shard_num,node_num,run_mod,use_shard_weight,inject_speed,total_data_size,average_tps,
		                      cross_transaction_ratio,transaction_confirm_latency,tx_number) VALUES (?,?,?,?,?,?,?,?,?,?);
`

	stmt, err := db.Prepare(insertStmt)
	if err != nil {
		log.Fatal(err)
	}
	defer stmt.Close()

	res, err := stmt.Exec(data.Shard_num, data.Node_num, data.Run_mod, data.Use_shard_weight, data.Inject_speed, data.Total_data_size, data.Average_tps,
		data.Cross_transaction_ratio, data.Transaction_confirm_latency, data.Tx_number)
	if err != nil {
		log.Fatal(err)
	}

	lastInsertID, err := res.LastInsertId()
	if err != nil {
		log.Fatal(err)
	}
	log.Printf("Data inserted successfully. Last inserted ID: %d", lastInsertID)

}
