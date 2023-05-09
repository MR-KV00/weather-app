
import '../../../../core/resource/data_state.dart';
import '../entitis/current_city_entity.dart';

abstract class RepositoryWeather{

  Future<DataState<CurrentCityEntity>> fetchCurrentWeatherData(String city);


}