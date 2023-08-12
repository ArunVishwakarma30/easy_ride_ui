import 'package:easy_ride/views/ui/bottom_nav_bar/inbox_page.dart';
import 'package:easy_ride/views/ui/bottom_nav_bar/profile_page.dart';
import 'package:easy_ride/views/ui/bottom_nav_bar/publish_page.dart';
import 'package:easy_ride/views/ui/bottom_nav_bar/rides_page.dart';
import 'package:easy_ride/views/ui/bottom_nav_bar/search_page.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List pages = const [
    SearchPage(),
    PublishPage(),
    RidesPage(),
    InboxPage(),
    ProfilePage()
  ];
  var items = <Widget>[];

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    items = [
      Icon(
        Icons.search, size: width * 0.08, 
      ),
      const Icon(Icons.add_circle_outline_outlined),
      const Icon(Icons.directions_bike_sharp),
      const Icon(Icons.chat_rounded),
      const Icon(Icons.person_pin),
    ];
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 234, 228, 228),
      body: const Center(child: Text("center"),),
      bottomNavigationBar: CurvedNavigationBar(items: items, backgroundColor: const Color.fromARGB(255,234, 228, 228),),
    );
  }
}
