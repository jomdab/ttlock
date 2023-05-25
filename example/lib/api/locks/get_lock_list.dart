import 'package:ttlock_flutter_example/api/api_config.dart';
import 'package:http/http.dart' as http;

Future<String> getLockList() async {
  print('performing get_lock_detail');
  print(APIConfig.accessToken);
  String url =
      'https://euapi.ttlock.com/v3/lock/list?clientId=${APIConfig.clientId}&accessToken=${APIConfig.accessToken}&pageNo=1&pageSize=20&date=${APIConfig.currentTime}';
  final uri = Uri.parse(url);
  var res = await http.get(uri);
  if (res.statusCode != 200)
    throw Exception('http.get error: statusCode= ${res.statusCode}');
  else {
    print(res.body);
    return res.body;
  }
}
