// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_typing_uninitialized_variables, use_key_in_widget_constructors, prefer_const_constructors_in_immutables, avoid_print, unused_local_variable, unnecessary_string_interpolations, dead_code

import 'package:flutter/material.dart';
import '../utilities/constants.dart';
import '../services/weather.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import '../screens/city_screen.dart';

class LocationScreen extends StatefulWidget {
  final locationWeather;

  LocationScreen({this.locationWeather});

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weather = WeatherModel();

  late int temperature;
  late String weatherIcon;
  late String cityName;
  late String weatherMsg;

  @override
  void initState() {
    super.initState();
    // print(widget.locationWeather);

    updateUI(widget.locationWeather);
  }

  void updateUI(dynamic weatherData) {
    setState(() {
      if (weatherData == null) {
        Alert(
          context: context,
          title: 'Error!',
          desc: 'Please enter a valid City Name.',
        ).show();
        return;
      } else {
        double temp = weatherData["main"]["temp"];
        temperature = temp.toInt();
        weatherMsg = weather.getMessage(temperature);

        var condition = weatherData["weather"][0]["id"];
        weatherIcon = weather.getWeatherIcon(condition);

        cityName = weatherData["name"];

        print(temperature);
        print(condition);
        print(cityName);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/location_background.jpg"),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    TextButton(
                      onPressed: () async {
                        var weatherData = await weather.getLocationWeather();
                        updateUI(weatherData);
                      },
                      child: Icon(
                        Icons.near_me,
                        size: 50.0,
                        color: Colors.white,
                      ),
                    ),
                    TextButton(
                      onPressed: () async {
                        var typedName = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return CityScreen();
                            },
                          ),
                        );
                        // print(typedName);
                        if (typedName != null) {
                          var weatherData =  await weather.getCityWeather(typedName);
                          updateUI(weatherData);
                        } else {
                          Alert(
                            context: context,
                            title: 'Error!',
                            desc: 'Please enter a valid City Name.',
                          ).show();
                          return;
                        }
                      },
                      child: Icon(
                        Icons.location_city,
                        size: 50.0,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(left: 15.0),
                  child: Row(
                    children: <Widget>[
                      Text(
                        '$temperature°',
                        style: kTempTextStyle,
                      ),
                      Text(
                        '$weatherIcon',
                        style: kConditionTextStyle,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 15.0),
                  child: Text(
                    "$weatherMsg in $cityName!",
                    textAlign: TextAlign.right,
                    style: kMessageTextStyle,
                  ),
                ),
              ]),
        ),
      ),
    );
  }
}
