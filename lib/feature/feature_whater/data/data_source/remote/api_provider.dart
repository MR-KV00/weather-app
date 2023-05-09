
import 'package:dio/dio.dart';
import 'package:whater/core/utils/constanse.dart';

class ApiProvider{

  final Dio _dio =Dio();
  var apiKey = Constants.apiKeys1;
  var baseUrl = Constants.baseUrl;

 Future<dynamic>callCurrentWeather(cityName) async{
   var response =  await _dio.get(
     '$baseUrl /data/2.5/weather',
      queryParameters:{
        'q' :cityName,
        'appid' : apiKey,
        'units' : 'metric'
      }
   );
   print(response);
   return response;

 }




}