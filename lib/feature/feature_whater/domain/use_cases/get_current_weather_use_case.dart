
import 'package:whater/core/usecase/use_case.dart';
import 'package:whater/feature/feature_whater/domain/entitis/current_city_entity.dart';
import 'package:whater/feature/feature_whater/domain/repository/repository_weather.dart';

import '../../../../core/resource/data_state.dart';

class GetCurrentWeatherUseCase extends UseCase<DataState<CurrentCityEntity>,String>{
  RepositoryWeather repositoryWeather ;
  GetCurrentWeatherUseCase(this.repositoryWeather);

  @override
  Future<DataState<CurrentCityEntity>> call(String cityName) {
    return repositoryWeather.fetchCurrentWeatherData(cityName);
  }


}