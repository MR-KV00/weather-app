
import 'package:whater/feature/feature_whater/domain/repository/repository_weather.dart';
import '../../../../core/usecase/use_case.dart';
import '../../data/model/suggest_city_model.dart';

class GetSuggestionCityUseCase implements UseCase<List<Data>, String>{
  final RepositoryWeather _weatherRepository;
  GetSuggestionCityUseCase(this._weatherRepository);

  @override
  Future<List<Data>> call(String params) {
    return _weatherRepository.fetchSuggestWeatherData(params);
  }

}