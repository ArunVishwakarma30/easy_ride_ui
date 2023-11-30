import 'package:flutter/material.dart';

//header, navigation bar, and prominent elements that require a strong visual presence
const primaryBlue = Color(0xFF192E5B);

// backgrounds or elements that need a deeper emphasis.
const darkShade = Color(0xFF0F1E39);

// subtle variations, such as dividers or shadows.
const lightShade = Color(0xFF007dfe);
const textColor = Color.fromARGB(255, 77, 83, 111);

const accentGreen = Color(0xFF27AE60); // for btns or click icons
const farkGreen = Color(0xFF1D864C); // for pressed or hover state
const lightGreen = Color(0xFF3AD074); // for for subtle highlight and animation

const backgroundGrey = Color(0xFFF2F2F2); //
const backGroundLight = Color(0xFFCCCCCC); //
const backGrounddark = Color(0xFFFFFFFF); //

const loginPageColor = Color(0xFF00a5ff);
const lightLoginBack = Color.fromARGB(255, 89, 173, 219);
const darkHeading = Color(0xff054550);
const lightBorder = Color(0xFFDCDCDC);

final MaterialColor customColor = MaterialColor(0xFF00a5ff, {
  50: Color(0xFF00a5ff),
  100: Color(0xFF00a5ff),
  200: Color(0xFF00a5ff),
  300: Color(0xFF00a5ff),
  400: Color(0xFF00a5ff),
  500: Color(0xFF00a5ff),
  600: Color(0xFF00a5ff),
  700: Color(0xFF00a5ff),
  800: Color(0xFF00a5ff),
  900: Color(0xFF00a5ff),
});

String regEx = r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$';

String map_key = "AIzaSyCpBewCrd7Um9Ll4xs8Ddq3GZCCvCRMQ_E";

// Dropdown options for driver verification step two widget:
List<String> documentOptions = [
  'Select Document',
  'Passport',
  'Aadhaar Card',
  'PAN Card',
];

// Car Model names and image paths
List<Map<String, String>> carTypeAndImg = [
  {'Name': "Select Type", "Img": "assets/images/model_car.jpg"},
  {'Name': "Hatch Back", "Img": "assets/images/hatch_back.png"},
  {'Name': "Sedan", "Img": "assets/images/sedan_car.png"},
  {'Name': "Suv", "Img": "assets/images/suv_car.png"},
  {'Name': "Premium", "Img": "assets/images/premium_car.png"},
  {'Name': "Passenger Auto Rickshaw", "Img": "assets/images/auto_rikshaw.png"},
];

// Bike Model names and image paths
List<Map<String, String>> bikeTypeAndImg = [
  {'Name': "Select Type", "Img": "assets/images/model_bike.jpg"},
  {'Name': "Bike", "Img": "assets/images/bike.png"},
  {'Name': "Scooter", "Img": "assets/images/scooter.jpeg"},
];
