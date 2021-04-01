import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:store_belahdoeren/api/logout.dart';
import 'package:store_belahdoeren/api/profile.dart';
import 'package:store_belahdoeren/detail_order.dart';
import 'package:store_belahdoeren/edit_profile.dart';
import 'package:store_belahdoeren/global/session.dart';
import 'package:store_belahdoeren/list_delivery.dart';
import 'package:store_belahdoeren/list_past_order.dart';
import 'package:store_belahdoeren/list_pickup.dart';
import 'package:store_belahdoeren/login.dart';
import 'package:store_belahdoeren/api/fcm.dart';
import 'global/session.dart';
import 'global/variable.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('Handling a background message ${message.messageId}');
}

// Belah Doeren Notification
const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'belah_doeren_store_channel', // id
  'Belah Doeren Store', // title
  'This channel is used for important notifications.', // description
  importance: Importance.max,
);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await loadSession();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
      AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
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
  String qrCode = "";

  saveToken(token){
   print(token);
    if(currentUser == null ){
      print("not login");
    } else if (userRegistrationToken != token) {
      futureApiSendRegistrationToken(currentUser.token, token).then((value){
        if(value.isSuccess()) {
          userRegistrationToken = token;
          storeRegistrationTokenSession();
        }
      });
    } else {
      print("already sent token. not yet refreshed.");
      //do nothing
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FirebaseMessaging.instance.requestPermission(
        sound: true, badge: true, alert: true, provisional: false)
        .then((value){
      debugPrint('Settings registered: ${value.authorizationStatus}');
    });

    if(userRegistrationToken == null)
      FirebaseMessaging.instance.getToken().then((token) => saveToken(token));
    FirebaseMessaging.instance.onTokenRefresh.listen(saveToken);

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification notification = message.notification;
      AndroidNotification android = message.notification?.android;

      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                channel.description,
                icon: 'launch_background',
              ),
            ));
      }
    });

    setState(() {
      // FutureBuilder(
      //     future: futureApiEditProfile(currentUser.token),
      //     builder: (context, snapshot){
      //       if(snapshot.connectionState == ConnectionState.waiting){
      //         return CircularProgressIndicator();
      //       }
      //       else if(snapshot.connectionState == ConnectionState.done){
      //         currentProfile = snapshot.data;
      //       }
      //     });
      if(currentProfile == null){
        futureApiEditProfile(currentUser.token).then((value) async {
          if(value.isSuccess()){
            currentProfile = value.data;
          }else if(value.message == "Token not valid/authorized"){
            currentUser == null;
            destroySession();
            startNewPage(context, Login());
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: FloatingActionButton(
          child: Image.asset("assets/scan_qr.png", fit: BoxFit.fill),
          backgroundColor: Colors.transparent,
          onPressed: (){
            setState(() async{
              scanQrCode();
            });
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
                        image:
                        currentProfile != null ?
                        NetworkImage(
                          currentProfile.photo,
                        )
                            :
                        AssetImage(
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
              GestureDetector(
                onTap: (){
                  nextPage(context, EditProfile());
                },
                child: Row(
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
            width: double.infinity,
            height: 400,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                      "assets/circle_1.png",
                    ),
                    fit: BoxFit.fitHeight)),
          ),
          Positioned(
            bottom: 50,
            child: Container(
              width: 160,
              height: 400,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(
                        "assets/circle_2.png",
                      ),
                      fit: BoxFit.fill)),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Container(
              width: 100,
              height: 120,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(
                        "assets/circle_3.png",
                      ),
                      fit: BoxFit.fill)),
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
                    onPressed: (){
                      nextPage(context, ListPastOrder());
                    }
                ),
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
                    GestureDetector(
                        onTap: (){
                          nextPage(context, ListPickup());
                        },
                        child: Image.asset("assets/store.png",
                            width: MediaQuery.of(context).size.width/2.3,
                            height: 150,
                            fit: BoxFit.fill)),
                    SizedBox(
                      width: 16,
                    ),
                    GestureDetector(
                        onTap: (){
                          nextPage(context, ListDelivery());
                        },
                        child: Image.asset("assets/delivery.png",
                            width: MediaQuery.of(context).size.width/2.3,
                            height: 150,
                            fit: BoxFit.fill))
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );

  }

  Future<void> scanQrCode() async {
    String barcode = await BarcodeScanner.scan();
    this.qrCode = barcode;
    print(barcode);
    var generate = qrCode.split('/');
    String split = generate[4].trim();
    String splitCheck1 = generate[1].trim();
    String splitCheck2 = generate[2].trim();
    String splitCheck3 = generate[3].trim();
    print("code "+barcode);
    print("split "+split);
    if(barcode == "/store_api/v1/transaction_detail/" +split){
      if(split == generate[4].trim()){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DetailOrder(transactionList: int.parse(split))),
        );
      }
    }
    else{
      await alertDialog(context, "Qr Scan", "Tidak Terdaftar");
    }
  }

}
