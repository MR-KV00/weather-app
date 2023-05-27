
import '../../../../core/params/forecast_params.dart';
import '../../../../core/resource/data_state.dart';
import '../../data/model/suggest_city_model.dart';
import '../entitis/current_city_entity.dart';
import '../entitis/forecast_days_entity.dart';

abstract class RepositoryWeather{

  Future<DataState<CurrentCityEntity>> fetchCurrentWeatherData(String city);


  Future<DataState<ForecastDaysEntity>> fetchForcastWeatherData(ForecastParams params);

  Future<List<Data>> fetchSuggestWeatherData(String prefix);




}