import 'package:farmingo/app/home/home_binding.dart';
import 'package:farmingo/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'app/home/home_page.dart';
import 'common/shred_pref.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPrefs().init();
  runApp(const MyApp());
  configLoading();


  //todo:--> order page details
  //todo:-------------------------------------> logout assure msg


  //todo: images are loading again and again shows in flutter dev tools



  //todo: network connectivity
  //todo: search


  //todo:---> need to add zone

  //todo:---> LogOut

  //todo:----> scree util add and examine the footer of all reg/login/forget page in realme /benco mobile app




}

void configLoading() {
  EasyLoading.instance
    ..indicatorWidget = const SpinKitWave(
      color: Colors.green, // Primary color for the wave
      size: 50.0,
      itemCount: 6,
    )
    ..backgroundColor = Colors.white // Background for the loading box
    ..textColor = Colors.green // Text color matching the primary color
    ..maskColor = Colors.black.withOpacity(0.5) // Semi-transparent black mask
    ..userInteractions = false // Disable interaction while loading
    ..maskType = EasyLoadingMaskType.custom; // Use the custom mask color
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
        fontFamily: 'Poppins',
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

          contentPadding: const EdgeInsets.symmetric(vertical: 8,horizontal: 10),
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
      builder: EasyLoading.init(),
      initialRoute: AppRoutes.homePath,
      getPages: AppRoutes.routes,
      initialBinding: HomeBindings(),
    );
  }
}
