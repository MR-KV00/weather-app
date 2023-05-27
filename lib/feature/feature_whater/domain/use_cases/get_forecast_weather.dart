

import 'package:whater/core/params/forecast_params.dart';
import 'package:whater/core/resource/data_state.dart';
import 'package:whater/core/usecase/use_case.dart';
import 'package:whater/feature/feature_whater/domain/entitis/forecast_days_entity.dart';
import 'package:whater/feature/feature_whater/domain/repository/repository_weather.dart';

class GetForecastWeatherUseCase extends UseCase<DataState<ForecastDaysEntity>,ForecastParams>{
  RepositoryWeather repositoryWeather;
  GetForecastWeatherUseCase(this.repositoryWeather);

  @override
  Future<DataState<ForecastDaysEntity>> call(ForecastParams params) {

   return repositoryWeather.fetchForcastWeatherData(params) ;
  }









}