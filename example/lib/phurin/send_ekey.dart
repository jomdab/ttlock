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

                  child: TabBarView(children: <Widget>[
                    Container(
                      child: Center(
                        child: Column(
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
                                  onPressed: () {
                                    
                                  },
                                )),
                            Padding(
                              padding:
                                  const EdgeInsets.only(right: 15, left: 15),
                              child: Divider(
                                height: 0.0,
                                color: Colors.black54.withOpacity(0.4),
                              ),
                            ),
                            CustomTextfield('Name', 'Please enter here', null),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      child: Center(
                        child: Text('Display Tab 2',
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.bold)),
                      ),
                    ),
                    Container(
                      child: Center(
                        child: Text('Display Tab 3',
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.bold)),
                      ),
                    ),
                    Container(
                      child: Center(
                        child: Text('Display Tab 4',
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ]))
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
}

class _CustomTextfieldState extends State<CustomTextfield> {
  final TextEditingController _textEditingController = TextEditingController();
  

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.white),
      margin: EdgeInsets.only(left: 13, right: 13),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  widget.title,
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.black,
                  ),
                ),
              ),
              SizedBox(
                width: 20,
              ),
              Expanded(
                child: TextField(
                  controller: _textEditingController,
                  textAlign: TextAlign.right,
                  decoration: InputDecoration(
                    suffixIcon: widget.iconButton,
                    hintText: widget.hintText,
                    hintStyle:
                        TextStyle(color: Colors.black54.withOpacity(0.4)),
                    enabledBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    border: InputBorder.none,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
