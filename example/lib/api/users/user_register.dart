import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ttlock_flutter_example/api/api_config.dart';

Future<bool> userRegister(String username, String password) async {
  var randomString = convertEmailToUsername(username);
  var md5password = convertPassword(password);
  var url = Uri.parse(
      'https://euapi.ttlock.com/v3/user/register?clientId=${APIConfig.clientId}&clientSecret=${APIConfig.clientSecret}&username=$randomString&password=$md5password&date=${APIConfig.currentTime}');

  var response = await http.post(url);

  if (response.statusCode == 200) {
    // Request successful
    var responseBody = jsonDecode(response.body);
    print(response.body);
    _addUserToDatabase(username, password, responseBody['username']);
    return true;
  } else {
    // Request failed
    print(Exception('Request failed with status: ${response.statusCode}'));
    return false;
  }
}

void _addUserToDatabase(String username, String password, String prefix) async {
  final url = Uri.https('adfd-f155a-default-rtdb.firebaseio.com', "test.json");
  var response = await http.post(url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'email': username,
        'password': convertPassword(password),
        'prefix': prefix,
        'nickname': null,
        'phone': null,
      }));
  if (response.statusCode == 200) {
    // Request successful
    var responseBody = jsonDecode(response.body);
    print(response.body);
  } else {
    // Request failed
    throw Exception('Request failed with status: ${response.statusCode}');
  }
}
