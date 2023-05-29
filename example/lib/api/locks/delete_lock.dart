import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ttlock_flutter_example/api/api_config.dart';
import 'package:ttlock_flutter_example/api/locks/get_lock_list.dart';
import 'package:ttlock_flutter_example/user.dart';

Future<String> deleteLock(String lockId) async {
  print('perform delete lock');
  var url = Uri.parse('https://euapi.ttlock.com/v3/lock/delete');

  var body = {
    'clientId': APIConfig.clientId,
    'accessToken': APIConfig.accessToken,
    'lockId': lockId,
    'date': APIConfig.currentTime.toString(),
  };

  var response = await http.post(url, body: body);

  User.locklist = jsonDecode(await getLockList())['list'];
  print('User list now =${User.locklist}');

  if (response.statusCode == 200) {
    // Request successful
    var responseBody = jsonDecode(response.body);
    return responseBody['errcode'].toString();
  } else {
    // Request failed
    throw Exception('Request failed with status: ${response.statusCode}');
  }
}
