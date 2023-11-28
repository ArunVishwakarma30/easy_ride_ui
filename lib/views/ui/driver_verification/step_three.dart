import 'package:easy_ride/constants/app_constants.dart';
import 'package:easy_ride/views/add_vehicle/add_vehicle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Step3 extends StatefulWidget {
  const Step3({Key? key}) : super(key: key);

  @override
  State<Step3> createState() => _Step3State();
}

class _Step3State extends State<Step3> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    TabController tabController =
        TabController(length: 2, vsync: this, animationDuration: Duration.zero);
    double width = MediaQuery.of(context).size.width;
    return SizedBox(
      // Tofix : fix this height relate problem, (Automatically get the height of the rendered widgets)
      height: 1200,
      child: Column(
        children: [
          Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            elevation: 5,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.black12,
              ),
              child: TabBar(
                indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.black45),
                controller: tabController,
                isScrollable: true,
                labelPadding: EdgeInsets.symmetric(horizontal: width * 0.09),
                labelColor: Colors.white,
                unselectedLabelColor: Colors.black,
                onTap: (index) {
                  print(index);
                },
                tabs: const [
                  Tab(
                    child: Text(
                      "Car/Auto Rikshaw",
                    ),
                  ),
                  Tab(
                    child: Text("Bike/ Scooter "),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
              child: TabBarView(
            controller: tabController,
            physics: const NeverScrollableScrollPhysics(),
            children: [
             AddVehicle(),
              Container(
                color: Colors.blueGrey,
              )
            ],
          ))
        ],
      ),
    );
  }
}
