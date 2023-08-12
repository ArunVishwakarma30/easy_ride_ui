import 'package:easy_ride/controllers/auth_provider.dart';
import 'package:easy_ride/controllers/onboarding_provider.dart';
import 'package:easy_ride/views/ui/auth/login.dart';
import 'package:easy_ride/views/ui/onboarding/onboarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'constants/app_constants.dart';

Widget defaultHome = const OnBoardingScreen();

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => OnBoardingProvider()),
      ChangeNotifierProvider(create: (context) => AuthProvider()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Future<bool> _checkEntryPoint() async {
    var prefs = await SharedPreferences.getInstance();
    var entrypoint = prefs.getBool('entrypoint') ?? false;
    return entrypoint;
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
          statusBarColor:
              Color(loginPageColor.value)), // Change color as needed
    );

    return FutureBuilder<bool>(
      future: _checkEntryPoint(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator(); // Show a loading indicator if data is being fetched
        } else if (snapshot.hasError) {
          return Scaffold(body: Center(child: Text('Error fetching data')));
        } else {
          defaultHome = snapshot.data == true
              ? const LoginPage()
              : const OnBoardingScreen();
          return MaterialApp(
            title: 'Flutter Demo',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              scaffoldBackgroundColor: Color(backgroundGrey.value),
              primarySwatch: Colors.grey,
              iconTheme: IconThemeData(color: Color(loginPageColor.value)),
            ),
            home: defaultHome,
          );
        }
      },
    );
  }
}

void getValue() async {
  var prefs = await SharedPreferences.getInstance();
  var entrypoint = prefs.get('entrypoint') ?? false;
  if (entrypoint == true) {
    defaultHome = const LoginPage();
  }
}