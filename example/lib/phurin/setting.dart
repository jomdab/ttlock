import 'dart:math';

import 'package:flutter/material.dart';

import '../user.dart';
import 'login.dart';

class Setting extends StatefulWidget {
  const Setting({super.key});

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
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
            SizedBox(width: 85),
            Text(
              'Settings',
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              CustomSettingswitch(
                'Sound',
              ),
              CustomSettingswitch(
                'Touch to Unlock',
              ),
              CustomSettingswitch(
                'Notification push',
              ),
              SizedBox(height: 10),
              CustomSetting('Lock Users', ''),
              CustomSetting('Authorized Admin', ''),
              CustomSetting('Lock Group', ''),
              CustomSetting('Transfer Lock', ''),
              CustomSetting('Transfer Gateway', ''),
              SizedBox(
                height: 10,
              ),
              CustomSetting('Languages', 'Auto'),
              CustomSetting('Screen Lock', 'Off'),
              CustomSetting('Hide invalid access', 'Off'),
              CustomSetting('Locks requiring phone online', ''),
              CustomSetting('Services', ''),
              SizedBox(height: 10),
              CustomSetting('About', ''),
              SizedBox(height: 30),
              TextButton(
                onPressed: () {
                  User.userLogout();
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => Login()),
                    (route) => false,
                  );
                },
                child: Container(
                  height: 45,
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: const Color.fromARGB(255, 0, 122, 255),
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                  child: Center(
                      child: Text(
                    'Logout',
                    style: TextStyle(fontSize: 16),
                  )),
                ),
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  'Delete Account',
                  style: TextStyle(color: Colors.grey),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class CustomSetting extends StatelessWidget {
  final String topic;
  final String title;
  CustomSetting(this.topic, this.title);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.white),
      child: Column(
        children: [
          Padding(
            padding:
                const EdgeInsets.only(left: 20, bottom: 5, right: 10, top: 7),
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
          ),
          Divider(),
        ],
      ),
    );
  }
}

class CustomSettingswitch extends StatelessWidget {
  final String topic;

  CustomSettingswitch(
    this.topic,
  );
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.white),
      child: Column(
        children: [
          Padding(
            padding:
                const EdgeInsets.only(left: 20, bottom: 0, right: 10, top: 0),
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Text(
                    topic,
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                SwitchExample()
              ],
            ),
          ),
          Divider(),
        ],
      ),
    );
  }
}

class SwitchExample extends StatefulWidget {
  const SwitchExample({super.key});

  @override
  State<SwitchExample> createState() => _SwitchExampleState();
}

class _SwitchExampleState extends State<SwitchExample> {
  bool light = true;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 35,
      child: Switch(
        // This bool value toggles the switch.
        value: light,
        onChanged: (bool value) {
          // This is called when the user toggles the switch.
          setState(() {
            light = value;
          });
        },
      ),
    );
  }
}
