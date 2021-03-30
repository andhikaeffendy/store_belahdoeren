import 'package:flutter/material.dart';
import 'package:store_belahdoeren/forgot_password.dart';
import 'package:store_belahdoeren/global/variable.dart';
import 'package:store_belahdoeren/main.dart';
import 'api/login.dart';
import 'global/session.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final emailEditTextController = TextEditingController();
  final passwordEditTextController = TextEditingController();
  static bool _visible = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            Positioned(
              bottom: 0,
              child: RotationTransition(
                turns: new AlwaysStoppedAnimation(180 / 360),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height*0.50,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(
                            "assets/circle_1.png",
                          ),
                          fit: BoxFit.fitHeight)),
                ),
              ),
            ),
            SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 46),
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Image.asset(
                        "assets/login_logo.png",
                        height: 170,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Text(
                    "Selamat Datang",
                    style: TextStyle(
                        color: Colors.brown[700],
                        fontSize: 40.0,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "di Aplikasi Store Belah Doeren",
                    style: TextStyle(
                        color: Colors.brown[600],
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height*0.25,
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 16, right: 16),
                    child: Theme(
                      data: Theme.of(context)
                          .copyWith(splashColor: Colors.transparent),
                      child: TextField(
                        controller: emailEditTextController,
                        autofocus: false,
                        style: TextStyle(fontSize: 14.0, color: Colors.black),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'Email',
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),Container(
                    margin: EdgeInsets.only(left: 16, right: 16),
                    child: Theme(
                      data: Theme.of(context)
                          .copyWith(splashColor: Colors.transparent),
                      child: TextField(
                        controller: passwordEditTextController,
                        obscureText: _visible,
                        style: TextStyle(fontSize: 14.0, color: Colors.black),
                        decoration: InputDecoration(
                          suffixIcon: IconButton(icon: Icon(Icons.remove_red_eye),
                            color: Colors.black54,
                            onPressed: (){
                              setState(() {
                                _visible = !_visible;
                              });
                            }
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'Password',
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ),
                  ),SizedBox(
                    height: 16,
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 16, right: 16),
                    child: ButtonTheme(
                      padding: EdgeInsets.all(12),
                      minWidth: double.infinity,
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            side: BorderSide(color: Colors.green[700])),
                        onPressed: () {
                          showCircular(context);
                          futureApiLogin(emailEditTextController.text, passwordEditTextController.text).then((value) async {
                            Navigator.of(context, rootNavigator: true).pop();
                            if(value.isSuccess()){
                              currentUser = value.user;
                              storeSession();
                              startNewPage(context, MyHomePage(title: 'Flutter Demo Home Page'));
                            } else {
                              await alertDialog(context, "Sign In Gagal", value.message);
                            }
                          });
                        },
                        color: Colors.green[700],
                        textColor: Colors.white,
                        child: Text("Login",
                            style: TextStyle(fontSize: 16)),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),Container(
                    margin: EdgeInsets.only(left: 16, right: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: (){
                            //nextPage(context, Registrasi());
                          },child: Text("Belum punya akun?",style: TextStyle(color: Colors.brown, fontWeight: FontWeight.bold)),
                        ),
                        GestureDetector(
                          onTap: (){
                            nextPage(context, ForgotPassword());
                          },
                          child: Text("Lupa password?", style: TextStyle(color: Colors.brown[200], fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
