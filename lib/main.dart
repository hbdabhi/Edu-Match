import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_demo/LoginPage.dart';
import 'package:flutter/material.dart';

import 'HomePage/Homepage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp( MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primaryColor: Colors.teal,
          appBarTheme: AppBarTheme(
            color: Colors.tealAccent
          ),
          scaffoldBackgroundColor : Colors.lightBlue[50],
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
          textTheme: TextTheme(bodyMedium: TextStyle(color: Colors.black87)),
          inputDecorationTheme: InputDecorationTheme(
            filled: true,
            fillColor: Colors.grey[300],
            contentPadding: EdgeInsets.symmetric(vertical: 10,horizontal: 20),
            border: OutlineInputBorder(
              borderRadius:BorderRadius.circular(15),

            )
          )
      ),
      home: LoginPage(),
    );
  }
}
