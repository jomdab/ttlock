import 'package:http/http.dart' as http;
import 'package:ttlock_flutter_example/api/api_config.dart';

Future<String> getUsersList() async {
// Use the generated timestamp in the API request URL
  String url =
      'https://euapi.ttlock.com/v3/user/list?clientId=${APIConfig.clientId}&clientSecret=${APIConfig.clientSecret}&date=${APIConfig.currentTime}&pageNo=1&pageSize=20';
  final uri = Uri.parse(url);
  var res = await http.get(uri);
  if (res.statusCode != 200)
    throw Exception('http.get error: statusCode= ${res.statusCode}');
  else {
    print(res.body);
    return res.body;
  }
}
