import 'package:flutter/material.dart';
import 'package:store_belahdoeren/api/forgot_password.dart';

import 'global/variable.dart';

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final emailEditTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
            ),ListView(
              children: [
                Column(
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
                      "Lupa Password?",
                      style: TextStyle(
                          color: Colors.brown[700],
                          fontSize: 40.0,
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
                    ),SizedBox(
                      height: 16,
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 16, right: 16),
                      child: Text(
                        "Kami akan mengirim password baru ke alamat email anda",
                        style: TextStyle(
                            fontSize: 14,
                            color: Colors.brown
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 36,
                    ),Container(
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
                            futureApiForgotPassword(emailEditTextController.text).then((value) async {
                              Navigator.of(context, rootNavigator: true).pop();
                              if(value.isSuccess()){
                                await alertDialog(context, "Lupa Password", "Password Berhasil dikirim ke email");
                                Navigator.pop(context);
                              }else{
                                await alertDialog(context, "Lupa Password", value.message);
                              }
                            });
                          },
                          color: Colors.green[700],
                          textColor: Colors.white,
                          child: Text("Ganti Password",
                              style: TextStyle(fontSize: 16,
                                  fontWeight: FontWeight.bold)),
                        ),
                      ),
                    )
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
