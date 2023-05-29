import 'package:flutter/material.dart';
import 'package:ttlock_flutter_example/phurin/passcode_page.dart';
import 'package:ttlock_flutter_example/phurin/send_ekey.dart';

class OrderPress extends StatefulWidget {
  const OrderPress(this.title, this.titlebutton, {super.key});
  final String title;
  final String titlebutton;

  @override
  State<OrderPress> createState() => _OrderPressState();
}

class _OrderPressState extends State<OrderPress> {
  bool isHaveDataeKey = true;

  void _pressbutton() {
    if (widget.titlebutton == 'Send eKey') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const SendEkey()),
      );
    } else if (widget.titlebutton == 'Generate Passcode') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const PasscodePage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget content = Center(
      child: Column(
        children: [
          SizedBox(height: 80),
          Image.asset('assets/image/nodata.png', width: 100),
          SizedBox(height: 20),
          Text('No Data', style: TextStyle(color: Colors.grey, fontSize: 15)),
        ],
      ),
    );

    if (widget.title == 'eKeys') {
      if (isHaveDataeKey == true) {
        content = SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                SearchBar(),
                SizedBox(
                  height: 8,
                ),
                DataeKey(),
                DataeKey(),
                DataeKey(),
              ],
            ),
          ),
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
              onTap: () {},
              child: const Center(
                child: Text('Reset'),
              ),
            ),
          ),
        ],
      ),
      body: content,
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
  const DataeKey({super.key});

  @override
  State<DataeKey> createState() => _DataeKeyState();
}

class _DataeKeyState extends State<DataeKey> {
  @override
  Widget build(BuildContext context) {
    return Column(
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
                backgroundImage: AssetImage('assets/image/ttlockLogo.png'),
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
                    'Mom',
                    style: TextStyle(fontSize: 15),
                  ),
                  Text(
                    'Permanent',
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
    );
  }
}
