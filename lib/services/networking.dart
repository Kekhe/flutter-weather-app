import 'package:http/http.dart' as http;
import 'dart:convert';

class NetworkHelper {
  NetworkHelper(this.url);
  final String url;
  getData() async {
    Uri uri = Uri.parse(url);
    //'https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=$apiKey''https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=$apiKey'
    http.Response response = await http.get(uri);

    String data = response.body;
    return jsonDecode(data);
  }
}