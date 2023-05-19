import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';

Map<String, String> emailToUsernameMap = {};

String generateRandomString() {
  const characters = 'abcdefghijklmnopqrstuvwxyz0123456789';
  final random = Random();
  final charLength = 10; // Adjust the desired length of the random string

  return List.generate(
      charLength, (_) => characters[random.nextInt(characters.length)]).join();
}

String? convertEmailToUsername(String email) {
  if (emailToUsernameMap.containsKey(email)) {
    // If the email is already mapped to a username, return the existing username
    return emailToUsernameMap[email];
  } else {
    // Generate a new random string and map it to the email
    String randomString = generateRandomString();
    emailToUsernameMap[email] = randomString;
    return randomString;
  }
}

String convertPassword(String password) {
  return md5.convert(utf8.encode(password)).toString();
}

void registerToDatabase() {}

class APIConfig {
  static Map<String, String> emailToUsernameMap = {};
  static final currentTime = DateTime.now().millisecondsSinceEpoch;
  static const clientId = 'b30d23fbfbde41d39f1e57386ed26e83';
  static const clientSecret = '6d1f7031348774cb09339bf7662523ca';
  static String username = '';
  static String password = '';
  static String prefix = '';
  static const lockId = '3998042';
}
