import 'dart:io';

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
      required this.onCarSelected,
      required this.onBikeSelected,
      required this.onCarImageUploaded,
      required this.onBikeImageUploaded})
      : super(key: key);
  final TextEditingController vehicleRegistrationNumber;
  final TextEditingController exceptionController;
  final TextEditingController featuresController;
  final TextEditingController makeCategoryController;
  final Function(int) onTabIndexChanged;
  final Function(Map<String, String>) onCarSelected;
  final Function(Map<String, String>) onBikeSelected;
  final Function(File?) onCarImageUploaded;
  final Function(File?) onBikeImageUploaded;

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
                indicatorSize: TabBarIndicatorSize.tab,
                indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.black45,
                ),
                controller: tabController,
                isScrollable: false,
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
                onCarSelected: widget.onCarSelected,
                onImageUploaded: widget.onCarImageUploaded,
              ),
              AddBike(
                vehicleRegistrationNumber: widget.vehicleRegistrationNumber,
                makeCategory: widget.makeCategoryController,
                features: widget.featuresController,
                onBikeSelected: widget.onBikeSelected,
                onImageUploaded: widget.onBikeImageUploaded,
              ),
            ],
          ))
        ],
      ),
    );
  }
}
