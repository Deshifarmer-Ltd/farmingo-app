import 'package:flutter/material.dart';

import 'app/home/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        searchBarTheme: const SearchBarThemeData(
            hintStyle:
         WidgetStatePropertyAll(TextStyle(fontSize: 14)),
            shadowColor:  WidgetStatePropertyAll(Colors.transparent),
          padding: WidgetStatePropertyAll(EdgeInsets.all(8.0)),
            backgroundColor: WidgetStatePropertyAll(Colors.white),
            shape: WidgetStatePropertyAll(RoundedRectangleBorder(
              side: BorderSide(color: Colors.grey),
                borderRadius: BorderRadius.all(Radius.circular(10))))),
        appBarTheme: const AppBarTheme(
            backgroundColor: Colors.transparent,
            iconTheme: IconThemeData(color: Colors.white)),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        textButtonTheme: const TextButtonThemeData(
          style: ButtonStyle(
            backgroundColor: WidgetStatePropertyAll(Color(0xFF16A34A)),
            shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(5)))),
            foregroundColor: WidgetStatePropertyAll(Colors.white),
          ),
        ),
        useMaterial3: true,
      ),
      home: HomePage(),
    );
  }
}
