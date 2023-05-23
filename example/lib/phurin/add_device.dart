import 'package:flutter/material.dart';
import 'package:ttlock_flutter_example/phurin/choose_lock.dart';
import 'package:ttlock_flutter_example/phurin/widget/drawer_custom.dart';
import 'package:ttlock_flutter_example/phurin/widget/lock_user.dart';

import 'order_lock.dart';

class AddDevice extends StatefulWidget {
  const AddDevice({super.key});

  @override
  State<AddDevice> createState() => _AddDeviceState();
}

class _AddDeviceState extends State<AddDevice> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool isHavedevice = true;
  @override
  Widget build(BuildContext context) {
    Widget content = Center(
      child: Column(
        children: [
          const SizedBox(height: 90),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ChooseLock()),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                      blurRadius: 10,
                      color: Colors.black54.withOpacity(0.08),
                      spreadRadius: 0.001)
                ],
              ),
              child: CircleAvatar(
                radius: 65,
                backgroundColor: Colors.white,
                child: Icon(
                  Icons.add,
                  size: 50,
                  color: Colors.black54.withOpacity(0.08),
                ),
              ),
            ),
          ),
          const SizedBox(height: 50),
          Text(
            'The Phone needs to be within 2 meters of the Smart Lock',
            style: TextStyle(
              color: Colors.black54.withOpacity(0.4),
            ),
          ),
          Text(
            'during the Pairing process.',
            style: TextStyle(
              color: Colors.black54.withOpacity(0.4),
            ),
          ),
        ],
      ),
    );

    if (isHavedevice == true) {
      content = SingleChildScrollView(
        child: Center(
          child: Column(children: [
            SizedBox(height: 10),
            LockUser(
              'ประตูเลื่อน',
              'Permanent/Admin',
              '50%',
              () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const OrderLock()),
              ),
            ),
            LockUser(
              'BL01_bd3cc1',
              'Permanent/Admin',
              '70%',
              () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const OrderLock()),
              ),
            ),
          ]),
        ),
      );
    }

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color.fromARGB(255, 0, 122, 255),
        leading: IconButton(
          onPressed: () => _scaffoldKey.currentState?.openDrawer(),
          icon: const Icon(
            Icons.menu,
            size: 28,
            color: Colors.white,
            weight: 500,
          ),
        ),
        title: const Center(
          child: Text(
            'TTLock',
            style: TextStyle(color: Colors.white),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.search,
              size: 28,
              color: Colors.white,
              weight: 500,
            ),
          ),
        ],
      ),
      drawer: DrawerCustom(),
      body: content,
    );
  }
}
