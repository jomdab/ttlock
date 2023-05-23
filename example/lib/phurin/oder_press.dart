import 'package:flutter/material.dart';
import 'package:ttlock_flutter_example/phurin/send_ekey.dart';

class OderPress extends StatefulWidget {
  const OderPress(this.title, this.titlebutton,{super.key});
  final String title;
  final String titlebutton;

  @override
  State<OderPress> createState() => _OderPressState();
}

class _OderPressState extends State<OderPress> {

  void _pressbutton (){
    if(widget.titlebutton == 'Send eKey'){
      Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SendEkey()),
                );
    }else{
      (){};
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
