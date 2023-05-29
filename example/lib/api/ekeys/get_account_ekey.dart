import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ttlock_flutter_example/api/api_config.dart';

Future<List> getAccountEkey() async {
  String url =
      'https://euapi.ttlock.com/v3/lock/list?clientId=${APIConfig.clientId}&accessToken=${APIConfig.accessToken}&pageNo=1&pageSize=20&date=${DateTime.now().millisecondsSinceEpoch}';
  final uri = Uri.parse(url);
  var response = await http.post(uri);

  if (response.statusCode == 200) {
    // Request successful
    var responseBody = jsonDecode(response.body);
    print('message = $responseBody');
    return responseBody['list'];
  } else {
    // Request failed
    throw Exception('Request failed with status: ${response.statusCode}');
  }
}
