import 'package:easy_ride/controllers/bottom_navigation_provider.dart';
import 'package:easy_ride/controllers/profile_page_provider.dart';
import 'package:easy_ride/models/request/update_one_signal_req_model.dart';
import 'package:easy_ride/services/config.dart';
import 'package:easy_ride/views/ui/bottom_nav_bar/inbox_page.dart';
import 'package:easy_ride/views/ui/bottom_nav_bar/profile_page.dart';
import 'package:easy_ride/views/ui/bottom_nav_bar/offer_pool_page.dart';
import 'package:easy_ride/views/ui/bottom_nav_bar/rides_page.dart';
import 'package:easy_ride/views/ui/find_pool/find_pool_page.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:provider/provider.dart';

import '../../../controllers/map_provider.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  List pages = const [
    InboxPage(),
    OfferPool(),
    FindPoolPage(),
    RidesPage(),
    ProfilePage()
  ];
  var items = <Widget>[];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');

      if (message.notification != null) {
        print('Message also contained a notification: ${message.notification}');
      }
    });
    initNotificationService(context);
  }

  Future<void> initNotificationService(BuildContext context) async {
    // Initialize ProfileProvider
    final profileProvider =
        Provider.of<ProfileProvider>(context, listen: false);

    String oneSignalUserId =
        ''; // Declare a variable to store OneSignal user ID

    await OneSignal.shared.getDeviceState().then((value) {
      if (value != null) {
        oneSignalUserId =
            value.userId ?? '';
      }
    });

    // Call updateOneSignalId method with the OneSignal user ID
    profileProvider
        .updateOneSignalId(UpdateOneSignalIdReq(oneSignalId: oneSignalUserId));
  }

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
