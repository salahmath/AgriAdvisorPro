// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, non_constant_identifier_names, avoid_types_as_parameter_names

import 'package:app_commerce/ui/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp( options: FirebaseOptions(
      appId: '1:895335742886:android:04033d7d1e855a19122367',
      projectId: 'app-commerce-675ab',
      messagingSenderId: '895335742886',
      apiKey: "AIzaSyDYNpcJJZBsJRaBECqW1rCOIHAWPgiEo0E",
      authDomain: "app-commerce-675ab.firebaseapp.com",
      databaseURL: "https://app-commerce-675ab-default-rtdb.firebaseio.com",
      storageBucket: "app-commerce-675ab.appspot.com",
    
    ),
    
);

  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(375, 812),
      builder: (BuildContext context, Widget? widget) { // Correction de la signature
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'AgriAdvisorPro',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: SplashScreen(),
        );
      },
    );
  }
}
