import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ttlock_flutter_example/api/api_config.dart';

class User {
  static String nickname = '';
  static String mail = '';
  static String phoneNumber = '';
  static String country = 'Thailand';

  static Future<bool> userLogin(
      BuildContext context, String username, String password) async {
    final url =
        Uri.https('adfd-f155a-default-rtdb.firebaseio.com', "test.json");
    var response = await http.get(url);
    if (response.statusCode == 200) {
      // Request successful
      try {
        if (response.body.isNotEmpty && response.body != null) {
          var userMap = jsonDecode(response.body) as Map<String, dynamic>;
          if (userMap.values.any((user) =>
              user['email'] == username &&
              convertPassword(password) == user['password'])) {
            // User login successful

            _showMessageDialog(
                context, 'Login Successful', 'User logged in: ${username}');
            User.nickname = username.split('@')[0];
            User.mail = username;
            return true;
          } else if (userMap.values.any((user) => user['email'] != username)) {
            // Login information does not exist
            _showMessageDialog(
                context, 'Login Failed', 'Login information does not exist');
            return false;
          } else {
            // Username or password incorrect
            _showMessageDialog(
                context, 'Login Failed', 'Username or password incorrect');
            return false;
          }
        } else {
          return false;
        }
      } catch (e) {
        print('Error decoding JSON: $e');
        _showMessageDialog(
            context, 'Error Occur while login', 'Please try again later.');
        return false;
      }
    } else {
      // Request failed
      throw Exception('Request failed with status: ${response.statusCode}');
    }
  }

  static void _showMessageDialog(
      BuildContext context, String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
