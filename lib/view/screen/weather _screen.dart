import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/controller/api/weather_service.dart';
import 'package:weather_app/model/weather_data_model.dart';
import 'package:weather_app/view/screen/weather_info/weather_details.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  WeatherDataModel? weatherInfo;
  bool isLoading = false;
  myWeather() {
    isLoading = false;
    WeatherService.fetchWeather().then((value) {
      setState(() {
        weatherInfo = value;
        isLoading = true;
      });
    }).catchError((error) {
      print(error);
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  void initState() {
    weatherInfo = WeatherDataModel(
        name: 'name',
        temperature: Temperature(current: 0.0),
        humidity: 0,
        wind: 0.0,
        maxTemperature: 0,
        minTemperature: 0,
        pressure: 0,
        seaLevel: 0,
        weather: []);
    myWeather();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String formattedDate =
        DateFormat('EEEE D , MMMM yyyy').format(DateTime.now());
    String formattedTime = DateFormat('hh:mm a').format(DateTime.now());
    return Scaffold(
      backgroundColor: const Color(0xff676BD0),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            isLoading
                ? WeatherDetail(
                    weather: weatherInfo!,
                    formattedTime: formattedTime,
                    formattedDate: formattedDate,
                  )
                : const Center(
                    child: CircularProgressIndicator(
                    color: Colors.white,
                  ))
          ],
        ),
      ),
    );
  }
}


