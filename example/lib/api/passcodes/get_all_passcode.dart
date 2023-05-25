import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ttlock_flutter_example/api/api_config.dart';

Future<String> getAllPasscode(String lockId) async {
  String url =
      'https://euapi.ttlock.com/v3/lock/listKeyboardPwd?clientId=${APIConfig.clientId}&accessToken=${APIConfig.accessToken}&lockId=$lockId&pageNo=1&pageSize=20&date=${APIConfig.currentTime}';
  final uri = Uri.parse(url);
  var response = await http.get(uri);

  if (response.statusCode == 200) {
    // Request successful
    var responseBody = jsonDecode(response.body);
    return responseBody;
  } else {
    // Request failed
    throw Exception('Request failed with status: ${response.statusCode}');
  }
}
