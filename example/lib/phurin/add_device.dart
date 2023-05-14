import 'package:flutter/material.dart';
import 'package:ttlock_flutter_example/phurin/choose_lock.dart';

class AddDevice extends StatefulWidget {
  const AddDevice({super.key});

  @override
  State<AddDevice> createState() => _AddDeviceState();
}

class _AddDeviceState extends State<AddDevice> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color.fromARGB(255, 0, 122, 255),
        leading: IconButton(
          onPressed: () => _scaffoldKey.currentState?.openDrawer(),
          icon: const Icon(
            Icons.menu,
            size: 28,
            color: Colors.white,
            weight: 500,
          ),
        ),
        title: const Center(
          child: Text(
            'TTLock',
            style: TextStyle(color: Colors.white),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.search,
              size: 28,
              color: Colors.white,
              weight: 500,
            ),
          ),
        ],
      ),
      drawer: Container(
        width: MediaQuery.of(context).size.width * 0.65,
        child: SafeArea(
          child: Drawer(child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 0, 122, 255),
                ),
                child: Text('Drawer Header'),
              ),
              ListTile(
                title: const Text('Item 1'),
                onTap: () {
                  // Update the state of the app
                  // ...
                  // Then close the drawer
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('Item 2'),
                onTap: () {
                  // Update the state of the app
                  // ...
                  // Then close the drawer
                  Navigator.pop(context);
                },
              ),
            ],
          ),),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 90),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ChooseLock()),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 10,
                        color: Colors.black54.withOpacity(0.08),
                        spreadRadius: 0.001)
                  ],
                ),
                child: CircleAvatar(
                  radius: 65,
                  backgroundColor: Colors.white,
                  child: Icon(
                    Icons.add,
                    size: 50,
                    color: Colors.black54.withOpacity(0.08),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 50),
            Text(
              'The Phone needs to be within 2 meters of the Smart Lock',
              style: TextStyle(
                color: Colors.black54.withOpacity(0.4),
              ),
            ),
            Text(
              'during the Pairing process.',
              style: TextStyle(
                color: Colors.black54.withOpacity(0.4),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
