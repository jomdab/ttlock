import 'package:flutter/material.dart';


class SendEkey extends StatefulWidget {
  const SendEkey({super.key});

  @override
  State<SendEkey> createState() => _SendEkeyState();
}

class _SendEkeyState extends State<SendEkey> {
  @override
  Widget build(BuildContext context) {
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
    );
  }
}