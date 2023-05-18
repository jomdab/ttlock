import 'package:flutter/material.dart';

class OrderLock extends StatefulWidget {
  const OrderLock({super.key});

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
        title: Row(
          children: const [
            SizedBox(width: 85),
            Text(
              'TTlock',
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
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
              OderItem('assets/image/ekey.png', 'eKeys', (){print('555');}),
              OderItem('assets/image/ekey.png', 'Passcodes', (){}),
              OderItem('assets/image/ekey.png', 'Cards', (){}),
              OderItem('assets/image/ekey.png', 'Fingerprints', (){}),
            ],
          ),
        ]),
      ),
    );
  }
}

class OderItem extends StatelessWidget {
  const OderItem(this.image, this.title, this.onTap,{super.key});
  final String image;
  final String title;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap,
      child: SizedBox(
        child: Column(children: [
          Image.asset(image,width: 70),
          Text(title),
        ]),
      ),
    );
  }
}
