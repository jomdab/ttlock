import 'package:flutter/material.dart';
import 'package:ttlock_flutter_example/api/users/user_register.dart';
import 'package:ttlock_flutter_example/phurin/add_device.dart';
import 'package:ttlock_flutter_example/user.dart';

class PoclicyDialog extends StatefulWidget {
  final String username;
  final String password;
  final bool islogin;
  const PoclicyDialog(
      {super.key,
      required this.username,
      required this.password,
      required this.islogin});

  @override
  State<PoclicyDialog> createState() => _PoclicyDialogState();
}

class _PoclicyDialogState extends State<PoclicyDialog> {
  Future<void> _checkAction() async {
    if (widget.islogin) {
      await User.userLogin(context, widget.username, widget.password);
    } else {
      bool success = await userRegister(widget.username, widget.password);
      await Future.delayed(Duration(seconds: 1));
      if (success) {
        print(widget.username);
        print(widget.password);
        bool ok =
            await User.userLogin(context, widget.username, widget.password);
        print(ok);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6),
      ),
      title: Column(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Please read and agree with'),
              Text('these terms'),
            ],
          ),
        ],
      ),
      content: SizedBox(
        height: 145,
        child: Column(
          children: [
            GestureDetector(
              child: const Text(
                'Use Terms',
                style: TextStyle(
                    color: Color.fromARGB(255, 0, 122, 255),
                    fontWeight: FontWeight.w600),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            GestureDetector(
              child: const Text(
                ' Privacy Policy',
                style: TextStyle(
                    color: Color.fromARGB(255, 0, 122, 255),
                    fontWeight: FontWeight.w600),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            ElevatedButton(
              onPressed: () async {
                await _checkAction();
                await Future.delayed(Duration(seconds: 3));
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AddDevice()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 0, 122, 255),
                fixedSize: const Size(220, 45),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
              child: Text(
                'Agree',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
            ),
            const SizedBox(
              height: 13,
            ),
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Text(
                ' Don\'t agree',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 13,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}