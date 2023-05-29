import 'dart:math';

import 'package:flutter/material.dart';
import 'package:ttlock_flutter_example/api/passcodes/get_random_passcode.dart';

class PasscodePage extends StatefulWidget {
  const PasscodePage({required this.lockId, super.key});
  final String lockId;

  @override
  State<PasscodePage> createState() => _PasscodePageState(lockId);
}

class _PasscodePageState extends State<PasscodePage> {
  String lockId = '';
  static String startTime = '';
  static String endTime = '';
  static String passcodeName = '';
  static String passcodePwd = '';
  static bool isPermanent = false;

  CustomTextfield nameTextField =
      CustomTextfield('Name', 'Enter a name for this Passcode', null);
  CustomTextfield passcodeTextField =
      CustomTextfield('Passcode', '4 - 9 Digits in length', null);

  _PasscodePageState(String lockid) {
    super.initState();
    this.lockId = lockid;
  }
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 6,
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
              'Generate Passcode',
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
                        text: 'Permanent',
                      ),
                      Tab(
                        text: 'Timed',
                      ),
                      Tab(
                        text: 'One-time',
                      ),
                      Tab(
                        text: 'Custom',
                      ),
                      Tab(
                        text: 'Recurring',
                      ),
                      Tab(
                        text: 'Erase',
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
                              CustomTextfield('Name',
                                  'Enter a name for this Passcode', null),
                              Divider(
                                height: 0.0,
                                color: Colors.black54.withOpacity(0.2),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                'This Passcode MUST BE used at least Once, within 24 Hours from Current Time, or it will be SUSPENDED for Security Reasons.',
                                style: TextStyle(
                                    color: Colors.black45, fontSize: 13),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              ElevatedButton(
                                //get random permanent passcode. (Id = 2)
                                onPressed: () {
                                  getRandomPasscode(
                                      lockId,
                                      2,
                                      DateTime.now()
                                          .millisecondsSinceEpoch
                                          .toString(),
                                      '');
                                },
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
                                  'Generate Passcode',
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
                              CustomSetTime('Start Time',
                                  DateTime.now().toString(), true),
                              Divider(
                                height: 0.0,
                                color: Colors.black54.withOpacity(0.4),
                              ),
                              CustomSetTime(
                                  'End Time', DateTime.now().toString(), false),
                              SizedBox(
                                height: 10,
                              ),
                              nameTextField,
                              Divider(
                                height: 0.0,
                                color: Colors.black54.withOpacity(0.4),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                'Enter passcode can be used for unlimited times within the validity period.',
                                style: TextStyle(
                                    color: Colors.black45, fontSize: 13),
                              ),
                              Text(
                                'This passcode MUST BE used at least ONCE within 24 Hours after setting, or it will be SUSPENDED for Security Reasons.',
                                style: TextStyle(
                                    color: Colors.black45, fontSize: 13),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              ElevatedButton(
                                // get random timed passcode (Id = 3)
                                onPressed: () {
                                  print('start time = $startTime');
                                  print(endTime);
                                  getRandomPasscode(
                                      lockId, 3, startTime, endTime);
                                },
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
                                  'Generate Passcode',
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
                              nameTextField,
                              Divider(
                                height: 0.0,
                                color: Colors.black54.withOpacity(0.2),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                'This Passcode MUST BE used within 6 Houts from the Current Time or it will be SUSPENDED for Security Reasons. This Passcode can ONLY be used ONCE.',
                                style: TextStyle(
                                    color: Colors.black45, fontSize: 13),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  getRandomPasscode(
                                      lockId, 1, startTime, endTime);
                                },
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
                                  'Generate Passcode',
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
                                                'Permanent',
                                                style: TextStyle(fontSize: 16),
                                              ),
                                            ),
                                            SwitchExample(),
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
                              nameTextField,
                              Divider(
                                height: 0.0,
                                color: Colors.black54.withOpacity(0.2),
                              ),
                              passcodeTextField,
                              Divider(
                                height: 0.0,
                                color: Colors.black54.withOpacity(0.2),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                'You can Configure your own Passcode. It needs to be between 4 - 9 Digits in Length. You can Configure the Custonmized Passcode via Bluetooth or Remotely via a Gateway.',
                                style: TextStyle(
                                    color: Colors.black45, fontSize: 13),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  isPermanent ? () {} : () {};
                                },
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
                                  'Generate Passcode',
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
                              Text('day'),
                              Divider(
                                height: 0.0,
                                color: Colors.black54.withOpacity(0.4),
                              ),
                              Text('start'),
                              Divider(
                                height: 0.0,
                                color: Colors.black54.withOpacity(0.4),
                              ),
                              Text('end'),
                              SizedBox(
                                height: 10,
                              ),
                              nameTextField,
                              Divider(
                                height: 0.0,
                                color: Colors.black54.withOpacity(0.2),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                'Enter passcode can be used for unlimited times within the validity period.',
                                style: TextStyle(
                                    color: Colors.black45, fontSize: 13),
                              ),
                              Text(
                                'This passcode MUST BE used at least ONCE within 24 Hours after setting, or it will be SUSPENDED for Security Reasons.',
                                style: TextStyle(
                                    color: Colors.black45, fontSize: 13),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              ElevatedButton(
                                onPressed: () {},
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
                                  'Generate Passcode',
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
                              nameTextField,
                              Divider(
                                height: 0.0,
                                color: Colors.black54.withOpacity(0.2),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                'This Passcode is VALID for 24 Hours from the Current Time. Caution - All Passcodes used on this Lock will be DELETED on using this Passcode',
                                style: TextStyle(
                                    color: Colors.black45, fontSize: 13),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              ElevatedButton(
                                onPressed: () {},
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
                                  'Generate Passcode',
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
      _PasscodePageState.startTime =
          selectedDateTime.millisecondsSinceEpoch.toString();
    } else {
      _PasscodePageState.endTime =
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

class SwitchExample extends StatefulWidget {
  const SwitchExample({super.key});

  @override
  State<SwitchExample> createState() => _SwitchExampleState();
}

class _SwitchExampleState extends State<SwitchExample> {
  bool light = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 35,
      child: Switch(
        // This bool value toggles the switch.
        value: light,
        onChanged: (bool value) {
          // This is called when the user toggles the switch.
          setState(() {
            _PasscodePageState.isPermanent = value;
            light = value;
            print(_PasscodePageState.isPermanent);
          });
        },
      ),
    );
  }
}
