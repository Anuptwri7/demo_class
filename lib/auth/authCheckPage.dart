import 'dart:developer';

import 'package:demo_class/auth/loginScreen.dart';
import 'package:demo_class/pages/homePage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../pages/stock_anaysis.dart';

class AuthCheckPage extends StatefulWidget {
  const AuthCheckPage({Key? key}) : super(key: key);

  @override
  State<AuthCheckPage> createState() => _AuthCheckPageState();
}

class _AuthCheckPageState extends State<AuthCheckPage> {

  String token='';


  Future checkLoggedIn() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      token= sharedPreferences.getString("accessToken").toString();
    });
    if(token=="null"){
      log(token.toString());
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
    }else{
      log("token has"+token.toString());
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>StockAnalysisPage()));

    }

}

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkLoggedIn();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("splash Page"),
      ),
    );
  }
}
