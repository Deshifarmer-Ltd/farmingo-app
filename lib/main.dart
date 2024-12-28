import 'package:farmingo/app/home/home_binding.dart';
import 'package:farmingo/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'app/home/home_page.dart';

void main() {
  runApp(const MyApp());


  //todo: controller need to dynamic for confirm order popup
  //todo: order page table add
  //todo: order page dynamic

  //todo: need to add zone

  //todo:---> shred pref for user
  //todo:---> forget password


  //todo: network connectivity
  //todo: search

  //todo: initial page while page is fetching stage


}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
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
        elevatedButtonTheme: const ElevatedButtonThemeData( style: ButtonStyle(
          backgroundColor: WidgetStatePropertyAll(Color(0xFF16A34A)),
          shape: WidgetStatePropertyAll(RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(5)))),
          foregroundColor: WidgetStatePropertyAll(Colors.white),
        ),),

        inputDecorationTheme: InputDecorationTheme(

          contentPadding: const EdgeInsets.symmetric(vertical: 8,horizontal: 10), // Adjust vertical padding
          prefixIconColor: Colors.grey,
          labelStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          hintStyle: TextStyle(fontSize: 12, color: Colors.grey.shade600),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.green, width: 2.0),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey, width: 1.0),
          ),
          errorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red, width: 1.0),
          ),
        ),
        useMaterial3: true,
      ),
      home: const HomePage(),
      initialRoute: AppRoutes.forgetPassPath,
      getPages: AppRoutes.routes,
      initialBinding: HomeBindings(),
    );
  }
}
