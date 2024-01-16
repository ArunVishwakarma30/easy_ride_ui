import 'dart:convert';

SearchRidesReqModel searchRidesReqModelFromJson(String str) => SearchRidesReqModel.fromJson(json.decode(str));

String searchRidesReqModelToJson(SearchRidesReqModel data) => json.encode(data.toJson());

class SearchRidesReqModel {
  final String departure;
  final String destination;
  final int seatsRequired;
  final DateTime schedule;

  SearchRidesReqModel({
    required this.departure,
    required this.destination,
    required this.seatsRequired,
    required this.schedule,
  });

  factory SearchRidesReqModel.fromJson(Map<String, dynamic> json) => SearchRidesReqModel(
    departure: json["departure"],
    destination: json["destination"],
    seatsRequired: json["seatsRequired"],
    schedule: DateTime.parse(json["schedule"]),
  );

  Map<String, dynamic> toJson() => {
    "departure": departure,
    "destination": destination,
    "seatsRequired": seatsRequired,
    "schedule": "${schedule.year.toString().padLeft(4, '0')}-${schedule.month.toString().padLeft(2, '0')}-${schedule.day.toString().padLeft(2, '0')}",
  };
}
