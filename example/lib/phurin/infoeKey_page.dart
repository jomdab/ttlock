import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ttlock_flutter_example/api/ekeys/delete_ekey.dart';

class InfoeKeyPage extends StatefulWidget {
  const InfoeKeyPage(this.title, this.infoEkey, {super.key});
  final String title;
  final dynamic infoEkey;

  @override
  State<InfoeKeyPage> createState() => _InfoeKeyPageState();
}

class _InfoeKeyPageState extends State<InfoeKeyPage> {
  Widget createDialog(BuildContext ctx) => CupertinoAlertDialog(
        title: Text(
          'The eKey will be DELETED when the User\'s APP connents to a Network',
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w400),
        ),
        actions: [
          CupertinoDialogAction(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.pop(context);
              }),
          CupertinoDialogAction(
              child: Text('Delete'),
              onPressed: () {
                deleteEkey(widget.infoEkey['keyId']);
                Navigator.pop(context);
              }),
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
        actions: [
          PopupMenuButton(
            itemBuilder: (context) => [
              PopupMenuItem(value: 1, child: Text("Freeze")),
              PopupMenuItem(value: 2, child: Text("De-Authorize"))
            ],
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(children: [
            CustomInfo('Name', widget.infoEkey['keyName']), // edit name
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Divider(height: 0.0, color: Colors.black26),
            ),
            CustomInfo('Validity Period', 'Validity Period'),
            SizedBox(
              height: 10,
            ),
            CustomIssued(
                'Receiving Period', widget.infoEkey['username']), //edit mail
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Divider(height: 0.0, color: Colors.black26),
            ),
            CustomIssued('Issued by', widget.infoEkey['senderUsername']),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Divider(height: 0.0, color: Colors.black26),
            ),
            CustomIssued(
                'Time Issued',
                DateTime.fromMicrosecondsSinceEpoch(
                        widget.infoEkey['startDate'])
                    .toString()),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Divider(height: 0.0, color: Colors.black26),
            ),
            CustomInfo('Records by', ''),
            SizedBox(
              height: 40,
            ),
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) => createDialog(context),
                );
              },
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
