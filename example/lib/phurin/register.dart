import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ttlock_flutter_example/phurin/add_device.dart';
import 'package:ttlock_flutter_example/phurin/widget/policy_dialog.dart';




class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool _isPasswordVisible = false;
  TextInputType _keyboardType = TextInputType.text;

  final TextEditingController _textEditingController = TextEditingController();
  bool _showSuffixIcon = false;
  bool _isPolicy = true;

  void policy() {
    setState(() {
      _isPolicy = !_isPolicy;
    });
    print(_isPolicy);
  }

  void _register() {
    if (!_isPolicy) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const AddDevice()),
      );
    } else {
      showDialog(
        context: context,
        builder: (context) => PoclicyDialog(),
      );
    }
  }

  void _togglePasswordVisibility() {
    setState(() {
      _isPasswordVisible = !_isPasswordVisible;
      _keyboardType = _isPasswordVisible
          ? TextInputType.text
          : TextInputType.visiblePassword;
    });
  }

  @override
  void initState() {
    super.initState();
    _textEditingController.addListener(_updateSuffixIconVisibility);
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  void _updateSuffixIconVisibility() {
    setState(() {
      _showSuffixIcon = _textEditingController.text.isNotEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 0, 122, 255),
        elevation: 0,
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
            'Register',
            style: TextStyle(color: Colors.white),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: GestureDetector(
              onTap: () {},
              child: const Center(
                child: Text(''),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Column(
              children: [
                const SizedBox(height: 30),
                Container(
                  //email and phone
                  height: 28,
                  width: 222,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.horizontal(
                        right: Radius.circular(30), left: Radius.circular(30)),
                    border: Border.all(
                      width: 1,
                      color: Colors.black54.withOpacity(0.2),
                    ),
                  ),
                  child: Row(
                    children: [
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          backgroundColor:
                              const Color.fromARGB(255, 0, 122, 255),
                          fixedSize: const Size(110, 28),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                        ),
                        child: const Text(
                          'Email',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          backgroundColor: Colors.white,
                          fixedSize: const Size(110, 28),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                        ),
                        child: const Text(
                          'Phone',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                GestureDetector(// country and region
                  onTap: () {
                    
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(top: 50, left: 15),
                    child: Row(
                      children: const [
                        Expanded(
                          flex: 1,
                          child: Text(
                            'Country/Region',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                        Text(
                          'Thailand',
                          style: TextStyle(
                            fontSize: 16,
                            color: Color.fromARGB(255, 0, 122, 255),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                const Divider(),
                TextField(
                  controller: _textEditingController,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(
                      Icons.person,
                      size: 30,
                    ),
                    hintText: 'Enter your Email',
                    hintStyle:
                        TextStyle(color: Colors.black54.withOpacity(0.4)),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black54.withOpacity(0.06),
                      ),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black54.withOpacity(0.06),
                      ),
                    ),
                    suffixIcon: _showSuffixIcon
                        ? IconButton(
                            icon: Icon(
                              Icons.clear,
                              size: 20,
                              color: Colors.black54.withOpacity(0.1),
                            ),
                            onPressed: () {
                              _textEditingController.clear();
                              _updateSuffixIconVisibility();
                            },
                          )
                        : null,
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  keyboardType: _keyboardType, // Use the dynamic keyboardType
                  obscureText: !_isPasswordVisible,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(
                      Icons.key_sharp,
                      size: 30,
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isPasswordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                        size: 20,
                        color: Colors.black54.withOpacity(0.1),
                      ),
                      onPressed: _togglePasswordVisibility,
                    ),
                    hintText: 'Password',
                    hintStyle:
                        TextStyle(color: Colors.black54.withOpacity(0.4)),
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.black54.withOpacity(0.06))),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.black54.withOpacity(0.06))),
                  ),
                ),
                TextField(
                  keyboardType: _keyboardType, // Use the dynamic keyboardType
                  obscureText: !_isPasswordVisible,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(
                      Icons.key_sharp,
                      size: 30,
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isPasswordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                        size: 20,
                        color: Colors.black54.withOpacity(0.1),
                      ),
                      onPressed: _togglePasswordVisibility,
                    ),
                    hintText: 'Confirm Password',
                    hintStyle:
                        TextStyle(color: Colors.black54.withOpacity(0.4)),
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.black54.withOpacity(0.06))),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.black54.withOpacity(0.06))),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'Your password must have 8-20 character, and include a minimum of two type of number, letter and symbols',
                  style: TextStyle(color: Colors.black54.withOpacity(0.5)),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(children: [
                  SizedBox(
                    width: 220,
                    child: TextField(
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(6),
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                      ],
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: 'Verification Code',
                        hintStyle:
                            TextStyle(color: Colors.black54.withOpacity(0.4)),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.black54.withOpacity(0.06)),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.black54.withOpacity(0.06)),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      backgroundColor: Colors.black54.withOpacity(0.3),
                      fixedSize: const Size(120, 38),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0),
                      ),
                    ),
                    child: const Text(
                      'Get Code',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                      ),
                    ),
                  ),
                ]),
                const SizedBox(
                  height: 45,
                ),
                ElevatedButton(
                  onPressed: () {
                    _register();
                   },
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    backgroundColor: const Color.fromARGB(255, 0, 122, 255),
                    fixedSize: const Size(400, 45),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                  child: const Text(
                    'Register',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ),
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        policy();
                      },
                      icon: Icon(Icons.check_circle_rounded,
                          color: _isPolicy
                              ? Colors.black54.withOpacity(0.1)
                              : Color.fromARGB(255, 0, 122, 255), size: 20),
                    ),
                    Text("I've read and agreed",
                        style:
                            TextStyle(color: Colors.black54.withOpacity(0.6))),
                    const SizedBox(
                      width: 5,
                    ),
                    GestureDetector(
                        child: const Text(
                      'Use Terms',
                      style: TextStyle(color: Color.fromARGB(255, 0, 122, 255)),
                    )),
                    const SizedBox(
                      width: 10,
                    ),
                    GestureDetector(
                      child: const Text(
                        ' Privacy Policy',
                        style:
                            TextStyle(color: Color.fromARGB(255, 0, 122, 255)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
