import 'package:woodefender/screens/auth/register_screen.dart';
import 'package:woodefender/screens/auth/success_screen.dart';
import 'package:woodefender/screens/main_screen.dart';
import 'package:woodefender/services/auth_service.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
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
    _passwordController.addListener(checkAllFieldsFilled);
  }

  void checkAllFieldsFilled() {
    if (_emailController.text.isNotEmpty && _passwordController.text.isNotEmpty) {
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
                    'Selamat Datang',
                    style: TextStyle(
                      color: Colors.black,
                      height: 1,
                      fontSize: 31,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  const SizedBox(height: 8,),
                  const Text(
                    '#stop_sexualViolance',
                    style: TextStyle(
                      height: 1,
                      color: Colors.red,
                      fontSize: 15,
                      fontWeight: FontWeight.w500
                    ),
                  ),
                  const SizedBox(height: 42,),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        SizedBox(
                          width: width,
                          child: TextFormField(
                            style: const TextStyle(
                              color: Colors.black
                            ),
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
                                color: Colors.black
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
                            style: const TextStyle(
                              color: Colors.black
                            ),
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
                                color: Colors.black
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
                    height: 18.0,
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Lupa Password?',
                        style: TextStyle(
                          color: Colors.black,
                          height: 1,
                          fontSize: 14,
                          fontWeight: FontWeight.w500
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 18.0,
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
                      
                        final message = await AuthService().login(
                          email: _emailController.text,
                          password: _passwordController.text,
                        );
                      
                        setState(() {
                          _isLoading = false;
                        });
                      
                        if (message!.contains('Success')) {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => const SuccesScreen(type: 'Login',),
                            ),
                          );
                        } else {
                          setState(() {
                            errorMessage = message;
                          });
                        }
                        
                      }
                    },
                    child: Text(
                      'Masuk',
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
                          'Masuk dengan Google',
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
                        'Belum mempunyai akun? ',
                        style: TextStyle(
                          height: 1,
                          fontSize: 14,
                          color: Colors.black,
                          fontWeight: FontWeight.w500
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).popUntil((route) => route.isFirst);
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => const RegisterScreen(),
                            ),
                          );
                        },
                        child: const Text(
                          'Daftar',
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