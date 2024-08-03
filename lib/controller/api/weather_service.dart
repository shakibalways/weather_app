import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weather_app/model/weather_data_model.dart';

class WeatherService {
 static fetchWeather() async {
    final response = await http.get(Uri.parse(
        "https://api.openweathermap.org/data/2.5/weather?lat=23.8041&lon=90.4152&appid=b55134d916cf99e8d49690c80c3006ac"));
 try{
if(response.statusCode==200){
  var jsonList = jsonDecode(response.body);
  return WeatherDataModel.fromJson(jsonList);
}else{
  throw Exception('Failed to load Weather data');
}
 }catch(e){
   print(e.toString());
 }
  }
}
