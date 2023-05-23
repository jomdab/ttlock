import 'package:flutter/material.dart';
import 'package:ttlock_flutter_example/phurin/oder_press.dart';
import 'package:ttlock_flutter_example/phurin/setting_lock.dart';

class OrderLock extends StatefulWidget {
  const OrderLock(this.lockname,{super.key,});
  final String lockname;

  @override
  State<OrderLock> createState() => _OrderLockState();
}

class _OrderLockState extends State<OrderLock> {
  bool isLoading = false;

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
        title: Center(
          child: Text(
            'TTlock',
            style: TextStyle(color: Colors.white),
          ),
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
          Text(widget.lockname,
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
              SizedBox(width: 18),
              OderItem('assets/image/ekey.png', 'eKeys', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const OderPress('eKeys', 'Send eKey')),
                );
                print('555');
              }),
              OderItem('assets/image/passcode.png', 'Passcodes', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const OderPress('Passcodes', 'Add Card')),
                );
              }),
              OderItem('assets/image/card.png', 'Cards', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const OderPress('Cards', 'Generate Passcode')),
                );
              }),
              OderItem('assets/image/finger.png', 'Fingerprints', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const OderPress('Fingerprint', 'Add Fingerprint')),
                );
              }),
            ],
          ),
          Row(
            children: [
              SizedBox(width: 18),
              OderItem('assets/image/remoteicon.png', 'Remote', () {
                 Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const OderPress('Remote', 'Add Remote')),
                );
              }),
              OderItem('assets/image/authorized.png', 'Authorized Admin', () {
                 Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const OderPress('Authorized Admin', 'Create Admin')),
                );
              }),
              OderItem('assets/image/records.png', 'Records', () {}),
              OderItem('assets/image/setting.png', 'Settings', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SettingLock()),
                );
              }),
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
        height: 85,
        width: 80,
        // decoration: BoxDecoration(color: Color.fromARGB(255, 219, 190, 23)),
        margin: EdgeInsets.all(5),
        child: SizedBox(
          child: Column(children: [
            Image.asset(image, width: 50),
            Text(title,maxLines: 2,textAlign: TextAlign.center,),
          ]),
        ),
      ),
    );
  }
}
