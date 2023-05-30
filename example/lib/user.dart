import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ttlock_flutter_example/api/locks/get_lock_list.dart';
import 'package:ttlock_flutter_example/api/oaths/get_access_token.dart';

import 'api/api_config.dart';

class UserCredentials {
  final String email;
  final String password;

  UserCredentials(this.email, this.password);
}

class User {
  static String nickname = '';
  static String mail = '';
  static String phoneNumber = '';
  static String country = '';
  static List locklist = [];

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
          final userCredentials = UserCredentials(username, password);
          if (userMap.values.any((user) =>
              user['email'] == userCredentials.email &&
              convertPassword(userCredentials.password) == user['password'])) {
            // User login successful
            var currentUser = userMap.values.firstWhere(
                (user) =>
                    user['email'] == userCredentials.email &&
                    convertPassword(userCredentials.password) ==
                        user['password'],
                orElse: () => null);
            showMessageDialog(
                context, 'Login Successful', 'User logged in: ${username}');
            User.nickname = userCredentials.email.split('@')[0];
            User.mail = userCredentials.email;
            print('userCredentials.country = ${currentUser['country']}');
            User.country =
                currentUser['country'] == null ? '' : currentUser['country'];
            APIConfig.username = userCredentials.email;
            APIConfig.password = convertPassword(userCredentials.password);
            APIConfig.prefix = currentUser['prefix'];
            APIConfig.accessToken = await getAccessToken();
            print("access Token = ${APIConfig.accessToken}");
            APIConfig.getInfo();
            User.locklist = jsonDecode(await getLockList())['list'];
            return true;
          } else if (userMap.values
              .any((user) => user['email'] != userCredentials.email)) {
            // Login information does not exist
            showMessageDialog(
                context, 'Login Failed', 'Login information does not exist');
            return false;
          } else {
            // Username or password incorrect
            showMessageDialog(
                context, 'Login Failed', 'Username or password incorrect');
            return false;
          }
        } else {
          return false;
        }
      } catch (e) {
        print('Error decoding JSON: $e');
        showMessageDialog(context, 'Error Occurred while logging in',
            'Please try again later.');
        return false;
      }
    } else {
      // Request failed
      throw Exception('Request failed with status: ${response.statusCode}');
    }
  }

  static void showMessageDialog(
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

  static void userLogout() {
    nickname = '';
    mail = '';
    phoneNumber = '';
    country = '';
    APIConfig.username = '';
    APIConfig.password = '';
    APIConfig.accessToken = '';
    APIConfig.prefix = '';
  }
}
