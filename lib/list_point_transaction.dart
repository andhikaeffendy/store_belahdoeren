import 'package:flutter/material.dart';
import 'package:store_belahdoeren/api/point_transaction.dart';
import 'package:store_belahdoeren/model/point_transaction.dart';

import 'detail_order.dart';
import 'global/variable.dart';

class ListPointTransaction extends StatefulWidget {
  @override
  _ListPointTransactionState createState() => _ListPointTransactionState();
}

class _ListPointTransactionState extends State<ListPointTransaction> {

  List<PointTransaction> listPointTransaction = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow[600],
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.brown),
        title: Text(
          "Transaksi Poin",
          style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.brown[700]),
        ),
      ),
      body: Container(
        margin: EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(left: 16, right: 16),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey[200]),
                child: Row(
                  children: [
                    Icon(
                      Icons.search_outlined,
                      color: Colors.grey[700],
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                              hintText: "Search",
                              hintStyle: TextStyle(
                                color: Colors.grey[700],
                              ),
                              border: InputBorder.none),
                          style: TextStyle(color: Colors.black),
                        )),
                  ],
                ),
              ),
              SizedBox(
                height: 24,
              ),
              FutureBuilder(
                  future: futureApiPointTransaction(currentUser.token),
                  builder: (context, snapshot){
                    if(snapshot.connectionState == ConnectionState.waiting){
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }else if(snapshot.connectionState == ConnectionState.done){
                      ApiPointTransaction apiList = snapshot.data;
                      if(apiList.isSuccess()){
                        listPointTransaction = apiList.data;
                      }
                    }
                    return ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: listPointTransaction.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              nextPage(context, DetailOrder(transactionList: listPointTransaction[index].id,));
                            },
                            child: Container(
                              margin: EdgeInsets.only(bottom: 16),
                              padding: EdgeInsets.only(bottom: 12),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey,
                                    offset: Offset(0.0, 1.0), //(x,y)
                                    blurRadius: 6.0,
                                  ),
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                      padding: EdgeInsets.only(top: 8, bottom: 8),
                                      decoration: BoxDecoration(
                                          color: listPointTransaction[index].status == "done" ? Colors.green : Colors.red,
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(10),
                                              topRight: Radius.circular(10))),
                                      width: double.infinity,
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          "Transaksi Poin",
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.brown[800]),
                                        ),
                                      )),
                                  SizedBox(
                                    height: 12,
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(left: 16),
                                    child: Text(
                                      "Hadiah : "+listPointTransaction[index].present_name,
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.brown[800]),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 8),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        // Container(
                                        //   decoration: BoxDecoration(
                                        //     borderRadius:
                                        //     BorderRadius.circular(5),
                                        //     color: Colors.brown,
                                        //   ),
                                        //   height: 50,
                                        //   width: 50,
                                        // ),
                                        // SizedBox(
                                        //   width: 8,
                                        // ),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Nama : " + listPointTransaction[index].user_name,
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.brown[800]),
                                            ),
                                            Text(
                                              "Status : " + (listPointTransaction[index].status == "done" ? "sudah diambil" : "belum diambil"),
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold,
                                                  color: listPointTransaction[index].status == "done" ? Colors.green : Colors.red),
                                            ),
                                          ],
                                        ), Spacer(),
                                        listPointTransaction[index].status == "done" ? Container() :
                                        ElevatedButton(
                                          onPressed: (){
                                            showCircular(context);
                                            futureApiClosePointsTransaction(currentUser.token, listPointTransaction[index].id).then((value) async {
                                              Navigator.of(context, rootNavigator: true).pop();
                                              if(value.isSuccess()){
                                                await alertDialog(context, "Transaksi", "Transaksi Selesai");
                                                setState(() {});
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
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        });
                  }
              )
            ],
          ),
        ),
      ),
    );
  }
}
