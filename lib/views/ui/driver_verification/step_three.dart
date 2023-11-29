import 'package:easy_ride/constants/app_constants.dart';
import 'package:easy_ride/views/ui/driver_verification/add_vehicle/addBike.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'add_vehicle/add_car.dart';

class Step3 extends StatefulWidget {
  const Step3(
      {Key? key,
      required this.vehicleRegistrationNumber,
      required this.exceptionController,
      required this.featuresController,
      required this.makeCategoryController,
      required this.onTabIndexChanged,
      required this.onCarSelected})
      : super(key: key);
  final TextEditingController vehicleRegistrationNumber;
  final TextEditingController exceptionController;
  final TextEditingController featuresController;
  final TextEditingController makeCategoryController;
  final Function(int) onTabIndexChanged;
  final Function(Map<String, String>) onCarSelected; // Callback fun

  @override
  State<Step3> createState() => _Step3State();
}

class _Step3State extends State<Step3> with TickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController =
        TabController(length: 2, vsync: this, animationDuration: Duration.zero);
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return SizedBox(
      // Tofix : fix this height relate problem, (Automatically get the height of the rendered widgets)
      height: 650,
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
                  widget.onTabIndexChanged(index);
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
              AddCar(
                vehicleRegistrationNumber: widget.vehicleRegistrationNumber,
                exception: widget.exceptionController,
                makeCategory: widget.makeCategoryController,
                features: widget.featuresController,
                onCarSelected: widget.onCarSelected, // Pass the callback fu,
              ),
              AddBike(
                vehicleRegistrationNumber: widget.vehicleRegistrationNumber,
                makeCategory: widget.makeCategoryController,
                features: widget.featuresController,
              ),
            ],
          ))
        ],
      ),
    );
  }
}
