import 'dart:math';
import 'package:bmprogresshud/progresshud.dart';
import 'package:ttlock_flutter_example/scan_page.dart';
import 'package:ttlock_flutter_example/config.dart';

import 'package:flutter/material.dart';
import 'package:ttlock_flutter_example/phurin/widget/lock_item.dart';

class ChooseLock extends StatefulWidget {
  const ChooseLock({super.key});

  @override
  State<ChooseLock> createState() => _ChooseLockState();
}

class _ChooseLockState extends State<ChooseLock> {
  // ignore: unused_field
  BuildContext? _context;

  // void _startScanGateway() {
  //   if (Config.uid == 0 || Config.ttlockLoginPassword.length == 0) {
  //     String text = 'Please config the ttlockUid and the ttlockLoginPassword';
  //     ProgressHud.of(_context!).showAndDismiss(ProgressHudType.error, text);
  //     return;
  //   }
  //   _startScan(ScanType.gateway);
  // }

  void _startScanLock() {
    _startScan(ScanType.lock);
  }

  void _startScan(ScanType scanType) {
    Navigator.push(context,
        new MaterialPageRoute(builder: (BuildContext context) {
      return ScanPage(
        scanType: scanType,
      );
    }));
  }

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
            SizedBox(width: 55),
            Text(
              'Choose Lock Type',
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: _startScanLock,
              child: SizedBox(
                height: 110,
                width: 400,
                child: Card(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Row(children: [
                    Expanded(
                      flex: 1,
                      child: Row(
                        children: [
                          Image.asset(
                            'assets/image/alllock.png',
                            width: 80,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 15, top: 35),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('All Locks',
                                    style: TextStyle(fontSize: 15)),
                                Text('Scan all types of locks',
                                    style: TextStyle(
                                        color:
                                            Colors.black54.withOpacity(0.4))),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Transform(
                        transform: Matrix4.rotationY(pi),
                        alignment: Alignment.center,
                        child: Icon(
                          Icons.arrow_back_ios_new,
                          size: 20,
                          color: Colors.black54.withOpacity(0.4),
                        ))
                  ]),
                ),
              ),
            ),
            Row(
              children: const [
                LockItem(
                    title: 'Door Lock', image: 'assets/image/doorlock.png'),
                LockItem(title: 'Padlock', image: 'assets/image/padlock.png'),
              ],
            ),
            Row(
              children: const [
                LockItem(
                    title: 'Safe Lock', image: 'assets/image/safelock.png'),
                LockItem(
                    title: 'Lock Cylindar',
                    image: 'assets/image/lockcylinder.png'),
              ],
            ),
            Row(
              children: const [
                LockItem(
                    title: 'Parking Lock',
                    image: 'assets/image/parkinglock.png'),
                LockItem(
                    title: 'Bicycle Lock',
                    image: 'assets/image/bicyclelock.png'),
              ],
            ),
            const LockItem(title: 'Remote ', image: 'assets/image/remote.png'),
          ],
        ),
      ),
    );
  }
}
