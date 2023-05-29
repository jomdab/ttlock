import 'dart:convert';

import 'package:ttlock_flutter_example/api/api_config.dart';
import 'package:http/http.dart' as http;

Future<String> deleteEkey(String keyId) async {
  print('perform delete Ekey');
  var url = Uri.parse('https://euapi.ttlock.com/v3/key/delete');
  var body = {
    'clientId': APIConfig.clientId,
    'accessToken': APIConfig.accessToken,
    'keyId': keyId,
    'date': DateTime.now().millisecondsSinceEpoch.toString(),
  };

  var response = await http.post(url, body: body);

  if (response.statusCode == 200) {
    // Request successful
    var responseBody = jsonDecode(response.body);
    print(responseBody);
    return responseBody['errcode'].toString();
  } else {
    // Request failed
    throw Exception('Request failed with status: ${response.statusCode}');
  }
}
