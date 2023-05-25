import 'package:flutter/material.dart';
import 'package:ttlock_flutter_example/lock_page.dart';
import 'package:ttlock_flutter_example/phurin/choose_lock.dart';
import 'package:ttlock_flutter_example/phurin/widget/drawer_custom.dart';
import 'package:ttlock_flutter_example/phurin/widget/lock_user.dart';
import 'package:ttlock_flutter_example/user.dart';

import 'order_lock.dart';

class AddDevice extends StatefulWidget {
  const AddDevice({super.key});

  @override
  State<AddDevice> createState() => _AddDeviceState();
}

class _AddDeviceState extends State<AddDevice> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool isHavedevice = false;
  var test;

  Future<void> _checkList() async {
    print('running check list');
    print(User.locklist);
    if (User.locklist == null || User.locklist.isEmpty) {
      setState(() {
        isHavedevice = false;
      });
    } else {
      setState(() {
        isHavedevice = true;
        test = User.locklist[0];
      });
    }
    print(isHavedevice);
  }

  Future<void> _refreshData() async {
    print("refreshing");
    await _checkList();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _checkList();
  }

  @override
  Widget build(BuildContext context) {
    Widget content = isHavedevice
        ? ListView(
            children: [
              SingleChildScrollView(
                child: Center(
                  child: Column(children: [
                    LockUser(
                      'ประตูประตูเลื่อน',
                      'Permanent/Admin',
                      '50%',
                      () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => LockPage(
                                  title: test['lockAlias'].toString(),
                                  lockData: test['lockData'].toString(),
                                  lockId: test['lockId'].toString(),
                                  lockMac: test['lockMac'].toString(),
                                )),
                      ),
                      test['lockId'].toString(),
                    ),
                  ]),
                ),
              ),
            ],
          )
        : ListView(
            children: [
              Center(
                child: Column(
                  children: [
                    const SizedBox(height: 90),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ChooseLock()),
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
              ),
            ],
          );

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
      body: RefreshIndicator(
        onRefresh: _refreshData,
        child: content,
      ),
    );
  }
}
