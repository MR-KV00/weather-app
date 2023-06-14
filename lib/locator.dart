import 'package:get_it/get_it.dart';
import 'package:whater/feature/feature_bookMark/data/data_source/local/database.dart';
import 'package:whater/feature/feature_whater/data/data_source/remote/api_provider.dart';
import 'package:whater/feature/feature_whater/data/repository/repository_weacher_impl.dart';
import 'package:whater/feature/feature_whater/domain/use_cases/get_current_weather_use_case.dart';
import 'package:whater/feature/feature_whater/domain/use_cases/get_forecast_weather.dart';
import 'package:whater/feature/feature_whater/presentation/block/home_bloc.dart';

import 'feature/feature_whater/domain/repository/repository_weather.dart';

GetIt locator =GetIt.instance;

 setup() async{

   var database = await $FloorAppDatabase.databaseBuilder('app_database.db').build();
   locator.registerSingleton<AppDatabase>(database);

  /// api
  locator.registerSingleton<ApiProvider>(ApiProvider());

  /// repository
  locator.registerSingleton<RepositoryWeather>(RepositoryWeatherImpl(locator()));

  /// use case
  locator.registerSingleton<GetCurrentWeatherUseCase>(GetCurrentWeatherUseCase(locator()));
  locator.registerSingleton<GetForecastWeatherUseCase>(GetForecastWeatherUseCase(locator()));

  /// bloc
  locator.registerSingleton<HomeBloc>(HomeBloc(locator(),locator()),);



}



