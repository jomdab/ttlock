import 'package:flutter/material.dart';
import 'package:ttlock_flutter_example/api/ekeys/get_account_ekey.dart';
import 'package:ttlock_flutter_example/api/ekeys/get_one_ekey.dart';
import 'package:ttlock_flutter_example/api/oaths/get_access_token.dart';
import 'package:ttlock_flutter_example/lock_page.dart';
import 'package:ttlock_flutter_example/phurin/choose_lock.dart';
import 'package:ttlock_flutter_example/phurin/widget/drawer_custom.dart';
import 'package:ttlock_flutter_example/phurin/widget/lock_user.dart';
import 'package:ttlock_flutter_example/user.dart';

import '../lock_ekey.dart';

class AddDevice extends StatefulWidget {
  const AddDevice({super.key});

  @override
  State<AddDevice> createState() => _AddDeviceState();
}

class _AddDeviceState extends State<AddDevice> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool isHavedevice = false;
  List ekeyList = [];

  Future<void> _checkList() async {
    print('running check list');
    print(User.locklist);
    ekeyList = await getAccountEkey();
    print('ekeyList = ${ekeyList[0]['userType']}');
    if ((User.locklist.isEmpty) && (ekeyList.isEmpty)) {
      if (mounted) {
        setState(() {
          isHavedevice = false;
        });
      }
    } else {
      if (mounted) {
        setState(() {
          isHavedevice = true;
        });
      }
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
    int totalItemCount = 0;
    if (User.locklist.length > 0) {
      totalItemCount += User.locklist.length;
    }
    if (ekeyList.length > 0) {
      totalItemCount += ekeyList.length;
    }
    Widget content = isHavedevice
        ? ListView.builder(
            itemCount: ekeyList.length,
            itemBuilder: (context, index) {
              return LockUser(
                ekeyList[index]['lockAlias'],
                ekeyList[index]['userType'] == '110301'
                    ? 'Permanent/Admin'
                    : 'Timed',
                '${ekeyList[index]['electricQuantity'].toString()}%',
                ekeyList[index]['userType'] == '110301'
                    ? () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LockPage(
                      title: ekeyList[index]['lockAlias'].toString(),
                      lockData: ekeyList[index]['lockData'].toString(),
                      lockId: ekeyList[index]['lockId'].toString(),
                      lockMac: ekeyList[index]['lockMac'].toString(),
                    ),
                  ),
                ):() => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LockeKeyPage(
                      title: ekeyList[index]['lockAlias'].toString(),
                      lockData: ekeyList[index]['lockData'].toString(),
                      lockId: ekeyList[index]['lockId'].toString(),
                      lockMac: ekeyList[index]['lockMac'].toString(),
                    ),
                  ),
                ),
              );
            })
        // ? ListView(
        //     children: [
        //       SingleChildScrollView(
        //         child: Center(
        //           child: Column(children: [
        //             LockUser(
        //               'ประตูประตูเลื่อน',
        //               'Permanent/Admin',
        //               '50%',
        //               () => Navigator.push(
        //                 context,
        //                 MaterialPageRoute(
        //                     builder: (context) => LockPage(
        //                           title: test['lockAlias'].toString(),
        //                           lockData: test['lockData'].toString(),
        //                           lockId: test['lockId'].toString(),
        //                           lockMac: test['lockMac'].toString(),
        //                         )
        //                     // builder: (context) => OrderLock(
        //                     //   lockData: test['lockData'].toString(),
        //                     //   lockId: test['lockId'].toString(),
        //                     // ),
        //                     ),
        //               ),
        //             ),
        //           ]),
        //         ),
        //       ),
        //     ],
        //   )
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
