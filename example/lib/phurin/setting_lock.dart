import 'dart:math';

import 'package:flutter/material.dart';

class SettingLock extends StatefulWidget {
  const SettingLock({super.key});

  @override
  State<SettingLock> createState() => _SettingLockState();
}

class _SettingLockState extends State<SettingLock> {
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
              SizedBox(height: 10),
              CustomSetting('Basics', ''),
              SizedBox(height: 10),
              CustomSetting('Wireless Keypad', ''),
              CustomSetting('Door Sensor', ''),
              SizedBox(height: 10),
              CustomSetting('Remote Unlock', 'Off'),
              CustomSetting('Auto Lock', '5s'),
              CustomSetting('Passage Mode', 'Off'),
              CustomSetting('Lock Sound', 'High'),
              CustomSetting('Tamper Alert', 'Off'),
              CustomSetting('Privacy Lock', 'Off'),
              CustomSetting('Reset Button', 'On'),
              CustomSetting('Lock Clock', ''),
              CustomSetting('Diagosis', ''),
              CustomSetting('Upload Data', ''),
              CustomSetting('Import from another lock', ''),
              CustomSetting('Firmware Update', ''),
              SizedBox(height: 10),
              CustomSetting('Amazon Alexa', ''),
              CustomSetting('Google Home', ''),
              SizedBox(height: 10),
              CustomSettingswitch('Attendance'),
              CustomSettingswitch('Unlock Notication'),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  backgroundColor: Colors.red,
                  fixedSize: const Size(360, 45),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                child: const Text(
                  'Delete',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ),
              SizedBox(height: 30),
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
