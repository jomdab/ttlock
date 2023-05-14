import 'package:flutter/material.dart';
import 'package:ttlock_flutter_example/phurin/register.dart';


class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _isPasswordVisible = false;
  TextInputType _keyboardType = TextInputType.text;

  

  final TextEditingController _textEditingController = TextEditingController();
  bool _showSuffixIcon = false;

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
        title: Row(
          children: const [
            SizedBox(width: 150),
            Text(
              'Login',
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const RegisterPage()),
                );

               
              },
              child: const Center(
                child: Text('Register'),
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
                const SizedBox(height: 50),
                Image.asset(
                  'assets/image/ttlockLogo.png',
                  width: 100,
                ),
                const SizedBox(height: 25),
                TextField(
                  controller: _textEditingController,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(
                      Icons.person,
                      size: 30,
                    ),
                    hintText: 'Phone Number or Email',
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
                Row(
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.check_circle_rounded,
                          color: Colors.black54.withOpacity(0.1), size: 20),
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
                const SizedBox(
                  height: 45,
                ),
                ElevatedButton(
                  onPressed: null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey.shade600,
                    fixedSize: const Size(400, 45),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                  child: const Text(
                    'Login',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  child: const Text(
                    'Forgot Password?',
                    style: TextStyle(color: Color.fromARGB(255, 0, 122, 255)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
