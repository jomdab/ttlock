import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ttlock_flutter_example/api/api_config.dart';

Future<String> getAccessToken() async {
  var url = Uri.parse('https://euapi.ttlock.com/oauth2/token');

  var body = {
    'client_id': APIConfig.clientId,
    'client_secret': APIConfig.clientSecret,
    'username': APIConfig.prefix,
    'password': APIConfig.password,
  };

  var response = await http.post(url, body: body);

  if (response.statusCode == 200) {
    // Request successful
    var responseBody = jsonDecode(response.body);
    print('accessToken = ${responseBody['access_token']}');
    return responseBody['access_token'];
  } else {
    // Request failed
    throw Exception('Request failed with status: ${response.statusCode}');
  }
}
