import 'package:easy_ride/controllers/onboarding_provider.dart';
import 'package:easy_ride/views/ui/onboarding/onboarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'constants/app_constants.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => OnBoardingProvider())
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          // colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          // useMaterial3: true,
          scaffoldBackgroundColor: Color(backgroundGrey.value),
          primarySwatch: Colors.grey,
          iconTheme: IconThemeData(color: Color(accentGreen.value))),
      home: const OnBoardingScreen(),
    );
  }
}
