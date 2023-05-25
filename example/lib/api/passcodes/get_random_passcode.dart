import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ttlock_flutter_example/api/api_config.dart';

Future<String> getRandomPasscode(String lockId, String passcodeType) async {
  var url = Uri.parse('https://euapi.ttlock.com/v3/lock/delete');

  var body = {
    'clientId': APIConfig.clientId,
    'accessToken': APIConfig.accessToken,
    'lockId': lockId,
    'keyboardPwdType': passcodeType,
    'startDate': APIConfig.currentTime.toString(),
    'date': APIConfig.currentTime.toString(),
  };

  var response = await http.post(url, body: body);

  if (response.statusCode == 200) {
    // Request successful
    var responseBody = jsonDecode(response.body);
    return responseBody['errcode'].toString();
  } else {
    // Request failed
    throw Exception('Request failed with status: ${response.statusCode}');
  }
}
