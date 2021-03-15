import 'dart:io';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:store_belahdoeren/model/profile.dart';
import 'package:store_belahdoeren/model/user_session.dart';

String domain = "http://belahdoeren.wiradipa.com/";
String api_url = domain+"store_api/v1/";
User currentUser;
Profile currentProfile;

nextPage(context, page) async {
  return Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => page),
  );
}

startNewPage(context, page){
  Navigator.pushAndRemoveUntil(
      context,
      new MaterialPageRoute(
        builder: (context) => page,
      ), (route) => false);
}

showCircular(context){
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return new Center(
          child: new CircularProgressIndicator(),
        );
      }
  );
}

alertDialog(context, title, message) async {
  return showDialog(
      context: context,
      builder: (BuildContext context){
        return AlertDialog(
          title: Text(title),
          content: Text(message),
        );
      }
  );
}