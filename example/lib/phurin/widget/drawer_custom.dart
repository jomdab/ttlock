import 'package:flutter/material.dart';
import 'package:ttlock_flutter_example/phurin/find_lock.dart';
import 'package:ttlock_flutter_example/phurin/login.dart';
import 'package:ttlock_flutter_example/phurin/profile.dart';
import 'package:ttlock_flutter_example/user.dart';
import 'package:ttlock_flutter_example/phurin/setting.dart';

import '../choose_lock.dart';

class DrawerCustom extends StatefulWidget {
  const DrawerCustom({super.key});

  @override
  State<DrawerCustom> createState() => _DrawerCustomState();
}

class _DrawerCustomState extends State<DrawerCustom> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.6,
      child: SafeArea(
        child: Drawer(
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: [
              Container(
                height: 250,
                child: DrawerHeader(
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 0, 122, 255),
                    image: DecorationImage(
                      image: AssetImage('assets/image/drawer.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Center(
                      child: Column(
                    children: [
                      SizedBox(height: 35),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Profile()),
                          );
                        },
                        child: CircleAvatar(
                          foregroundImage:
                              AssetImage('assets/image/ttlockLogo.png'),
                          radius: 32.0,
                          backgroundColor: Color.fromARGB(255, 213, 236, 246),
                          child: Align(
                            alignment: Alignment.bottomRight,
                            child: CircleAvatar(
                              backgroundColor: Colors.black.withOpacity(0.5),
                              radius: 13.0,
                              child: Icon(
                                Icons.edit_note_sharp,
                                size: 22.0,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        User.nickname,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.w400,
                        ),
                      )
                    ],
                  )),
                ),
              ),
              SizedBox(height: 25),
              CustomItem(
                Icons.add,
                'Add Lock',
                () => {
                  Navigator.pop(context),
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ChooseLock()),
                  )
                },
              ),
              CustomItem(
                Icons.wifi_rounded,
                'Gateway',
                () => {
                  Navigator.pop(context),
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const FindLock()),
                  )
                },
              ),
              CustomItem(
                Icons.messenger_outline,
                'Messages',
                () => {Navigator.pop(context)},
              ),
              CustomItem(
                Icons.error_outline_outlined,
                'Custom Service',
                () => {Navigator.pop(context)},
              ),
              CustomItem(
                Icons.settings_outlined,
                'Setting',
                () => {
                  Navigator.pop(context),
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Setting()),
                  )
                },
              ),
              CustomItem(
                Icons.bookmark_border_rounded,
                'Work with',
                () => {Navigator.pop(context)},
              ),
              CustomItem(
                Icons.bookmark_border_rounded,
                'Log out',
                () {
                  User.userLogout();
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => Login()),
                    (route) => false,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomItem extends StatelessWidget {
  final IconData icon;
  final String text;
  final Function onTaps;

  CustomItem(this.icon, this.text, this.onTaps);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SizedBox(
        height: 45,
        child: GestureDetector(
          onTap: () {
            onTaps();
          },
          child: Padding(
            padding: const EdgeInsets.only(left: 65.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(icon),
                SizedBox(width: 10),
                Text(text, style: TextStyle(fontSize: 16)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
