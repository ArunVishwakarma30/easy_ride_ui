class PredictPlaces {
  String? place_id;
  String? main_text;
  String? secondary_text;
  String? description;


  PredictPlaces(this.place_id, this.main_text, this.secondary_text);

  PredictPlaces.fromJson(Map<String, dynamic> jsonData) {
    place_id = jsonData["place_id"];
    description = jsonData["description"];
    main_text = jsonData["structured_formatting"]["main_text"];
    secondary_text = jsonData["structured_formatting"]["secondary_text"];
  }
}
