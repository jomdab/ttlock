import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ttlock_flutter_example/api/api_config.dart';

Future<List> getLockEkey(String lockId) async {
  String url =
      'https://euapi.ttlock.com/v3/lock/listKey?clientId=${APIConfig.clientId}&accessToken=${APIConfig.accessToken}&lockId=$lockId&pageNo=1&pageSize=20&date=${DateTime.now().millisecondsSinceEpoch}';
  final uri = Uri.parse(url);
  var response = await http.get(uri);

  if (response.statusCode == 200) {
    // Request successful
    var responseBody = jsonDecode(response.body);
    print(responseBody);
    return responseBody['list'] ?? [];
  } else {
    // Request failed
    throw Exception('Request failed with status: ${response.statusCode}');
  }
}
