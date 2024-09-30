import 'package:clima/screens/city_screen.dart';
import 'package:clima/services/weather.dart';
import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';

class LocationScreen extends StatefulWidget {
  final locationWeather;
  LocationScreen({this.locationWeather});
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weather = WeatherModel();
  int? temperature;
  int? condition;
  String? cityName;
  String? weatherIcon;
  String? weatherMessage;
  @override
  void initState() {
    super.initState();
    updateUI(widget.locationWeather);
  }
  void updateUI (var weatherData) {
    setState(() {
      if(weatherData == null){
        this.temperature = 0;
        weatherIcon = 'Error';
        weatherMessage = 'Unable to get weather data';
        cityName = '';
        return;
      }
      double temperature = weatherData['main']['temp'];
      this.temperature = temperature.toInt();
      condition = weatherData['weather'][0]['id'];
      weatherIcon = weather.getWeatherIcon(condition??0);
      cityName = weatherData['name'];
    });

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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0, left: 20),
                    child: TextButton(
                      onPressed: () async {
                        var weatherData = await weather.getLocationWeather();
                        updateUI(weatherData);
                      },
                      child: Icon(
                        Icons.near_me,
                        size: 50.0,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () async{
                      var typedName = await Navigator.push(context, MaterialPageRoute(builder: (context)=>CityScreen()));
                      if(typedName != null){
                        var weatherData = await weather.getCityWeather(typedName);
                        updateUI(weatherData);
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20.0, right: 20),
                      child: Icon(
                        Icons.location_city,
                        size: 50.0,
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 30.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      '$temperature°',
                      style: kTempTextStyle,
                    ),
                    Text(
                      '${weather.getWeatherIcon(condition?? 0)}',
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.0, bottom: 15),
                child: Text(
                  "${weather.getMessage(temperature??0)} in $cityName!",
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


