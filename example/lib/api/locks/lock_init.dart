import 'package:ttlock_flutter_example/api/api_config.dart';
import 'package:http/http.dart' as http;

Future<String> lockInit(String lockData) async {
  var url = Uri.parse('https://euapi.ttlock.com/v3/lock/initialize');

  var body = {
    'client_id': APIConfig.clientId,
    'accessToken': APIConfig.clientSecret,
    'lockData': lockData,
    'date': APIConfig.currentTime,
  };

  var res = await http.post(url, body: body);
  if (res.statusCode != 200)
    throw Exception('http.get error: statusCode= ${res.statusCode}');
  else {
    print(res.body);
    return res.body;
  }
}
