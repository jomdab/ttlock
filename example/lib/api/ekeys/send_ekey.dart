import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ttlock_flutter_example/api/api_config.dart';

Future<String> sendEkey(String lockId, String username, String keyname,
    String startDate, String endDate) async {
  var url = Uri.parse('https://euapi.ttlock.com/v3/key/send');

  var body = {
    'clientId': APIConfig.clientId,
    'accessToken': APIConfig.accessToken,
    'lockId': lockId,
    'receiverUsername': username,
    'keyName': keyname,
    'startDate': startDate,
    'endDate': endDate,
    'date': DateTime.now().millisecondsSinceEpoch.toString(),
  };

  var response = await http.post(url, body: body);

  if (response.statusCode == 200) {
    // Request successful
    var responseBody = jsonDecode(response.body);
    return responseBody['keyId'].toString();
  } else {
    // Request failed
    throw Exception('Request failed with status: ${response.statusCode}');
  }
}
