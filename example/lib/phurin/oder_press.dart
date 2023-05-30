import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ttlock_flutter_example/api/ekeys/delete_ekey.dart';
import 'package:ttlock_flutter_example/api/ekeys/get_lock_ekey.dart';
import 'package:ttlock_flutter_example/api/passcodes/get_all_passcode.dart';
import 'package:flutter/cupertino.dart';
import 'package:ttlock_flutter_example/phurin/infoeKey_page.dart';
import 'package:ttlock_flutter_example/phurin/infopasscod_page.dart';
import 'package:ttlock_flutter_example/phurin/passcode_page.dart';
import 'package:ttlock_flutter_example/phurin/send_ekey.dart';
import 'package:ttlock_flutter_example/user.dart';

class OrderPress extends StatefulWidget {
  const OrderPress(this.title, this.titlebutton,
      {super.key, required this.lockId});
  final String title;
  final String titlebutton;
  final String lockId;

  @override
  State<OrderPress> createState() => _OrderPressState(lockId);
}

class _OrderPressState extends State<OrderPress> {
  bool isHaveDataeKey = true;
  String lockId = '';
  var lockPasscodes;
  var lockEkey;
  bool isHavePasscodes = false;
  bool isHaveLockEkey = false;
  String page = '';

  Future<void> _checkList() async {
    print('running check list');
    lockPasscodes = jsonDecode(await getAllPasscode(lockId))['list'];
    if (lockPasscodes == null || lockPasscodes.isEmpty) {
      if (mounted) {
        setState(() {
          isHavePasscodes = false;
        });
      }
    } else {
      if (mounted) {
        setState(() {
          isHavePasscodes = true;
        });
      }
    }
    print(isHavePasscodes);
  }

  Future<void> _checkEkey() async {
    print('running check ekey');
    lockEkey = await getLockEkey(lockId);
    print(lockEkey);
    if (lockEkey == null || lockEkey.isEmpty) {
      if (mounted) {
        setState(() {
          isHaveLockEkey = false;
        });
      }
    } else {
      if (mounted) {
        setState(() {
          isHaveLockEkey = true;
        });
      }
    }
    print(isHaveLockEkey);
  }

  Future<void> _refreshData() async {
    print("refreshing");
    await _checkList();
    await _checkEkey();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _checkList();
    _checkEkey();
  }

  _OrderPressState(String lockId) {
    this.lockId = lockId;
  }

  void _pressbutton() {
    if (widget.titlebutton == 'Send eKey') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SendEkey(
            lockId: lockId,
          ),
        ),
      );
    } else if (widget.titlebutton == 'Generate Passcode') {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => PasscodePage(
                  lockId: lockId,
                )),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget content = isHavePasscodes && widget.title == 'Passcodes'
        ? ListView.builder(
            itemCount: lockPasscodes.length,
            itemBuilder: (context, index) {
              final passcode = lockPasscodes[index]['keyboardPwd'];
              final passcodeType = lockPasscodes[index]['keyboardPwdType'];
              final mappedPasscodeType =
                  numberToPasscodesType[passcodeType.toString()] ?? '';
              return DataeKey(
                'assets/image/passcodeicon.png',
                lockPasscodes[index]['keyboardPwdName'] ?? 'Anonymous',
                mappedPasscodeType,
                () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const InfoPasscodPage(
                          'Passcode Info', Icon(Icons.ios_share))),
                ),
                'passcode',
              );
            },
          )
        : ListView(
            children: [
              Center(
                child: Column(
                  children: [
                    SizedBox(height: 80),
                    Image.asset('assets/image/nodata.png', width: 100),
                    SizedBox(height: 20),
                    Text(
                      'No Data',
                      style: TextStyle(color: Colors.grey, fontSize: 15),
                    ),
                  ],
                ),
              ),
            ],
          );

    if (widget.title == 'eKeys') {
      if (isHaveLockEkey == true) {
        content = ListView.builder(
          itemCount: lockEkey.length,
          itemBuilder: (context, index) {
            final ekeyName = lockEkey[index]['keyName'].toString().isEmpty
                ? lockEkey[index]['keyId'].toString()
                : lockEkey[index]['keyName'];
            return DataeKey(
              'assets/image/ttlockLogo.png',
              ekeyName,
              'Timed',
              () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const InfoeKeyPage('eKeys Info')),
              ),
              'ekey',
              keyId: lockEkey[index]['keyId'].toString(),
            );
          },
        );
      }
    }

    final double width = MediaQuery.of(context).size.width;

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
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: GestureDetector(
              onTap: () {
                if (widget.title == 'eKeys') {
                  deleteAllEkey(lockId);
                }
              },
              child: const Center(
                child: Text('Reset'),
              ),
            ),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _refreshData,
        child: content,
      ),
      floatingActionButton: Container(
        height: 60,
        width: width - 30,
        child: FloatingActionButton.extended(
          onPressed: _pressbutton,
          label: Row(
            children: [
              CircleAvatar(
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                  size: 20,
                ),
                radius: 11,
                backgroundColor: const Color.fromARGB(255, 0, 122, 255),
              ),
              SizedBox(width: 5),
              Text(
                widget.titlebutton,
                style: TextStyle(
                    fontSize: 17,
                    color: const Color.fromARGB(255, 0, 122, 255),
                    fontWeight: FontWeight.w700),
              ),
            ],
          ),
          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(8), // Customize the button shape
          ),
          backgroundColor: Colors.white,
        ),
      ),
    );
  }
}

