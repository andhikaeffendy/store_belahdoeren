import 'package:flutter/material.dart';
import 'package:store_belahdoeren/api/logout.dart';
import 'package:store_belahdoeren/login.dart';
import 'global/session.dart';
import 'global/variable.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await loadSession();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: _getStartupScreen(),
    );
  }

  Widget _getStartupScreen() {
    return currentUser != null
        ? MyHomePage(title: 'Flutter Demo Home Page')
        : Login();
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  GlobalKey<ScaffoldState> _scaffoldKEY = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: FloatingActionButton(
          child: Image.asset("assets/scan_qr.png", fit: BoxFit.fill),
          backgroundColor: Colors.transparent,
          onPressed: (){
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      key: _scaffoldKEY,
      drawer: Drawer(
        child: Container(
          margin: EdgeInsets.only(left: 16,right: 16, top: 36),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.brown, width: 1),
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: AssetImage(
                          "assets/login_logo.png",
                        ),
                        fit: BoxFit.fitHeight)),
              ),
              SizedBox(
                height: 16,
              ),
              Text(
                "Nama",
                style: TextStyle(
                    color: Colors.brown,
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold),
              ),SizedBox(
                height: 8,
              ),Text(
                currentUser.name,
                style: TextStyle(
                    color: Colors.brown,
                    fontSize: 14.0,),
              ),
              SizedBox(
                height: 32,
              ),
              Container(
                color: Colors.grey[300],
                height: 1,
              ),SizedBox(
                height: 16,
              ),
              Row(
                children: [
                  Icon(
                    Icons.person_pin,
                    color: Colors.brown,
                    size: 35,
                  ),
                  SizedBox(width: 16),
                  Text(
                    "Edit Profile",
                    style: TextStyle(color: Colors.brown, fontSize: 16),
                  )
                ],
              ),SizedBox(
                height: 16,
              ),
              Container(
                color: Colors.grey[300],
                height: 1,
              ),SizedBox(
                height: 16,
              ),
              GestureDetector(
                onTap: (){
                  showCircular(context);
                  futureApiLogout(currentUser.token).then((value){
                    Navigator.of(context, rootNavigator: true).pop();
                    currentUser = null;
                    destroySession();
                    startNewPage(context, Login());
                  });
                },
                child: Row(
                  children: [
                    Icon(
                      Icons.exit_to_app,
                      color: Colors.brown,
                      size: 35,
                    ),
                    SizedBox(width: 16),
                    Text(
                      "Logout",
                      style: TextStyle(color: Colors.brown, fontSize: 16),
                    )
                  ],
                ),
              ),SizedBox(
                height: 16,
              ),
              Container(
                color: Colors.grey[300],
                height: 1,
              ),SizedBox(
                height: 16,
              ),
            ],
          ),
        ),
      ),
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height*0.50,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomRight: Radius.elliptical(200, 150),
                bottomLeft: Radius.elliptical(200, 150)
              ),
              color: Colors.yellow[600],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: EdgeInsets.only(top: 32),
                padding: EdgeInsets.only(right: 16, left: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),color: Colors.white
                ),
                child: IconButton(
                    icon: Icon(Icons.menu, color: Colors.brown[700], size: 30,),
                    onPressed: () => _scaffoldKEY.currentState.openDrawer()),
              ),
              Container(
                margin: EdgeInsets.only(top: 32),
                padding: EdgeInsets.only(right: 8, left: 16),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      bottomLeft: Radius.circular(30),
                    ),color: Colors.white
                ),
                child: IconButton(
                    icon: Icon(Icons.collections_bookmark, color: Colors.brown[700], size: 25,),
                    onPressed: () => _scaffoldKEY.currentState.openDrawer()),
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.only(left: 16, right: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: Image.asset(
                    "assets/logo_home.png",
                    height: 230,
                    fit: BoxFit.contain,
                  ),
                ),
                Text(
                  "Selamat Datang,",
                  style: TextStyle(
                      color: Colors.brown[700],
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold),
                ),Text(
                  currentUser.name,
                  style: TextStyle(
                      color: Colors.brown[600],
                      fontSize: 40.0,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height*0.25,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset("assets/store.png", width: MediaQuery.of(context).size.width/2.3, height: 150, fit: BoxFit.fill),
                    SizedBox(
                      width: 16,
                    ),
                    Image.asset("assets/delivery.png", width: MediaQuery.of(context).size.width/2.3, height: 150, fit: BoxFit.fill)
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
