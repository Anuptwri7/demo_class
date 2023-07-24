import 'dart:developer';

import 'package:demo_class/auth/authCheckPage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? userName ;


  Future getUserName()async{
    SharedPreferences prefs =await SharedPreferences.getInstance();
   setState(() {
     userName= prefs.getString("userName");
   });
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserName();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${userName.toString()}",style: TextStyle(color: Colors.black),),
        elevation: 0,
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          ElevatedButton(onPressed: ()async{
            SharedPreferences prefs = await SharedPreferences.getInstance();
            prefs.clear();
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>AuthCheckPage()));
          }, child: Text("Logout"))
        ],
      ),
    );
  }
}
