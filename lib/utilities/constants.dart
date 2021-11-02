import 'package:flutter/material.dart';

const kTempTextStyle = TextStyle(
  fontFamily: 'Spartan MB',
  fontSize: 50.0,
  color: Colors.yellow,
);

const kMessageTextStyle = TextStyle(
  fontFamily: 'Spartan MB',
  fontSize: 40.0,
  color: Colors.yellow,
);

const kButtonTextStyle = TextStyle(
  fontSize: 30.0,
  fontFamily: 'Spartan MB',
  color: Colors.yellow,
);

const kConditionTextStyle = TextStyle(
  fontSize: 70.0,
  color: Colors.yellow,
);

const apiKey = "ba38f593bcea6a1d56f5ec9337142750";
const openWeatherMapUrl = "https://api.openweathermap.org/data/2.5/weather";

const kTextFieldInputDecoration = InputDecoration(
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(20)),
    borderSide: BorderSide.none,
  ),
  filled: true,
  fillColor: Colors.white,
  icon: Icon(
    Icons.location_city,
    color: Colors.yellow,
  ),
  hintText: "Enter city name",
  hintStyle: TextStyle(color: Colors.grey),
);