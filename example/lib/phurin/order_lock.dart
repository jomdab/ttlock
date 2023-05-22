import 'package:flutter/material.dart';
import 'package:ttlock_flutter/ttlock.dart';
import 'package:bmprogresshud/progresshud.dart';

class OrderLock extends StatefulWidget {
  const OrderLock({
    super.key,required this.lockData
  });
  final String lockData;

  @override
  State<OrderLock> createState() => _OrderLockState(lockData);
}

class _OrderLockState extends State<OrderLock> {
  bool isLoading = false;
  BuildContext? _context;
  String lockData = '';

  _OrderLockState(String lockData) {
    super.initState();
    this.lockData = lockData;
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
              'TTlock',
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.wifi_off),
          )
        ],
      ),
      body: Center(
        child: Column(children: [
          SizedBox(
            height: 20,
          ),
          Text('Register_lock',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
          SizedBox(
            height: 50,
          ),
          Transform.scale(
            scale: 4,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  isLoading = !isLoading;
                  TTLock.controlLock(lockData, TTControlAction.unlock,
                      (lockTime, electricQuantity, uniqueId) {
                    _showSuccessAndDismiss(
                        "Unlock Success lockTime:$lockTime electricQuantity:$electricQuantity uniqueId:$uniqueId");
                  }, (errorCode, errorMsg) {
                    _showErrorAndDismiss(errorCode, errorMsg);
                  });
                });
              },
              child: SizedBox(
                width: 100,
                height: 100,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.grey.shade100,
                      child: Image.asset(
                        // you can replace this with Image.asset
                        'assets/image/lockLogo.png',
                        fit: BoxFit.cover,
                        height: 27,
                        width: 27,
                      ),
                    ),
                    // you can replace
                    isLoading
                        ? CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                                Colors.blue.shade600),
                            strokeWidth: 2,
                            backgroundColor: Colors.blue.withOpacity(0.4),
                          )
                        : CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                                Colors.blue.shade600.withOpacity(0)),
                            strokeWidth: 2,
                            backgroundColor: Colors.blue.withOpacity(0.4),
                          ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 45,
          ),
          Text(
            'Touch to Unlock, Hold to Lock',
            style: TextStyle(color: Colors.grey, fontSize: 17),
          ),
          SizedBox(
            height: 15,
          ),
          Divider(),
          Row(
            children: [
              SizedBox(width: 15),
              OderItem('assets/image/ekey.png', 'eKeys', () {
                print('555');
              }),
              OderItem('assets/image/passcode.png', 'Passcodes', () {}),
              OderItem('assets/image/card.png', 'Cards', () {}),
              OderItem('assets/image/finger.png', 'Fingerprints', () {}),
            ],
          ),
          Row(
            children: [
              SizedBox(width: 15),
              OderItem('assets/image/remoteicon.png', 'eKeys', () {
                print('555');
              }),
              OderItem('assets/image/authorized.png', 'Passcodes', () {}),
              OderItem('assets/image/records.png', 'Cards', () {}),
              OderItem('assets/image/setting.png', 'Fingerprints', () {}),
            ],
          ),
        ]),
      ),
    );
  }
}

class OderItem extends StatelessWidget {
  const OderItem(this.image, this.title, this.onTaps, {super.key});
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
        // decoration: BoxDecoration(color: Color.fromARGB(255, 219, 190, 23)),
        margin: EdgeInsets.all(13),
        child: SizedBox(
          child: Column(children: [
            Image.asset(image, width: 60),
            Text(title),
          ]),
        ),
      ),
    );
  }
}
