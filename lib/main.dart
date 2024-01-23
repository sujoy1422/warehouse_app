import 'package:flutter/material.dart';
import 'package:warehouse_app/views/login_screen.dart';

void main() {
  runApp(const MyApp());
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
          primarySwatch: Colors.blue,
          appBarTheme: AppBarTheme(color: Color.fromARGB(255, 206, 175, 252))),
      title: "WareHouse App",
      // home: HomePage(),
      home: const LoginScreen(),

      supportedLocales: const [
        Locale('en', 'US'),
      ],
    );
  }
}
