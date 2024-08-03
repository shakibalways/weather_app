import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/controller/api/weather_service.dart';
import 'package:weather_app/model/weather_data_model.dart';

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

class WeatherDetail extends StatelessWidget {
  final WeatherDataModel weather;
  final String formattedTime;
  final String formattedDate;
  const WeatherDetail(
      {super.key,
      required this.weather,
      required this.formattedTime,
      required this.formattedDate});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          weather.name,
          style: const TextStyle(
              fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        Text(
          "${weather.temperature.current.toStringAsFixed(2)}° N",
          style: const TextStyle(
              fontSize: 35, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        if (weather.weather.isNotEmpty)
          Text(
            weather.weather[0].main,
            style: const TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        const SizedBox(
          height: 30,
        ),
        Text(
          formattedDate,
          style: const TextStyle(
              fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        Text(
          formattedTime,
          style: const TextStyle(
              fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        const SizedBox(
          height: 30,
        ),
        Image.asset(
          "assets/images/cloudys.png",
          height: 250,
          fit: BoxFit.fitHeight,
        ),
        const SizedBox(
          height: 20,
        ),
        Container(
          height: 250,
          decoration: BoxDecoration(
            color: Colors.deepPurple,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.wind_power,
                          color: Colors.white,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        weatherInfoCard(
                            title: "Wind", value: "${weather.wind} km/h")
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.sunny,
                          color: Colors.white,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        weatherInfoCard(
                            title: "Max Temp",
                            value:
                                "${weather.maxTemperature.toStringAsFixed(2)} °C"),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.wind_power,
                          color: Colors.white,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        weatherInfoCard(
                            title: "Min Temp",
                            value:
                                "${weather.minTemperature.toStringAsFixed(2)} °C"),
                      ],
                    ),
                  ],
                ),
                const Divider(
                  thickness: 2,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.water_drop,
                          color: Colors.amber,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        weatherInfoCard(
                            title: "Humidity", value: "${weather.humidity}%"),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.air,
                          color: Colors.amber,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        weatherInfoCard(
                            title: "Pressure",
                            value: "${weather.pressure} hPa"),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.leaderboard,
                          color: Colors.amber,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        weatherInfoCard(
                            title: "Min Temp",
                            value:
                                "${weather.minTemperature.toStringAsFixed(2)} °C"),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  Column weatherInfoCard({required String title, required String value}) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.w500, fontSize: 16),
        ),
        Text(
          title,
          style: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.w700, fontSize: 18),
        ),
      ],
    );
  }
}
