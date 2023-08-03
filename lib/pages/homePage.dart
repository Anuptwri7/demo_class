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
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Visibility(
                  visible:userName=='daman'?true:false,
                  child: Container(
                    height: 150,
                    width: MediaQuery.of(context).size.width/3,
                    color: Colors.blue,
                    child: Center(child: Text("Box 1",style: TextStyle(color: Colors.white))),
                  ),
                ),
                Visibility(
                  visible:userName=='anup'?true:false,
                  child: Container(
                    height: 150,
                    width: MediaQuery.of(context).size.width/3,
                    color: Colors.red,
                    child: Center(child: Text("Box 2",style: TextStyle(color: Colors.white),)),
                  ),
                ),
              ],
            ),
          ),
          Text("${userName=="daman"?"the name is ${userName}":"The name is not daman"}"),
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
