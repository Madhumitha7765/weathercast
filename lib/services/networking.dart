// ignore_for_file: unused_local_variable, avoid_print

import 'package:http/http.dart' as http;
import 'dart:convert';

class NetworkHelper {
  NetworkHelper(this.url);

  late final String url;

  Future getData() async {
    var weatherURL = Uri.parse(url);
    http.Response response = await http.get(weatherURL);
    if (response.statusCode == 200) {
      String data = response.body;
      // print(data);
      var decodedData = jsonDecode(data);
      return decodedData;
    } else {
      print(response.statusCode);
    }
  }
}
