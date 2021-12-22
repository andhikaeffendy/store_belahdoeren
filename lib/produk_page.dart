import 'package:flutter/material.dart';
import 'package:store_belahdoeren/api/produk.dart';
import 'package:store_belahdoeren/global/variable.dart';
import 'package:store_belahdoeren/model/category.dart';
import 'package:store_belahdoeren/model/produk.dart';

class ProdukPage extends StatefulWidget {
  @override
  _ProdukPageState createState() => _ProdukPageState();
}

class _ProdukPageState extends State<ProdukPage> with TickerProviderStateMixin{

  TabController _tabController;
  bool _switchBtn = false;
  List<Category> listMenu = [];

  @override
  void initState() {
    // TODO: implement initState
    _tabController = TabController(length: 1, vsync: this);
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
          "Produk",
          style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.brown[700]),
        ),
      ),
      body: Container(
        child: FutureBuilder(
            future: futureApiMenuCategory(currentUser.token),
            builder: (context, snapshot){
              if(snapshot.connectionState == ConnectionState.waiting){
                return Center(child: CircularProgressIndicator(),);
              }else if(snapshot.connectionState == ConnectionState.done){
                ApiMenuCategory apiCategory = snapshot.data;
                if(apiCategory.isSuccess()){
                  listMenu = [];
                  listMenu.addAll(apiCategory.data);
                  _tabController = TabController(length: listMenu.length, vsync: this);
                }
              }
              return addMenuCategory();
            }),
      ),
    );
  }

  Widget _productView(BuildContext context, List<Produk> produk ){
    return GridView.builder(
      itemCount: produk.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1.05,
            mainAxisSpacing: 12,
            crossAxisSpacing: 8),
        itemBuilder: (context, index){
            return Container(
              padding: EdgeInsets.only(bottom: 8),
              margin: EdgeInsets.only(left: 16, right: 16, bottom: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(7),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    offset: Offset(1.0, 1.0), //(x,y)
                    blurRadius: 8.0,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(8),
                        topLeft: Radius.circular(8)),
                    child: Image.network(
                      produk[index].image_url,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: 100,
                      colorBlendMode: BlendMode.color,
                      color: produk[index].stock_status == 1 ? null : Colors.grey[300],
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.only(left: 8),
                        child: Text(
                            "${produk[index].name}",
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: produk[index].stock_status == 1 ? Colors.brown[700] : Colors.grey[500])
                        ),
                      ),
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.only(left: 8),
                            child: Text(
                                "${produk[index].price}",
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: produk[index].stock_status == 1 ? Colors.brown[700] : Colors.grey[500])
                            ),
                          ),
                          Spacer(),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                  "${produk[index].getActiveStatus() ? "Aktif" : "Non aktif"}",
                                  overflow: TextOverflow.clip,
                                  style: TextStyle(
                                      fontSize: 10,
                                      color: produk[index].stock_status == 1 ? Colors.brown[700] : Colors.grey[500])
                              ),
                              Transform.scale(
                                scale: 0.6,
                                child: Switch(
                                  value: produk[index].getActiveStatus(),
                                  activeTrackColor: Colors.grey[200],
                                  activeColor: Colors.green,
                                  inactiveThumbColor: Colors.red,
                                  inactiveTrackColor: Colors.grey[200],
                                  onChanged: (bool value) async {
                                    setState(() {
                                      if(produk[index].getActiveStatus() == true){
                                        futureApiSetMenuNotReady(currentUser.token, produk[index].id).then((value){
                                          if(value.isSuccess()){
                                            print(value.message);
                                          }
                                        });
                                      }else{
                                        futureApiSetMenuReady(currentUser.token, produk[index].id).then((value) {
                                          if(value.isSuccess()){
                                            print(value.message);
                                          }
                                        });
                                      }
                                    });
                                  },
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            );
        }
    );
  }

  Widget addMenuCategory(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(left: 16, right: 16),
          padding: EdgeInsets.only(top: 8),
          child: SizedBox(
            height: 30,
            child: TabBar(
              unselectedLabelColor: Colors.brown,
              labelColor: Colors.white,
              controller: _tabController,
              isScrollable: false,
              indicator: BoxDecoration(
                  color: Color(0XFFfab4b4),
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(8),
                      topLeft: Radius.circular(8))),
              tabs: tabCategory(),
            ),
          ),
        ),
        SizedBox(
          height: 16,
        ),
        Expanded(
            child: TabBarView(
              controller: _tabController,
              children: tabViewCategory(),
            )),
      ],
    );
  }

  List<Widget> tabViewCategory(){
    List<Widget> tabView = [];
    listMenu.forEach((viewCategory) {
      tabView.add(
        FutureBuilder(
            future: futureApiProdukList(currentUser.token, viewCategory.id),
            builder: (context, snapshot){
              if(snapshot.connectionState == ConnectionState.waiting){
                return Center(child: CircularProgressIndicator(),);
              }else if(snapshot.connectionState == ConnectionState.done && snapshot.hasData){
                ApiProdukList apiProduk = snapshot.data;
                if(apiProduk.isSuccess()){
                  viewCategory.menus = apiProduk.data;
                }
              }
              return _productView(context, viewCategory.menus);
        })
      );
    });
    return tabView;
  }

  List<Widget> tabCategory(){
    List<Widget> tabs = [];
    listMenu.forEach((category) {
      tabs.add(Tab(text: category.name,));
    });
    return tabs;
  }


}
