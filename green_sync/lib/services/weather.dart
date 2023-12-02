import 'dart:convert';
import 'package:green_sync/services/watering_services.dart';
import 'package:http/http.dart' as http;

class Weather {
  static double temperature = 0.0;
  static String weatherStatus = "City not found";
  static bool isRainingNotificationSent = false;

  static Future<void> getWeather(String city) async {
    String apiKey = 'bdfbd7f0d44015fcb4a55452958544f8';
    String apiUrl =
        'http://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey';

    try{
      
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);

        // Check if the response contains data for the specified city
        if (data.containsKey('main') &&
            data['main'].containsKey('temp') &&
            data.containsKey('weather') &&
            data['weather'].isNotEmpty) {
          temperature =
              (data['main']['temp'] - 273.15); // Convert temperature to Celsius
          weatherStatus = data['weather'][0]['main'];

          if (weatherStatus == "Rain" || weatherStatus == "Snow")
          {
            WateringServices.waterPlantsInRain();
          }
          else
          {
            isRainingNotificationSent = false;
          }
        } 
        else {
          temperature = 0.0;
          weatherStatus = 'City not found!';
        }
      }
    }
    catch(e)
    { 
      temperature = 0.0;
      weatherStatus = 'No internet!';
    }
  }

}
