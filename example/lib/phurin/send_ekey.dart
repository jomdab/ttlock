import 'dart:math';

import 'package:flutter/material.dart';

class SendEkey extends StatefulWidget {
  const SendEkey({super.key});

  @override
  State<SendEkey> createState() => _SendEkeyState();
}

class _SendEkeyState extends State<SendEkey> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      initialIndex: 0,
      child: Scaffold(
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
              'Send eKey',
              style: TextStyle(color: Colors.white),
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: GestureDetector(
                onTap: () {},
                child: const Center(
                  child: Text('    '),
                ),
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Container(
                  width: 400,
                  color: Colors.white,
                  child: TabBar(
                    labelColor: const Color.fromARGB(255, 0, 122, 255),
                    unselectedLabelColor: Colors.black,
                    isScrollable: true,
                    tabs: [
                      Tab(
                        text: 'Timed',
                      ),
                      Tab(
                        text: 'Permanent',
                      ),
                      Tab(
                        text: 'One-time',
                      ),
                      Tab(
                        text: 'Recurring',
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                height: 600, //height of TabBarView

                child: TabBarView(
                  children: <Widget>[
                    Container(
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 15, left: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomTextfield(
                                  'Recipient',
                                  'Phone Number or Email',
                                  IconButton(
                                    icon: Icon(
                                      Icons.clear,
                                      size: 20,
                                      color: Colors.black54.withOpacity(0.1),
                                    ),
                                    onPressed: () {},
                                  )),
                              Divider(
                                height: 0.0,
                                color: Colors.black54.withOpacity(0.4),
                              ),
                              CustomTextfield(
                                  'Name', 'Please enter here', null),
                              SizedBox(
                                height: 10,
                              ),
                              CustomSetTime('Start Time', '2023.05.24 15.58'),
                              Divider(
                                height: 0.0,
                                color: Colors.black54.withOpacity(0.4),
                              ),
                              CustomSetTime('End Time', '2023.05.24 17.58'),
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                'Recipients are able to use the eKeys for unlimited times within the vaildity period',
                                style: TextStyle(
                                    color: Colors.black45, fontSize: 15),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  elevation: 0,
                                  backgroundColor: Colors.black26,
                                  fixedSize: const Size(360, 45),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                ),
                                child: const Text(
                                  'Send',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 17,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Container(
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 15, left: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomTextfield(
                                  'Recipient',
                                  'Phone Number or Email',
                                  IconButton(
                                    icon: Icon(
                                      Icons.clear,
                                      size: 20,
                                      color: Colors.black54.withOpacity(0.1),
                                    ),
                                    onPressed: () {},
                                  )),
                              Divider(
                                height: 0.0,
                                color: Colors.black54.withOpacity(0.4),
                              ),
                              CustomTextfield(
                                  'Name', 'Please enter here', null),
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                'Recipients are able to Lock/Unlock by this App',
                                style: TextStyle(
                                    color: Colors.black45, fontSize: 15),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  elevation: 0,
                                  backgroundColor: Colors.black26,
                                  fixedSize: const Size(360, 45),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                ),
                                child: const Text(
                                  'Send',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 17,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Container(
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 15, left: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomTextfield(
                                  'Recipient',
                                  'Phone Number or Email',
                                  IconButton(
                                    icon: Icon(
                                      Icons.clear,
                                      size: 20,
                                      color: Colors.black54.withOpacity(0.1),
                                    ),
                                    onPressed: () {},
                                  )),
                              Divider(
                                height: 0.0,
                                color: Colors.black54.withOpacity(0.4),
                              ),
                              CustomTextfield(
                                  'Name', 'Please enter here', null),
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                'The One-time eKeys is valid for ONE hour and can only be use ONCE',
                                style: TextStyle(
                                    color: Colors.black45, fontSize: 15),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  elevation: 0,
                                  backgroundColor: Colors.black26,
                                  fixedSize: const Size(360, 45),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                ),
                                child: const Text(
                                  'Send',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 17,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Container(
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 15, left: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomTextfield(
                                  'Recipient',
                                  'Phone Number or Email',
                                  IconButton(
                                    icon: Icon(
                                      Icons.clear,
                                      size: 20,
                                      color: Colors.black54.withOpacity(0.1),
                                    ),
                                    onPressed: () {},
                                  )),
                              Divider(
                                height: 0.0,
                                color: Colors.black54.withOpacity(0.4),
                              ),
                              CustomTextfield(
                                  'Name', 'Please enter here', null),
                              SizedBox(
                                height: 15,
                              ),
                              GestureDetector(
                                onTap: () {},
                                child: Container(
                                  height: 50,
                                  decoration:
                                      BoxDecoration(color: Colors.white),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10,
                                            bottom: 5,
                                            right: 0,
                                            top: 7),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              flex: 1,
                                              child: Text(
                                                'Vaildity Period',
                                                style: TextStyle(fontSize: 16),
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                Transform(
                                                  transform:
                                                      Matrix4.rotationY(pi),
                                                  alignment: Alignment.center,
                                                  child: Icon(
                                                    Icons.arrow_back_ios_new,
                                                    size: 16,
                                                    color: Colors.black54
                                                        .withOpacity(0.4),
                                                  ),
                                                ),
                                                SizedBox(width: 15),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Divider(
                                height: 0.0,
                                color: Colors.black54.withOpacity(0.4),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                'Recipients are able to use the eKeys for unlimited times within the fixed cycle time',
                                style: TextStyle(
                                    color: Colors.black45, fontSize: 15),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  elevation: 0,
                                  backgroundColor: Colors.black26,
                                  fixedSize: const Size(360, 45),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                ),
                                child: const Text(
                                  'Send',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 17,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomTextfield extends StatefulWidget {
  const CustomTextfield(this.title, this.hintText, this.iconButton,
      {super.key});
  final String title;
  final String hintText;
  final IconButton? iconButton;

  @override
  State<CustomTextfield> createState() => _CustomTextfieldState();

  TextEditingController getController() {
    return _CustomTextfieldState()._textEditingController;
  }
}

class _CustomTextfieldState extends State<CustomTextfield> {
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
      decoration: BoxDecoration(color: Colors.white),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.only(bottom: 8, left: 8, right: 8, top: 8),
                child: Text(
                  widget.title,
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.black,
                  ),
                ),
              ),
              Expanded(
                child: TextField(
                  controller: _textEditingController,
                  textAlign: TextAlign.right,
                  decoration: InputDecoration(
                    suffixIcon: widget.iconButton != null
                        ? IconButton(
                          icon: Icon(
                            Icons.clear,
                            size: 20,
                            color: Colors.black54.withOpacity(0.1),
                          ),
                          onPressed: clearInput,
                        )
                        : null,
                        suffixIconConstraints: BoxConstraints(maxWidth: 20),
                    hintText: widget.hintText,
                    hintStyle: TextStyle(
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
    );
  }
}

class CustomSetTime extends StatelessWidget {
  final String topic;
  final String title;
  CustomSetTime(this.topic, this.title);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        height: 50,
        decoration: BoxDecoration(color: Colors.white),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding:
                  const EdgeInsets.only(left: 10, bottom: 5, right: 0, top: 7),
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
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(width: 15),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
