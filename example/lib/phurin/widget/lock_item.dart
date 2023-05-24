import 'dart:math';

import 'package:flutter/material.dart';

class LockItem extends StatefulWidget {
  const LockItem({
    super.key,
    required this.title,
    required this.image,
  });
  final String title;
  final String image;

  @override
  State<LockItem> createState() => _LockItemState();
}

class _LockItemState extends State<LockItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        // color: Colors.amber,
        height: 80,
        width: 185,
        child: Card(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(children: [
            Expanded(
              flex: 1,
              child: Row(
                children: [
                  Image.asset(
                    widget.image,
                    width: 60,
                  ),
                  Column(
                    children: [
                      SizedBox(height: 25),
                      SizedBox(
                        height: 40,
                        width: 90,
                        child: Text(
                          widget.title,
                          style: TextStyle(fontSize: 15),
                          maxLines: 2,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Transform(
              transform: Matrix4.rotationY(pi),
              alignment: Alignment.center,
              child: Icon(
                Icons.arrow_back_ios_new,
                size: 20,
                color: Colors.black54.withOpacity(0.4),
              ),
            )
          ]),
        ),
      ),
    );
  }
}
