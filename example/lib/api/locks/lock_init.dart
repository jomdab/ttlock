import 'dart:convert';

import 'package:ttlock_flutter_example/api/api_config.dart';
import 'package:http/http.dart' as http;
import 'package:ttlock_flutter_example/api/locks/get_lock_list.dart';
import 'package:ttlock_flutter_example/user.dart';

Future<String> lockInit(String lockData) async {
  var url = Uri.parse('https://euapi.ttlock.com/v3/lock/initialize');
  var body = {
    'clientId': APIConfig.clientId,
    'accessToken': APIConfig.accessToken,
    'lockData': lockData,
    'date': APIConfig.currentTime.toString(),
  };

  var res = await http.post(url, body: body);
  if (res.statusCode != 200)
    throw Exception('http.get error: statusCode5= ${res.statusCode}');
  else {
    print(res.body);
    User.locklist = jsonDecode(await getLockList())['list'];
    return res.body;
  }
}
