import 'package:flutter/material.dart';
import 'home_page.dart';
import 'package:ttlock_flutter_example/phurin/login.dart';
import 'package:ttlock_flutter/ttlock.dart';

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
