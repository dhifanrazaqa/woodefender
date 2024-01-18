import 'package:flutter/material.dart';
import 'package:woodefender/screens/auth/login_screen.dart';
import 'package:woodefender/screens/auth/success_screen.dart';
import 'package:woodefender/screens/home_screen.dart';
import 'package:woodefender/screens/main_screen.dart';
import 'package:woodefender/services/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Color daftarBtnColor = Colors.grey[200]!;
  Color daftarTextBtnColor = Colors.grey;

  bool _isLoading = false;
  bool _isLoadingGoogle = false;
  String errorMessage = '';

  @override
  void initState() {
    super.initState();

    _emailController.addListener(checkAllFieldsFilled);
    _nameController.addListener(checkAllFieldsFilled);
    _passwordController.addListener(checkAllFieldsFilled);
  }

  void checkAllFieldsFilled() {
    if (_emailController.text.isNotEmpty && _nameController.text.isNotEmpty && _passwordController.text.isNotEmpty) {
      setState(() {
        daftarBtnColor = Colors.black;
        daftarTextBtnColor = Colors.white;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 60, left: 15, right: 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Sign Up',
                    style: TextStyle(
                      height: 1,
                      fontSize: 31,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  const SizedBox(height: 8,),
                  const Wrap(
                    alignment: WrapAlignment.spaceAround,
                    children: [
                      Text(
                        "Let's participate in ",
                        style: TextStyle(
                          height: 1,
                          fontSize: 15,
                          fontWeight: FontWeight.w500
                        ),
                      ),
                      Text(
                        '#stop_sexualViolance',
                        style: TextStyle(
                          height: 1,
                          color: Colors.red,
                          fontSize: 15,
                          fontWeight: FontWeight.w500
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 42,),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        SizedBox(
                          width: width,
                          child: TextFormField(
                            cursorColor: Colors.black,
                            controller: _nameController,
                            keyboardType: TextInputType.name,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter some text';
                              }
                              return null;
                            },
                            decoration: const InputDecoration(
                              labelText: 'Full Name',
                              contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                              labelStyle: TextStyle(
                                color: Colors.grey
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black)
                              ),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black)
                              )
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 16.0,
                        ),
                        SizedBox(
                          width: width,
                          child: TextFormField(
                            cursorColor: Colors.black,
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter some text';
                              }
                              if (!RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$').hasMatch(value)) {
                                return 'Please enter a valid email address';
                              }
                              return null;
                            },
                            decoration: const InputDecoration(
                              labelText: 'Email',
                              contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                              labelStyle: TextStyle(
                                color: Colors.grey
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black)
                              ),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black)
                              )
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 16.0,
                        ),
                        SizedBox(
                          width: width,
                          child: TextFormField(
                            cursorColor: Colors.black,
                            controller: _passwordController,
                            obscureText: true,
                            keyboardType: TextInputType.visiblePassword,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your password';
                              }
                              if (value.length < 8) {
                                return 'Password must be at least 8 characters';
                              }
                              return null;
                            },
                            decoration: const InputDecoration(
                              labelText: 'Password',
                              contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                              labelStyle: TextStyle(
                                color: Colors.grey
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black)
                              ),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black)
                              )
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 24.0,
                  ),
                  _isLoading ? const CircularProgressIndicator(color: Colors.black,) : ElevatedButton(
                    style: ButtonStyle(
                      shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      fixedSize: MaterialStatePropertyAll(Size(width, 40)),
                      backgroundColor: MaterialStatePropertyAll(daftarBtnColor),
                    ),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        setState(() {
                          _isLoading = true;
                        });
                        final message = await AuthService().registration(
                          email: _emailController.text,
                          username: _nameController.text,
                          password: _passwordController.text,
                        );
                        setState(() {
                          _isLoading = false;
                        });
                        if (message!.contains('Success')) {
                          Navigator.of(context).popUntil((route) => route.isFirst);
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(builder: (context) => const SuccesScreen(type: "Daftar",)));
                        } else {
                          setState(() {
                            errorMessage = message;
                          });
                        }
                      }
                    },
                    child: Text(
                      'Sign Up',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: daftarTextBtnColor,
                        fontSize: 14
                      ),
                    ),
                  ),
                  if (errorMessage != '')
                    Column(
                      children: [
                        const SizedBox(height: 8,),
                        Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.symmetric(horizontal: 14),
                          width: width,
                          height: 40,
                          decoration: BoxDecoration(
                            color: Colors.red[100],
                            borderRadius: BorderRadius.circular(10)
                          ),
                          child: Text(
                            errorMessage,
                            style: const TextStyle(
                              color: Colors.red
                            ),
                          ),
                        ),
                      ],
                    ),
                  const SizedBox(height: 8,),
                  Image.asset('assets/images/Line break.png'),
                  const SizedBox(height: 8,),
                  _isLoadingGoogle ? const CircularProgressIndicator(color: Colors.black,) : ElevatedButton(
                    style: ButtonStyle(
                      foregroundColor: MaterialStatePropertyAll(Colors.amber),
                      shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      elevation: MaterialStatePropertyAll(2),
                      fixedSize: MaterialStatePropertyAll(Size(width, 40)),
                      backgroundColor: const MaterialStatePropertyAll(Color.fromARGB(255, 255, 255, 255)),
                    ),
                    onPressed: () async {
                      setState(() {
                        _isLoadingGoogle = true;
                      });
                      await AuthService().signInWithGoogle();
                      Navigator.of(context).popUntil((route) => route.isFirst);
                      Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (context) => const SuccesScreen(type: "Login",)));
                      setState(() {
                        _isLoadingGoogle = false;
                      });
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image.asset('assets/images/google logo.png', width: 24,),
                        const Text(
                          'Login With Google',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                            fontSize: 14
                          ),
                        ),
                        SizedBox(width: 25,),
                      ],
                    ),
                  ),
                  SizedBox(height: height * 0.2,),
                  Wrap(
                    alignment: WrapAlignment.spaceAround,
                    children: [
                      const Text(
                        'Already have an account? ',
                        style: TextStyle(
                          height: 1,
                          fontSize: 14,
                          fontWeight: FontWeight.w500
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).popUntil((route) => route.isFirst);
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => const LoginScreen(),
                            ),
                          );
                        },
                        child: const Text(
                          'Sign In',
                          style: TextStyle(
                            height: 1,
                            color: Colors.blue,
                            fontSize: 14,
                            fontWeight: FontWeight.w500
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}