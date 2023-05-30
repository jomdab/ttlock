import 'dart:math';

import 'package:flutter/material.dart';
import 'package:ttlock_flutter_example/api/ekeys/send_ekey.dart';

class SendEkey extends StatefulWidget {
  const SendEkey({required this.lockId, super.key});
  final String lockId;

  @override
  State<SendEkey> createState() => _SendEkeyState(lockId);
}

class _SendEkeyState extends State<SendEkey> {
  bool _isInputValid = false;
  static String startTime = '';
  static String endTime = '';
  String lockId = '';
  CustomTextfield keyNameField =
      CustomTextfield('Name', 'Please enter here', null);
  CustomTextfield usernameField = CustomTextfield(
      'Recipient',
      'Phone Number or Email',
      IconButton(
        icon: Icon(
          Icons.clear,
          size: 20,
          color: Colors.black54.withOpacity(0.1),
        ),
        onPressed: () {},
      ));

  _SendEkeyState(String lockId) {
    super.initState();
    this.lockId = lockId;
  }
  void _updateInputStatus() {
    final email = usernameField.getController().text;

    setState(() {
      _isInputValid = email.isNotEmpty ;
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    keyNameField.getController().dispose();
    usernameField.getController().dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    usernameField.getController().addListener(_updateInputStatus);
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
                              usernameField,
                              Divider(
                                height: 0.0,
                                color: Colors.black54.withOpacity(0.4),
                              ),
                              keyNameField,
                              SizedBox(
                                height: 10,
                              ),
                              CustomSetTime('Start Time',
                                  DateTime.now().toString(), true),
                              Divider(
                                height: 0.0,
                                color: Colors.black54.withOpacity(0.4),
                              ),
                              CustomSetTime(
                                  'End Time', DateTime.now().toString(), false),
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
                                onPressed: _isInputValid
                                    ? () {
                                        print(
                                            'username = ${usernameField.getController().text}');
                                        sendEkey(
                                            lockId,
                                            usernameField.getController().text,
                                            keyNameField.getController().text,
                                            startTime,
                                            endTime);
                                      }
                                    : null,
                                style: ElevatedButton.styleFrom(
                                  elevation: 0,
                                  backgroundColor:
                                      const Color.fromARGB(255, 0, 122, 255),
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
  CustomTextfield(this.title, this.hintText, this.iconButton, {super.key});
  final String title;
  final String hintText;
  final IconButton? iconButton;
  var _textEditingController = TextEditingController();

  @override
  State<CustomTextfield> createState() => _CustomTextfieldState();

  TextEditingController getController() {
    return _textEditingController;
  }
}

class _CustomTextfieldState extends State<CustomTextfield> {
  void clearInput() {
    widget._textEditingController.clear();
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
                  controller: widget._textEditingController,
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
  final bool isStart;
  CustomSetTime(this.topic, this.title, this.isStart);

  void showDateTimeSelector(BuildContext context) async {
    final currentDate = DateTime.now();

    final selectedDate = await showDatePicker(
      context: context,
      initialDate: currentDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (selectedDate == null) return; // User canceled date selection

    final selectedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(currentDate),
    );

    if (selectedTime == null) return; // User canceled time selection

    final selectedDateTime = DateTime(
      selectedDate.year,
      selectedDate.month,
      selectedDate.day,
      selectedTime.hour,
      selectedTime.minute,
    );

    // TODO: Handle the selectedDateTime as needed
    print('Selected DateTime: $selectedDateTime');
    if (isStart) {
      _SendEkeyState.startTime =
          selectedDateTime.millisecondsSinceEpoch.toString();
    } else {
      _SendEkeyState.endTime =
          selectedDateTime.millisecondsSinceEpoch.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDateTimeSelector(context);
      },
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
