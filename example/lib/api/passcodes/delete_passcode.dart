import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ttlock_flutter_example/api/api_config.dart';

Future<String> deletePasscode(String lockId, String deleteType) async {
  var url = Uri.parse('https://euapi.ttlock.com/v3/keyboardPwd/delete');

  var body = {
    'clientId': APIConfig.clientId,
    'accessToken': APIConfig.clientSecret,
    'lockId': lockId,
    'keyboardPwdId': APIConfig.password,
    'deleteType': deleteType,
    'date': APIConfig.currentTime,
  };

  var response = await http.post(url, body: body);

  if (response.statusCode == 200) {
    // Request successful
    var responseBody = jsonDecode(response.body);
    return responseBody;
  } else {
    // Request failed
    throw Exception('Request failed with status: ${response.statusCode}');
  }
}
