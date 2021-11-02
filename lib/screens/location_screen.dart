import 'package:clima/screens/city_screen.dart';
import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';
import 'package:clima/services/weather.dart';

class LocationScreen extends StatefulWidget {
  final locationWeather;

  LocationScreen({this.locationWeather});

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weatherModel = WeatherModel();

  int temperature;
  String weatherIcon;
  String cityName;
  String weatherMessage;

  void updateUI(dynamic weatherData) {
    setState(() {
      if (weatherData == null) {
        temperature = 0;
        weatherIcon = "Error";
        weatherMessage = "Unable to get weather data.";
        cityName = "";
        return;
      }
      double temp = weatherData["main"]["temp"];
      temperature = temp.toInt();
      weatherMessage = weatherModel.getMessage(temperature);
      var condition = weatherData["weather"][0]["id"];
      weatherIcon = weatherModel.getWeatherIcon(condition);
      cityName = weatherData["name"];
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    updateUI(widget.locationWeather);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(bottom: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(left: 15.0),
                        child: IconButton(
                          color: Colors.yellow,
                          onPressed: () async {
                            var weatherData =
                                await weatherModel.getLocationWeather();
                            updateUI(weatherData);
                          },
                          icon: Icon(
                            Icons.refresh,
                            size: 50.0,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 15),
                        child: IconButton(
                          color: Colors.yellow,
                          onPressed: () async {
                            var typedName = await Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return CityScreen();
                            }));
                            if (typedName != null) {
                              var data =
                                  await weatherModel.getCityWeather(typedName);
                              updateUI(data);
                            }
                          },
                          icon: Icon(
                            Icons.location_city,
                            size: 50.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10,),
                Padding(
                  padding: EdgeInsets.fromLTRB(15.0, 15.0, 0, 0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          '$temperature°',
                          style: kTempTextStyle,
                        ),
                      ),
                      Text(
                        weatherIcon,
                        style: kConditionTextStyle,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 15.0, 15.0, 0),
                  child: Text(
                    "$weatherMessage in $cityName!",
                    textAlign: TextAlign.right,
                    style: kMessageTextStyle,
                  ),
                ),
                SizedBox(height: 10,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
