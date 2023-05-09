import 'package:flutter/material.dart';
import 'package:whater/core/wigets/mainWraper.dart';
import 'package:whater/feature/feature_whater/data/data_source/remote/api_provider.dart';
import 'package:whater/feature/feature_whater/data/repository/repository_weacher_impl.dart';
import 'package:whater/feature/feature_whater/domain/use_cases/get_current_weather_use_case.dart';

void main() {
  runApp( const MyApp());
}

class MyApp extends StatelessWidget {
   const MyApp({super.key});





  @override
  Widget build(BuildContext context) {
    GetCurrentWeatherUseCase getCurrentWeatherUseCase =GetCurrentWeatherUseCase(RepositoryWeatherImpl(ApiProvider()));
    getCurrentWeatherUseCase("minab");
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home:MainWraper(),
    );
  }
}