class SearchBar extends StatefulWidget {
  const SearchBar({super.key});

  @override
  State<SearchBar> createState() => _SearchBarState();

  TextEditingController getController() {
    return _SearchBarState()._textEditingController;
  }
}

class _SearchBarState extends State<SearchBar> {
  final TextEditingController _textEditingController = TextEditingController();

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  void clearInput() {
    _textEditingController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        left: 15,
      ),
      child: Transform.scale(
        scale: 0.8,
        alignment: Alignment.topLeft,
        child: Container(
          height: 48,
          width: 400,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(40),
            ),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    padding:
                        EdgeInsets.only(bottom: 8, left: 20, right: 8, top: 8),
                    child: Icon(
                      Icons.search,
                      size: 27,
                      color: Colors.black26,
                    ),
                  ),
                  Expanded(
                    child: TextField(
                      controller: _textEditingController,
                      decoration: InputDecoration(
                        hintText: 'Search',
                        hintStyle: TextStyle(
                          fontSize: 20,
                          color: Colors.black54.withOpacity(0.4),
                        ),
                        enabledBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DataeKey extends StatefulWidget {
  DataeKey(this.image, this.name, this.status, this.onTaps, this.page,
      {super.key, String? keyId})
      : keyId = keyId ?? '';
  final String image;
  final String name;
  final String status;
  final Function onTaps;
  final String page;
  String keyId = '';

  @override
  State<DataeKey> createState() => _DataeKeyState();
}

class _DataeKeyState extends State<DataeKey> {
  Offset _tapPosition = Offset.zero;

  void _getPosition(TapDownDetails tapDetails) {
    final RenderBox renderBox = context.findRenderObject() as RenderBox;

    setState(() {
      _tapPosition = renderBox.globalToLocal(tapDetails.globalPosition);
      print(_tapPosition);
    });
  }

  void _showContextButton(BuildContext context) async {
    final RenderBox overlay =
        Overlay.of(context).context.findRenderObject() as RenderBox;
    final RenderBox button = context.findRenderObject() as RenderBox;
    final Offset position =
        button.localToGlobal(Offset.zero, ancestor: overlay);
    print(position);

    // Show the popup menu and get the selected result
    final result = await showMenu(
      context: context,
      position: RelativeRect.fromRect(
        Rect.fromPoints(
          position + _tapPosition,
          position + _tapPosition,
        ),
        Offset.zero & overlay.semanticBounds.size,
      ),
      items: [
        PopupMenuItem(
          height: 30,
          child: Container(child: Text('Delete'), width: 120),
          value: 'Delete',
        ),
      ],
    );

    // Check the selected result and show the dialog accordingly
    if (result == 'Delete') {
      showCupertinoDialog(context: context, builder: createDialog);
    }
  }

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
          CupertinoDialogAction(
              child: Text('Delete'),
              onPressed: () {
                if (widget.page == 'ekey') {
                  print(widget.keyId);
                  deleteEkey(widget.keyId);
                  Navigator.pop(context);
                }
              }),
        ],
      );

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onTaps();
      },
      onTapDown: (TapDownDetails details) {
        _getPosition(details);
      },
      onLongPress: () {
        _showContextButton(context);
      },
      child: Column(
        children: [
          Container(
            height: 70,
            decoration: BoxDecoration(color: Colors.white),
            child: Row(
              children: [
                SizedBox(
                  width: 15,
                ),
                CircleAvatar(
                  radius: 23,
                  backgroundImage: AssetImage(widget.image),
                  backgroundColor: Color.fromARGB(255, 213, 236, 246),
                ),
                SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      widget.name,
                      style: TextStyle(fontSize: 15),
                    ),
                    Text(
                      widget.status,
                      style: TextStyle(color: Colors.black38),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Divider(
            color: Colors.black26,
            height: 0.0,
          )
        ],
      ),
    );
  }
}
