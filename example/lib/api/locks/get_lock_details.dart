import 'package:ttlock_flutter_example/api/api_config.dart';
import 'package:http/http.dart' as http;

Future<String> getLockDetails(String lockID) async {
  print('performing get_lock_detail');
  String url =
      'https://euapi.ttlock.com/v3/lock/detail?clientId=${APIConfig.clientId}&accessToken=${APIConfig.accessToken}&lockId=$lockID&date=${APIConfig.currentTime}';
  final uri = Uri.parse(url);
  var res = await http.get(uri);
  if (res.statusCode != 200)
    throw Exception('http.get error: statusCode= ${res.statusCode}');
  else {
    print(res.body);
    return res.body;
  }
}
