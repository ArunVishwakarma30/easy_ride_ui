import 'package:easy_ride/constants/app_constants.dart';
import 'package:easy_ride/views/common/app_style.dart';
import 'package:easy_ride/views/common/reuseable_text_widget.dart';
import 'package:easy_ride/views/ui/your_rides/your_rides_list_view.dart';
import 'package:flutter/material.dart';

class RidesPage extends StatefulWidget {
  const RidesPage({super.key});

  @override
  State<RidesPage> createState() => _RidesPageState();
}

class _RidesPageState extends State<RidesPage>
    with SingleTickerProviderStateMixin {
  late TabController _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = TabController(length: 2, vsync: this, initialIndex: 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: ReuseableText(
            text: "Your Rides",
            style: roundFont(22, darkHeading, FontWeight.bold)),
        bottom: TabBar(
          controller: _controller,
          indicatorSize: TabBarIndicatorSize.tab,
          indicatorColor: loginPageColor,
          tabs: [
            Tab(
              child: Text(
                "Created",
                style: roundFont(18, darkHeading, FontWeight.bold),
              ),
            ),
            Tab(
              child: Text(
                "Requested",
                style: roundFont(18, darkHeading, FontWeight.bold),
              ),
            )
          ],
        ),
      ),
      body: TabBarView(
        controller: _controller,
        children: const [
          YourRidesListView(
            rideCreatedListView: true,
            key: PageStorageKey('CreatedTab'),
          ),
          YourRidesListView(
            rideCreatedListView: false,
            key: PageStorageKey('RequestedTab'),
          ),
        ],
      ),
    );
  }
}
