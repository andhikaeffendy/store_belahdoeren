import 'package:flutter/material.dart';
import 'package:store_belahdoeren/api/transaction.dart';
import 'package:store_belahdoeren/model/past_transaction.dart';

import 'detail_order.dart';
import 'global/variable.dart';

class ListPickup extends StatefulWidget {
  @override
  _ListPickupState createState() => _ListPickupState();
}

class _ListPickupState extends State<ListPickup> {

  List<PastTransaction> listPickup = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow[600],
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.brown),
        title: Text(
          "Pickup Order",
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
                  future: futureApiListPickup(currentUser.token),
                  builder: (context, snapshot){
                    if(snapshot.connectionState == ConnectionState.waiting){
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }else if(snapshot.connectionState == ConnectionState.done){
                      ApiListPickup apiList = snapshot.data;
                      if(apiList.isSuccess()){
                        listPickup = apiList.data;
                      }
                    }

                    return ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: listPickup.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              nextPage(context, DetailOrder(transactionList: listPickup[index].id,));
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
                                  listPickup[index].transaction_type == "Pickup" ?
                                  Container(
                                      padding: EdgeInsets.only(top: 8, bottom: 8),
                                      decoration: BoxDecoration(
                                          color: Colors.red[100],
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(10),
                                              topRight: Radius.circular(10))),
                                      width: double.infinity,
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          listPickup[index].transaction_type,
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.brown[800]),
                                        ),
                                      ))
                                      :
                                  Container(
                                      padding: EdgeInsets.only(top: 8, bottom: 8),
                                      decoration: BoxDecoration(
                                          color: Colors.green[400],
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(10),
                                              topRight: Radius.circular(10))),
                                      width: double.infinity,
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          listPickup[index].transaction_type,
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white),
                                        ),
                                      )),
                                  SizedBox(
                                    height: 12,
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(left: 16),
                                    child: Text(
                                      "Nomor Pesanan : "+listPickup[index].transaction_number,
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
                                        Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                            BorderRadius.circular(5),
                                            color: Colors.brown,
                                          ),
                                          height: 50,
                                          width: 50,
                                        ),
                                        SizedBox(
                                          width: 8,
                                        ),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Harga : " + listPickup[index].total_price,
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.brown[800]),
                                            ),Container(
                                              child: Text(
                                                "Tax : "+listPickup[index].tax,
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.brown[800]),
                                              ),
                                            ),
                                          ],
                                        ), Spacer(),
                                        Text(
                                          listPickup[index].grand_total,
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.brown[800]),
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
