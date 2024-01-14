import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:woodefender/screens/auth/login_screen.dart';
import 'package:woodefender/screens/home_screen.dart';
import 'package:woodefender/screens/onboard_screen.dart';
import 'package:woodefender/screens/classification/select_clf_screen.dart';
import 'package:woodefender/services/auth_service.dart';
import 'package:woodefender/services/like_service.dart';
import 'package:woodefender/services/post_service.dart';
import 'package:woodefender/services/comment_service.dart';
import 'firebase_options.dart';

import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;

import 'package:woodefender/screens/main_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  timeago.setLocaleMessages( 'id', timeago.IdMessages(), );

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  void _checkLoginStatus() {
    AuthService().isUserLoggedIn().then((result) {
      setState(() {
        isLoggedIn = result;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => PostService()),
        ChangeNotifierProvider(create: (context) => CommentService()),
        ChangeNotifierProvider(create: (context) => LikeService()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.white, 
            primary: Colors.red,
            onPrimary: Colors.white,
            background: Colors.white,
            surface: Colors.white,
            surfaceTint: Colors.grey,
            onSurface: Colors.black,
          ),
          useMaterial3: true,
          navigationBarTheme: const NavigationBarThemeData(
            labelTextStyle: MaterialStatePropertyAll(
              TextStyle(color: Colors.white)
            ),

            overlayColor: MaterialStatePropertyAll(Colors.black),
            labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected
          ),
          textSelectionTheme: const TextSelectionThemeData(
            cursorColor: Colors.black,
            selectionColor: Colors.red,
            selectionHandleColor: Colors.red
          )
        ),
        home: isLoggedIn ? const MainScreen(pageIndex: 0,) : const OnboardingScreen(),
        routes: {
          '/profile': (context) => const MainScreen(pageIndex: 2,),
          '/main': (context) => const MainScreen(pageIndex: 1,),
          '/select': (context) => const SelectClassificationScreen()
        },
      ),
    );
  }
}