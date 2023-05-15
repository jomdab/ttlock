import 'dart:math';

import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 0, 122, 255),
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            size: 28,
            color: Colors.white,
            weight: 500,
          ),
        ),
        title: Row(
          children: const [
            SizedBox(width: 75),
            Text(
              'Account info',
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding:
                const EdgeInsets.only(left: 20, bottom: 5, right: 10, top: 15),
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Text(
                    'Avatar',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                Row(
                  children: [
                    CircleAvatar(
                      foregroundImage:
                          AssetImage('assets/image/ttlockLogo.png'),
                      radius: 29.0,
                      backgroundColor: Color.fromARGB(255, 213, 236, 246),
                    ),
                    SizedBox(width: 15),
                    Transform(
                      transform: Matrix4.rotationY(pi),
                      alignment: Alignment.center,
                      child: Icon(
                        Icons.arrow_back_ios_new,
                        size: 20,
                        color: Colors.black54.withOpacity(0.4),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Divider(),
          CustomProfile('Nickname', 'Register'),
          Divider(),
          CustomProfile('Account', 'Register@gmail.com'),
          Divider(),
          CustomProfile('Phone', ''),
          Divider(),
          CustomProfile('Reset Password', ''),
          Divider(),
          CustomProfile('Security Question', ''),
          Divider(),
          CustomProfile('Country/Region', 'Thailand'),
          Divider(),
        ],
      ),
    );
  }
}

class CustomProfile extends StatelessWidget {
  final String topic;
  final String title;
  CustomProfile(this.topic, this.title);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, bottom: 5, right: 10, top: 10),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Text(
              topic,
              style: TextStyle(fontSize: 16),
            ),
          ),
          Row(
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black54.withOpacity(0.4),
                ),
              ),
              SizedBox(width: 7),
              Transform(
                transform: Matrix4.rotationY(pi),
                alignment: Alignment.center,
                child: Icon(
                  Icons.arrow_back_ios_new,
                  size: 20,
                  color: Colors.black54.withOpacity(0.4),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
