import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ttlock_flutter_example/api/api_config.dart';

Future<String> getAllPasscode(String lockId) async {
  String url =
      'https://euapi.ttlock.com/v3/lock/listKeyboardPwd?clientId=${APIConfig.clientId}&accessToken=${APIConfig.accessToken}&lockId=$lockId&pageNo=1&pageSize=20&date=${DateTime.now().millisecondsSinceEpoch}';
  final uri = Uri.parse(url);
  var response = await http.get(uri);

  if (response.statusCode == 200) {
    // Request successful
    return response.body;
  } else {
    // Request failed
    throw Exception('Request failed with status: ${response.statusCode}');
  }
}

Map<String, String> numberToPasscodesType = {
  '1': 'One-time',
  '2': 'Permanent',
  '3': 'Period',
  '4': 'delete',
  '5': 'Weekend Cyclic',
  '6': 'Daily Cyclic',
  '7': 'Workday Cyclic',
  '8': 'Monday Cyclic',
  '9': 'Tuesday Cyclic',
  '10': 'Wednesday Cyclic',
  '11': 'Thursday Cyclic',
  '12': 'Friday Cyclic',
  '13': 'Saturday Cyclic',
  '14': 'Sunday Cyclic',
};
