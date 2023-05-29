import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ttlock_flutter_example/api/api_config.dart';

Future<String> getRandomPasscode(
    String lockId, int passcodeType, String startTime, String endTime) async {
  print('Perform get random passcode with type = $passcodeType');
  var url = Uri.parse('https://euapi.ttlock.com/v3/keyboardPwd/get');

  var body = {
    'clientId': APIConfig.clientId,
    'accessToken': APIConfig.accessToken,
    'lockId': lockId,
    'keyboardPwdType': passcodeType.toString(),
    'startDate': startTime,
    'endDate': endTime,
    'date': DateTime.now().millisecondsSinceEpoch.toString(),
  };

  var response = await http.post(url, body: body);

  if (response.statusCode == 200) {
    // Request successful
    var responseBody = jsonDecode(response.body);
    print(responseBody);
    print('keyboardPwd = ${responseBody['keyboardPwd']}');
    return responseBody['keyboardPwd'].toString();
  } else {
    // Request failed
    print(response.statusCode);
    throw Exception('Request failed with status: ${response.statusCode}');
  }
}
