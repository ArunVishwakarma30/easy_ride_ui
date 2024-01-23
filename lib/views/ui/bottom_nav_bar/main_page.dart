import 'package:easy_ride/controllers/bottom_navigation_provider.dart';
import 'package:easy_ride/views/ui/bottom_nav_bar/inbox_page.dart';
import 'package:easy_ride/views/ui/bottom_nav_bar/profile_page.dart';
import 'package:easy_ride/views/ui/bottom_nav_bar/offer_pool_page.dart';
import 'package:easy_ride/views/ui/bottom_nav_bar/rides_page.dart';
import 'package:easy_ride/views/ui/find_pool/find_pool_page.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:provider/provider.dart';

import '../../../controllers/map_provider.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List pages = const [
    InboxPage(),
    OfferPool(),
    FindPoolPage(),
    RidesPage(),
    ProfilePage()
  ];
  var items = <Widget>[];

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    items = [
      Icon(
        Icons.chat_rounded,
        size: width * 0.07,
      ),
      Icon(
        Icons.add_circle_outline_outlined,
        size: width * 0.07,
      ),
      Icon(
        Icons.search,
        size: width * 0.07,
      ),
      Icon(
        Icons.directions_bike_sharp,
        size: width * 0.07,
      ),
      Icon(
        size: width * 0.07,
        Icons.person_pin,
      ),
    ];
    return Consumer<BottomNavNotifier>(builder: (context, navNotifier, child) {
      final mapProvider = Provider.of<MapProvider>(context);
      return Scaffold(
        extendBody: true,
        backgroundColor: const Color.fromARGB(255, 234, 228, 228),
        body: pages[navNotifier.currentIndex],
        bottomNavigationBar: CurvedNavigationBar(
          onTap: (value) => {
            navNotifier.setCurrentIndex(value),
            mapProvider.setDirectionsNull(),
            mapProvider.setWaiting(false)
          },
          items: items,
          height: 60,
          index: navNotifier.currentIndex,
          backgroundColor: const Color.fromARGB(255, 234, 228, 228),
        ),
      );
    });
  }
}
