import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:demo_class/auth/authCheckPage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/apiConstant.dart';
import '../constants/styleConstant.dart';
import '../pages/homePage.dart';
import 'branch/model/branchModel.dart';
import 'branch/services/branchApi.dart';


class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // late LoginReturnModel userLogin;
  // late BranchesModel branchesModel;
  String dropdownnewValueUser = 'Select Branch';

  var username, password;
  bool obsecureTextState = true;
  IconData showPasswordIcon = Icons.remove_red_eye;
  final _loginFormKey = GlobalKey<FormState>();
  var dropdownValue ='Select Branch';
  var checkedValue = false;
  // late http.Response response;
  late SharedPreferences prefs;
  int? _selecteduser;
  // late ArsProgressDialog progressDialog;
  List<String> dropDownBranches = [];
  var subDomain = '';

  @override
  void initState() {
    // TODO: implement initState
    // progressDialog = loadProgressBar(context);
    // loadBranches();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(new FocusNode()),
        child: Stack(
          children: [
            SizedBox(
              height: double.infinity,
              child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                padding: kMarginPaddMedium,
                child: ListView(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10, left: 10),
                      child: Row(
                        children: [
                          Text(
                            'Login Text',
                            style: TextStyle(fontSize: 20, color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                    kHeightVeryBig,
                    // kHeightMedium,
                    Text(
                      "Branch",
                      style: TextStyle(fontSize: 18, color: Colors.black),
                    ),

                    Form(
                      key: _loginFormKey,
                      child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.all(4.0),
                            padding: EdgeInsets.all(4.0),
                            decoration: kFormBoxDecoration,
                            width: MediaQuery.of(context).size.width,
                            child: FutureBuilder(
                              future: fetchBranchFromUrl(),
                              builder: (BuildContext context,
                                  AsyncSnapshot snapshot) {
                                if (snapshot.hasError) {
                                  return Text("Loading");
                                }
                                if (snapshot.hasData) {
                                  try {
                                    final List<Result> snapshotData =
                                        snapshot.data;
                                    return DropdownButton<Result>(
                                      elevation: 24,
                                      isExpanded: true,
                                      hint: Text(
                                          "${dropdownnewValueUser.isEmpty ? "Select Branch" : dropdownnewValueUser}"),
                                      // newValue: snapshotData.first,
                                      iconSize: 24.0,
                                      icon: Icon(
                                        Icons.arrow_drop_down_circle,
                                        color: Colors.grey,
                                      ),

                                      underline: Container(
                                        height: 2,
                                        color: Colors.white,
                                      ),
                                      items: snapshotData
                                          .map<DropdownMenuItem<Result>>(
                                              (Result items) {
                                            return DropdownMenuItem<Result>(
                                              value: items,
                                              child: Text(items.name.toString()),
                                            );
                                          }).toList(),
                                      onChanged: (Result? newValue) {
                                        setState(
                                              () {
                                            dropdownnewValueUser =
                                                newValue!.name.toString();
                                            _selecteduser = newValue.id;
                                            subDomain =
                                                newValue.subDomain.toString();
                                            log("----selected id----------------------------" +
                                                _selecteduser.toString());
                                            log("----selected sub domain----------------------------" +
                                                subDomain.toString());
                                          },
                                        );
                                      },
                                    );
                                  } catch (e) {
                                    throw Exception(e);
                                  }
                                } else {
                                  return Text(snapshot.error.toString());
                                }
                              },
                            ),
                          ),
                          kHeightVeryBigForForm,
                          Padding(
                            padding:
                            const EdgeInsets.only(right: 245.0, bottom: 2),
                            child: Text(
                              "Username",
                              style:
                              TextStyle(fontSize: 18, color: Colors.black),
                            ),
                          ),
                          TextFormField(
                            // The validator receives the text that the user has entered.
                            validator: (newValue) {
                              if (newValue == null || newValue.isEmpty) {
                                return 'Please Enter Your Name';
                              }
                            },
                            cursorColor: Color(0xff3667d4),
                            keyboardType: TextInputType.name,
                            onChanged: (newValue) {
                              username = newValue;
                            },
                            style: TextStyle(color: Colors.grey),
                            decoration: kFormFieldDecoration.copyWith(
                              hintText: "user name",
                              prefixIcon: const Icon(
                                Icons.person_rounded,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                          kHeightVeryBigForForm,
                          Padding(
                            padding:
                            const EdgeInsets.only(right: 245.0, bottom: 2),
                            child: Text(
                              "Password",
                              style:
                              TextStyle(fontSize: 18, color: Colors.black),
                            ),
                          ),
                          TextFormField(
                            // The validator receives the text that the user has entered.
                            validator: (newValue) {
                              if (newValue == null || newValue.isEmpty) {
                                return 'Please Enter Your Password';
                              }
                            },
                            style: TextStyle(color: Colors.grey),
                            obscureText: obsecureTextState,
                            cursorColor: Color(0xff3667d4),
                            onChanged: (newValue) {
                              password = newValue;
                            },
                            decoration: kFormFieldDecoration.copyWith(
                                hintText: "Password",
                                prefixIcon: const Icon(
                                  Icons.lock,
                                  color: Colors.grey,
                                ),
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      if (obsecureTextState != false) {
                                        obsecureTextState = false;
                                        showPasswordIcon = Icons.remove_red_eye;
                                      } else {
                                        obsecureTextState = true;
                                        showPasswordIcon =
                                            Icons.remove_red_eye_outlined;
                                      }
                                    });
                                  },
                                  icon: Icon(
                                    showPasswordIcon,
                                    color: Colors.brown.shade800,
                                  ),
                                )),
                          ),
                        ],
                      ),
                    ),
                    // kHeightSmall,

                    Container(
                      color: Colors.transparent,
                      child: CheckboxListTile(
                        title: Text(
                          "remeber me",
                          style: kTextStyleWhite.copyWith(
                              fontSize: 16.0, color: Colors.black),
                        ),
                        value: checkedValue,
                        onChanged: (newValue) {
                          setState(() {
                            checkedValue = newValue!;
                          });
                        },
                        controlAffinity: ListTileControlAffinity
                            .leading, //  <-- leading Checkbox
                      ),
                    ),
                    // kHeightMedium,
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Color(0xff424143),
                        ),
                        onPressed: () => login(),
                        child: Text(
                          "Login",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                        )),
                    kHeightMedium,
                    kHeightVeryBigForForm,
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> login() async {
String accessToken ;
String userName ;
  SharedPreferences prefs = await SharedPreferences.getInstance();
    var response = await http.post(
      Uri.parse('https://api-vienna.poojanpradhan.com.np/api/v1/user-app/login'),
      body: ({
        'userName': username,
        'password': password,
      }),
    );
log(response.body);
    if (response.statusCode == 200) {
   setState(() {
     accessToken = jsonDecode(response.body)['tokens']['access'];
     userName =  jsonDecode(response.body)['userName'];
  prefs.setString("accessToken", accessToken);
  prefs.setString("userName",userName);
   });
   Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>AuthCheckPage()));

    } else {
    }
  }

}
