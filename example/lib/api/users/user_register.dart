import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ttlock_flutter_example/api/api_config.dart';

Future<String> UserRegister(String username, String password) async {
  var randomString = convertEmailToUsername(username);
  var md5password = convertPassword(password);
  var url = Uri.parse(
      'https://euapi.ttlock.com/v3/user/register?clientId=${APIConfig.clientId}&clientSecret=${APIConfig.clientSecret}&username=$randomString&password=$md5password&date=${APIConfig.currentTime}');
  var body = {
    'client_id': APIConfig.clientId,
    'client_secret': APIConfig.clientSecret,
    'username': randomString,
    'password': md5password,
    'date': APIConfig.currentTime,
  };

  var response = await http.post(url, body: body);

  if (response.statusCode == 200) {
    // Request successful
    var responseBody = jsonDecode(response.body);
    return responseBody['username'];
  } else {
    // Request failed
    throw Exception('Request failed with status: ${response.statusCode}');
  }
}
