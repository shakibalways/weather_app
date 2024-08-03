// class WeatherDataModel{
//   final String name;
//   final Temperature temperature;
//   final int humidity;
//   final int wind;
//   final double maxTemperature;
//   final double minTemperature;
//   final int pressure;
//   final int sealevel;
//   final List<WeatherInfo> weather;
//   WeatherDataModel( {required this.name,required this.temperature,required this.humidity,required this.wind,required this.maxTemperature,required this.minTemperature,required this.pressure,required this.sealevel,required this.weather,});
//
//   factory WeatherDataModel.fromJson(Map<String, dynamic>json){
//     return WeatherDataModel(name: json['name'], temperature: Temperature.fromJson(['main']), humidity: json['main']['humidity'], wind: Wind.fromJson(json['wind']), maxTemperature: json['main']['temp_max'],minTemperature:json['main']['temp_min'] , pressure: json['main']['pressure'], sealevel: json['main']['sea_level'] ?? 0, weather: List<WeatherInfo>.from(json['weather'].map((weather)=>WeatherInfo.fromJson(weather))));
//   }
//
// }
// class WeatherInfo{
//   final String main;
//   WeatherInfo({required this.main});
//   factory WeatherInfo.fromJson(Map<String, dynamic>json){
//     return WeatherInfo(main: json['main']);
//   }
// }
//
// class Temperature{
//   final double current;
//   Temperature({required this.current})
//   factory Temperature.fromJson(Map<String, dynamic>json){
//     return Temperature(current: json['temp']);
//   }
// }
// class Wind {
//   final double speed;
//   Wind({required this.speed})
//   factory Wind.fromJson(Map<String,dynamic>json){
//     return Wind (speed: json['speed']);
//   }
// }
class WeatherDataModel {
  final String name;
  final Temperature temperature;
  final int humidity;
  final double wind; // Wind should be double for consistency with the API response
  final double maxTemperature;
  final double minTemperature;
  final int pressure;
  final int seaLevel;
  final List<WeatherInfo> weather;

  WeatherDataModel({
    required this.name,
    required this.temperature,
    required this.humidity,
    required this.wind,
    required this.maxTemperature,
    required this.minTemperature,
    required this.pressure,
    required this.seaLevel,
    required this.weather,
  });

  factory WeatherDataModel.fromJson(Map<String, dynamic> json) {
    return WeatherDataModel(
      name: json['name'],
      temperature: Temperature.fromJson(json['main']),
      humidity: json['main']['humidity'],
      wind: json['wind']['speed'], // Direct access
      maxTemperature: (json['main']['temp_max'] -273.15),
      minTemperature: (json['main']['temp_min'] -273.15),
      pressure: json['main']['pressure'],
      seaLevel: json['main']['sea_level'] ?? 0,
      weather: List<WeatherInfo>.from(
        json['weather'].map((weather) => WeatherInfo.fromJson(weather)),
      ),
    );
  }
}

class WeatherInfo {
  final String main;
  WeatherInfo({required this.main});
  factory WeatherInfo.fromJson(Map<String, dynamic> json) {
    return WeatherInfo(
      main: json['main'],
    );
  }
}
class Temperature {
  final double current;
  Temperature({required this.current});
  factory Temperature.fromJson(Map<String, dynamic> json) {
    return Temperature(
      current: json['temp'] - 273.15,
    );
  }
}

class Wind {
  final double speed;
  Wind({required this.speed});
  factory Wind.fromJson(Map<String, dynamic> json) {
    return Wind(
      speed: json['speed'],
    );
  }
}