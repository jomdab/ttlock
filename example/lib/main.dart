import 'package:flutter/material.dart';
import 'package:ttlock_flutter_example/api/locks/get_lock_details.dart';
// import 'home_page.dart';
import 'package:ttlock_flutter_example/phurin/login.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Login(),
    );
  }
}
