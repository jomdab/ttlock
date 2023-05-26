import 'package:flutter/material.dart';

class LockUser extends StatefulWidget {
  const LockUser(this.name, this.status, this.power, this.onTaps, {super.key});

  final String name;
  final String status;
  final String power;
  final Function onTaps;

  @override
  State<LockUser> createState() => _LockUserState();
}

class _LockUserState extends State<LockUser> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onTaps();
      },
      child: Container(
        padding: EdgeInsets.all(15),
        margin: EdgeInsets.all(8),
        height: 110,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(15))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Text(
                    widget.name,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                ),
                Text(widget.power,
                    style: TextStyle(fontWeight: FontWeight.w300)),
              ],
            ),
            SizedBox(height: 35),
            Text(
              widget.status,
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w300),
            ),
          ],
        ),
      ),
    );
  }
}
