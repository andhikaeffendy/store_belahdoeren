import 'package:flutter/material.dart';
import 'package:store_belahdoeren/api/transaction.dart';
import 'package:store_belahdoeren/model/ItemsTransaction.dart';
import 'global/variable.dart';

class DetailOrder extends StatefulWidget {

  final int transactionList;

  @override
  _DetailOrderState createState() => _DetailOrderState(transactionList);

  const DetailOrder({Key key, @required this.transactionList}) : super(key: key);
}

class _DetailOrderState extends State<DetailOrder> {

  final int transactionList;
  _DetailOrderState(this.transactionList);

  List<ItemsTransaction> items = List<ItemsTransaction>.empty();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.brown),
        title: Center(
          child: Text(
            "Detail Order",
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.brown[700]),
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: _detailView(),
        ),
      ),
    );
  }

  Widget _detailView(){
    return FutureBuilder(
        future: futureDetailOrder(currentUser.token, transactionList),
        builder: (context, snapshot){
          if(snapshot.connectionState == ConnectionState.waiting){
            return Center(
              child: CircularProgressIndicator(),
            );
          }else if(snapshot.connectionState == ConnectionState.done){
            ApiDetailOrder data = snapshot.data;
            if(data.isSuccess()){
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width / 3,
                      child: Text(
                        "No. Transaksi",
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.brown[700]),
                      ),
                    ),
                    Text(
                      data.data.transaction_number,
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.brown[700]),
                    )
                  ],
                ),
                SizedBox(
                  height: 16,
                ),Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width / 3,
                      child: Text(
                        "Metode Pembelian ",
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.brown[700]),
                      ),
                    ),
                    Text(
                      data.data.transaction_type,
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.brown[700]),
                    )
                  ],
                ),
                SizedBox(
                  height: 16,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width / 3,
                      child: Text(
                        "Outlet Pembelian",
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.brown[700]),
                      ),
                    ),
                    Container(
                      child: Text(
                        data.data.branch_name,
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.brown[700]),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 16,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width / 3,
                      child: Text(
                        "Nama Pemesan",
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.brown[700]),
                      ),
                    ),
                    Flexible(
                      child: Container(
                        child: Text(
                          data.data.userName,
                          overflow: TextOverflow.clip,
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.brown[700]),
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 16,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width / 3,
                      child: Text(
                        "Nomor Telepon",
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.brown[700]),
                      ),
                    ),
                    Flexible(
                      child: Container(
                        child: Text(
                          data.data.userPhone,
                          overflow: TextOverflow.clip,
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.brown[700]),
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 16,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width / 3,
                      child: Text(
                        "Metode Pembayaran",
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.brown[700]),
                      ),
                    ),
                    Flexible(
                      child: Container(
                        child: Text(
                          data.data.paymentMethodName,
                          overflow: TextOverflow.clip,
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.brown[700]),
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 16,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width / 3,
                      child: Text(
                        "Alamat Pengiriman",
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.brown[700]),
                      ),
                    ),
                    Flexible(
                      child: Container(
                        child: Text(
                          data.data.my_address,
                          overflow: TextOverflow.clip,
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.brown[700]),
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 16,
                ),
                Center(
                  child: Text(
                    data.data.transactionStatusName,
                    overflow: TextOverflow.clip,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: data.data.transactionFinish() ? Colors.green[700] : Colors.red[700]),
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                Container(
                  height: 1,
                  color: Colors.brown[100],
                ),
                SizedBox(
                  height: 16,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(5.0),
                  child: Container(
                    width: double.infinity,
                    margin: EdgeInsets.all(4),
                    padding: EdgeInsets.all(12), //Same as `blurRadius` i guess
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          offset: Offset(0.0, 1.0), //(x,y)
                          blurRadius: 4.0,
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Pesanan",
                          style: TextStyle(
                              fontSize: 14,
                              color: Colors.brown[700],
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              width: 60,
                              child: Text(
                                "Jumlah",
                                style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.black26,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width/2.8,
                              child: Text(
                                "Nama Barang",
                                style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.black26,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Container(
                              width: 100,
                              child: Text(
                                "Harga",
                                style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.black26,
                                    fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,
                              ),
                            ),SizedBox(width: 16,)
                          ],
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        FutureBuilder(
                            future: futureDetailOrder(currentUser.token, transactionList),
                            builder: (context, snapshot){
                              if(snapshot.connectionState == ConnectionState.waiting){
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                              else if(snapshot.connectionState == ConnectionState.done){
                                print(snapshot.data);
                                ApiDetailOrder apiorder = snapshot.data;
                                if(apiorder.isSuccess()){
                                  items = apiorder.items;
                                }
                                return ListView.builder(
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemCount: items.length,
                                    itemBuilder: (context, index) {
                                      return Container(
                                        padding: EdgeInsets.only(bottom: 8),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              width: 60,
                                              child: Text(
                                                items[index].quantity.toString(),
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.brown[700],
                                                    fontWeight: FontWeight.bold),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                            items[index].note != "" ?
                                                Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      width: MediaQuery.of(context).size.width/2.8,
                                                      child: Text(
                                                        items[index].menu_name,
                                                        style: TextStyle(
                                                            fontSize: 14,
                                                            color: Colors.brown[700],
                                                            fontWeight: FontWeight.bold),
                                                      ),
                                                    ),
                                                    Container(
                                                      width: MediaQuery.of(context).size.width/2.8,
                                                      child: Text(
                                                        "Note : ${items[index].note}",
                                                        style: TextStyle(
                                                            fontSize: 12,
                                                            color: Colors.red[700],
                                                            fontWeight: FontWeight.bold),
                                                      ),
                                                    ),
                                                  ],
                                                )
                                            :
                                            Container(
                                              width: MediaQuery.of(context).size.width/2.8,
                                              child: Text(
                                                items[index].menu_name,
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.brown[700],
                                                    fontWeight: FontWeight.bold),
                                              ),
                                            ),
                                            Container(
                                              width: 100,
                                              child: Text(
                                                items[index].sub_total,
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.brown[700],
                                                    fontWeight: FontWeight.bold),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),SizedBox(width: 16,)
                                          ],
                                        ),
                                      );
                                    });
                              }else{
                                return Container();
                              }
                            })
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(5.0),
                  child: Container(
                    width: double.infinity,
                    margin: EdgeInsets.all(4),
                    padding: EdgeInsets.all(12), //Same as `blurRadius` i guess
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          offset: Offset(0.0, 1.0), //(x,y)
                          blurRadius: 4.0,
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Payment Summary",
                          style: TextStyle(
                              fontSize: 14,
                              color: Colors.brown,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Subtotal",
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black26,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              data.data.total_price.toString(),
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black26,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Tax",
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black26,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              data.data.tax.toString(),
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black26,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Discount Member",
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.green[900],
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              data.data.discount == null ? "0" : data.data.discount,
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.green[900],
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Container(
                          height: 1,
                          color: Colors.brown[100],
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Total",
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.brown[700],
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              data.data.grand_total.toString(),
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.brown[700],
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 16,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                data.data.transaction_status == 3 ?
                Container(
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: (){
                        showCircular(context);
                        futureApiCloseTransaction(currentUser.token, transactionList).then((value) async {
                          Navigator.of(context, rootNavigator: true).pop();
                          if(value.isSuccess()){
                            await alertDialog(context, "Transaksi", "Transaksi Selesai");
                            Navigator.of(context, rootNavigator: true).pop();
                          }else{
                            await alertDialog(context, "Transaksi", value.message);
                          }
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                        backgroundColor: Colors.green[700],
                      ),
                      // textColor: Colors.black,
                      child: Text("Selesai",
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black)),
                    ),
                  ),
                )
                    : Container(),
                Container(
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                        backgroundColor: Colors.grey[300],
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },//doSubmit(),
                      child: Text("Kembali",
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
                    ),
                  ),
                ),
                data.data.paymentMethodId == 9 && data.data.transaction_status == 0 && data.data.transaction_type == "Pickup" ?
                Container(
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                        backgroundColor: Colors.green[900],
                      ),
                      onPressed: () {
                        showCircular(context);
                        futureApiStorePayment(currentUser.token, data.data.id).then((value) async {
                          Navigator.of(context, rootNavigator: true).pop();
                          if(value.isSuccess()){
                            await alertDialog(context, "Transaksi", value.message);
                            Navigator.of(context, rootNavigator: true).pop();
                          }else{
                            await alertDialog(context, "Transaksi", value.message);
                          }
                        });
                      },//doSubmit(),
                      child: Text("PAID",
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
                    ),
                  ),
                ) : Container(),
                SizedBox(
                  height: 16,
                )
              ],
            );
          }else{
            return Container();
          }
        });
  }

}
