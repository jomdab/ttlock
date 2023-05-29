import 'dart:convert';

import 'package:ttlock_flutter_example/api/api_config.dart';
import 'package:http/http.dart' as http;

Future<String> changePasscode(String lockId, String passcodeId) async {
  var url = 'https://euapi.ttlock.com/v3/keyboardPwd/change';
  var uri = Uri.parse(url);
  var body = {
    'clientId': APIConfig.clientId,
    'accessToken': APIConfig.accessToken,
    'lockId': lockId,
    'keyboardPwdId': passcodeId,
    'date': DateTime.now().millisecondsSinceEpoch.toString(),
  };

  var response = await http.post(uri, body: body);

  if (response.statusCode == 200) {
    // Request successful
    var responseBody = jsonDecode(response.body);
    return responseBody;
  } else {
    // Request failed
    throw Exception('Request failed with status: ${response.statusCode}');
  }
}
