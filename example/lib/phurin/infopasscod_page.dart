import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ttlock_flutter_example/api/passcodes/get_all_passcode.dart';

class InfoPasscodPage extends StatefulWidget {
  const InfoPasscodPage(this.title, this.icon,this.infoPassCode, {super.key});
  final String title;
  final Icon icon;
  final dynamic infoPassCode;

  @override
  State<InfoPasscodPage> createState() => _InfoPasscodPageState();
}

class _InfoPasscodPageState extends State<InfoPasscodPage> {
  Widget createDialog(BuildContext ctx) => CupertinoAlertDialog(
        title: Text(
          'Delete?',
          style: TextStyle(color: Colors.black54, fontWeight: FontWeight.w400),
        ),
        actions: [
          CupertinoDialogAction(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.pop(context);
              }),
          CupertinoDialogAction(child: Text('Delete'), onPressed: () {}),
        ],
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color.fromARGB(255, 0, 122, 255),
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
        title: Center(
          child: Text(
            widget.title,
            style: TextStyle(color: Colors.white),
          ),
        ),
        actions: [IconButton(onPressed: () {}, icon: widget.icon)],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(children: [
            CustomInfo('Passcode', widget.infoPassCode['keyboardPwd']),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Divider(height: 0.0, color: Colors.black26),
            ),
            CustomInfo('Name', widget.infoPassCode['keyboardPwdName']??widget.infoPassCode['keyboardPwd']),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Divider(height: 0.0, color: Colors.black45),
            ),
            CustomInfo('Validity Period', numberToPasscodesType[widget.infoPassCode['keyboardPwdType'].toString()]?? ''),
            SizedBox(
              height: 10,
            ),
            CustomIssued('Issued by', widget.infoPassCode['senderUsername']),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Divider(height: 0.0, color: Colors.black26),
            ),
            CustomIssued('Time Issued', widget.infoPassCode['startDate'].toString()),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Divider(height: 0.0, color: Colors.black26),
            ),
            CustomInfo('Issued by', widget.infoPassCode['senderUsername']),
            SizedBox(
              height: 40,
            ),
            GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) => createDialog(context),
                );
              },
              child: Container(
                height: 45,
                decoration: BoxDecoration(color: Colors.white),
                child: Center(
                    child: Text(
                  'Delete',
                  style: TextStyle(fontSize: 16),
                )),
              ),
            )
          ]),
        ),
      ),
    );
  }
}

class CustomInfo extends StatelessWidget {
  final String topic;
  final String title;
  CustomInfo(this.topic, this.title);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      decoration: BoxDecoration(color: Colors.white),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
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
        ],
      ),
    );
  }
}

class CustomIssued extends StatelessWidget {
  final String topic;
  final String title;
  CustomIssued(this.topic, this.title);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      decoration: BoxDecoration(color: Colors.white),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
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
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
