import 'package:flutter/material.dart';
import 'package:store_belahdoeren/api/transaction.dart';
import 'package:store_belahdoeren/global/variable.dart';
import 'package:store_belahdoeren/model/transaction_detail.dart';

class TransaksiPage extends StatefulWidget {
  @override
  _TransaksiPageState createState() => _TransaksiPageState();
}

class _TransaksiPageState extends State<TransaksiPage> {

  List<TransactionDetail> listTransaksi = [];
  String countTransaction;

  @override
  void initState() {
    // TODO: implement initState
    _loadCountData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow[600],
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.brown),
        title: Text(
          "Transaksi",
          style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.brown[700]),
        ),
      ),
      body: Container(
        child: FutureBuilder(
          future: futureApiCurrentTransaction(currentUser.token),
          builder: (context, snapshot){
            if(snapshot.connectionState == ConnectionState.waiting){
              return Center(child: CircularProgressIndicator(),);
            }else if(snapshot.connectionState == ConnectionState.done && snapshot.hasData){
              ApiCurrentTransaction apiCurrent = snapshot.data;
              if(apiCurrent.isSuccess()){
                listTransaksi = apiCurrent.data;
                countTransaction = apiCurrent.total;
              }
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 16
                  ),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(16),
                          bottomRight: Radius.circular(16)
                      ),
                      color: Colors.yellow[600]
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Total transaksi hari ini",
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.brown[700]),
                      ),
                      Row(
                        children: [
                          Image.asset(
                            "assets/icon_bronze.png",
                            width: MediaQuery.of(context).size.width*0.03,
                            height: MediaQuery.of(context).size.height*0.03,
                            fit: BoxFit.contain,
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Text(
                            "${countTransaction}",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w800,
                                color: Colors.brown[700]),
                          ),
                          Spacer(),
                          Text(
                            "Rincian >",
                            style: TextStyle(
                                fontSize: 12,
                                color: Colors.green[700]),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                Flexible(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Riwayat transaksi",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.brown[700]),
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Expanded(
                          child: listTransaksi.isEmpty ? Center(child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            child: Text(
                              "Belum ada transaksi yang di lakukan hari ini!",
                               textAlign: TextAlign.center,
                               style: TextStyle(
                                 fontSize: 16,
                                 color: Colors.brown[700],
                                 fontWeight: FontWeight.bold
                               ),
                            ),
                          ),) : ListView.builder(
                              itemCount: listTransaksi.length,
                              itemBuilder: (context,index){
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    index != 0 ?
                                    SizedBox(
                                      height: 16,
                                    ) : Container(),
                                    Container(
                                      height: 1,
                                      color: Colors.black38,
                                    ),
                                    SizedBox(
                                      height: 16,
                                    ),
                                    Container(
                                      child: Text(
                                        listTransaksi[index].grand_total,
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.brown[700]),
                                      ),
                                    ),
                                    Text(
                                      "${listTransaksi[index].transaction_number} - ${listTransaksi[index].userName} - ${listTransaksi[index].transaction_date}",
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.brown[700]),
                                    ),
                                  ],
                                );
                              })

                        )
                      ],
                    ),
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }

  _loadCountData(){
    setState(() {
      futureApiCurrentTransaction(currentUser.token).then((value) {
        if(value.isSuccess()){
          countTransaction = value.total;
        }
      });
    });

  }

}
