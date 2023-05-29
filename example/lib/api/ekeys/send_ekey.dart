import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ttlock_flutter_example/api/api_config.dart';

Future<String?> sendEkey(String lockId, String username, String keyname,
    String startDate, String endDate) async {
  print('perform send ekey');

  var databaseuri =
      Uri.https('adfd-f155a-default-rtdb.firebaseio.com', "test.json");
  Map<String, dynamic> userList =
      jsonDecode((await http.get(databaseuri)).body);
  var selectedUser;
  bool success = false;
  try {
    selectedUser = userList.entries
        .toList()
        .firstWhere((element) => element.value['email'] == username);
    print(selectedUser);
    success = true;
  } catch (err) {
    success = false;
    print(err);
  }
  if (success) {
    String prefix = selectedUser.value['prefix'];
    var url = Uri.parse('https://euapi.ttlock.com/v3/key/send');

    var body = {
      'clientId': APIConfig.clientId,
      'accessToken': APIConfig.accessToken,
      'lockId': lockId,
      'receiverUsername': prefix,
      'keyName': keyname,
      'startDate': startDate,
      'endDate': endDate,
      'date': DateTime.now().millisecondsSinceEpoch.toString(),
    };

    var response = await http.post(url, body: body);

    if (response.statusCode == 200) {
      // Request successful
      var responseBody = jsonDecode(response.body);
      print(responseBody);
      print(responseBody['keyId']);
      return responseBody['keyId'].toString();
    } else {
      // Request failed
      throw Exception('Request failed with status: ${response.statusCode}');
    }
  } else {
    print('No User with that name');
    return null;
  }
}
