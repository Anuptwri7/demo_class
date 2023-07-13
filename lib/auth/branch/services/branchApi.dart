import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;

import '../../../constants/apiConstant.dart';
import '../model/branchModel.dart';

Future fetchBranchFromUrl() async {
  // HttpClient client = new HttpClient();
  // client.badCertificateCallback = ((X509Certificate cert, String host, int port) => true);
  // log(sharedPreferences.getString("access_token"));
  final response = await http.get(Uri.parse(StringConst.branchUrl),
      headers: {
    'Content-type': 'application/json',
    'Accept': 'application/json',

  });
  log("==============" + response.body);
  log("==============" + response.statusCode.toString());

  List<Result> respond = [];

  final responseData = json.decode(response.body);
  responseData['results'].forEach(
    (element) {
      respond.add(
        Result.fromJson(element),
      );
    },
  );
  if (response.statusCode == 200) {
    return respond;
  }
}
