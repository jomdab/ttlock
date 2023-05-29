import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ttlock_flutter_example/api/api_config.dart';
import 'package:ttlock_flutter_example/lock_page.dart';

Future<String> addCustomPasscode(
    String lockId, String passcodeType, String endDate) async {
  var url = Uri.parse('https://euapi.ttlock.com/v3/lock/delete');

  var body = {
    'clientId': APIConfig.clientId,
    'accessToken': APIConfig.accessToken,
    'lockId': lockId,
    'keyboardPwdType': passcodeType,
    'startDate': DateTime.now().millisecond.toString(),
    'endDate': endDate,
    'date': DateTime.now().millisecondsSinceEpoch.toString(),
  };

  var response = await http.post(url, body: body);

  if (response.statusCode == 200) {
    // Request successful
    var responseBody = jsonDecode(response.body);
    return responseBody['keyboardPwdId'].toString();
  } else {
    // Request failed
    throw Exception('Request failed with status: ${response.statusCode}');
  }
}
