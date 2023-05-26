import 'package:flutter/material.dart';
import 'package:ttlock_flutter/ttlock.dart';
import 'package:bmprogresshud/progresshud.dart';
import 'package:ttlock_flutter_example/api/locks/delete_lock.dart';
import 'package:ttlock_flutter_example/phurin/add_device.dart';
import 'package:ttlock_flutter_example/phurin/oder_press.dart';
import 'package:ttlock_flutter_example/phurin/setting_lock.dart';

class OrderLock extends StatefulWidget {
  const OrderLock({super.key, required this.lockData, required this.lockId});
  final String lockData;
  final String lockId;

  @override
  State<OrderLock> createState() => _OrderLockState(lockData);
}

class _OrderLockState extends State<OrderLock> {
  bool isLoading = false;
  BuildContext? _context;
  String lockData = '';
  String lockId = '';

  _OrderLockState(String lockData) {
    super.initState();
    this.lockData = lockData;
    this.lockId = lockId;
  }

  void _showSuccessAndDismiss(String text) {
    ProgressHud.of(_context!).showSuccessAndDismiss(text: text);
  }

  void _showErrorAndDismiss(TTLockError errorCode, String errorMsg) {
    ProgressHud.of(_context!).showErrorAndDismiss(
        text: 'errorCode:$errorCode errorMessage:$errorMsg');
  }

  @override
  Widget build(BuildContext context) {
    _context = context;
    return const Text('ok');
  }
}

class OrderItem extends StatelessWidget {
  const OrderItem(this.image, this.title, this.onTaps, {super.key});
  final String image;
  final String title;
  final Function onTaps;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTaps();
      },
      child: Container(
        height: 85,
        width: 80,
        // decoration: BoxDecoration(color: Color.fromARGB(255, 219, 190, 23)),
        margin: EdgeInsets.all(5),
        child: SizedBox(
          child: Column(children: [
            Image.asset(image, width: 50),
            Text(
              title,
              maxLines: 2,
              textAlign: TextAlign.center,
            ),
          ]),
        ),
      ),
    );
  }
}
