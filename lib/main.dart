import 'package:easy_ride/controllers/add_vehicle_provider.dart';
import 'package:easy_ride/controllers/auth_provider.dart';
import 'package:easy_ride/controllers/chat_provider.dart';
import 'package:easy_ride/controllers/driver_verification_provider.dart';
import 'package:easy_ride/controllers/image_uploader.dart';
import 'package:easy_ride/controllers/map_provider.dart';
import 'package:easy_ride/controllers/onboarding_provider.dart';
import 'package:easy_ride/controllers/profile_page_provider.dart';
import 'package:easy_ride/firebase_options.dart';
import 'package:easy_ride/views/ui/auth/login.dart';
import 'package:easy_ride/views/ui/bottom_nav_bar/main_page.dart';
import 'package:easy_ride/views/ui/onboarding/onboarding_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'constants/app_constants.dart';
import 'controllers/bottom_navigation_provider.dart';
import 'controllers/find_pool_provider.dart';
import 'controllers/your_rides_provider.dart';

Widget defaultHome = const OnBoardingScreen();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final entryPoint = prefs.getBool("entrypoint") ?? false;
  final loggedIn = prefs.getBool("loggedIn") ?? false;

  if ((entryPoint == true) && (loggedIn == false)) {
    defaultHome = const LoginPage();
  } else if ((entryPoint == true) && (loggedIn == true)) {
    defaultHome = const MainPage();
  }

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => OnBoardingProvider()),
      ChangeNotifierProvider(create: (context) => AuthProvider()),
      ChangeNotifierProvider(create: (context) => BottomNavNotifier()),
      ChangeNotifierProvider(create: (create) => DriverVerificationProvider()),
      ChangeNotifierProvider(create: (create) => AddVehicle()),
      ChangeNotifierProvider(create: (create) => FindPoolProvider()),
      ChangeNotifierProvider(create: (create) => ImageUploader()),
      ChangeNotifierProvider(create: (create) => ProfileProvider()),
      ChangeNotifierProvider(create: (create) => MapProvider()),
      ChangeNotifierProvider(create: (create) => YourRidesProvider()),
      ChangeNotifierProvider(create: (create) => ChatNotifier()),
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
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
          statusBarColor:
              Color(loginPageColor.value)), // Change color as needed
    );

    return GetMaterialApp(
        builder: FToastBuilder(),
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: Color(backgroundGrey.value),
          primarySwatch: Colors.lightBlue,
          iconTheme: IconThemeData(color: Color(loginPageColor.value)),
        ),
        home: defaultHome);
    // home: MainPage());
    // home: const MapScreen());
  }
}

void getValue() async {
  var prefs = await SharedPreferences.getInstance();
  var entrypoint = prefs.get('entrypoint') ?? false;
  if (entrypoint == true) {
    defaultHome = const LoginPage();
  }
}
