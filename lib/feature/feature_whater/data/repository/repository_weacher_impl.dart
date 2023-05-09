import 'package:dio/dio.dart';
import 'package:whater/core/resource/data_state.dart';
import 'package:whater/feature/feature_whater/data/data_source/remote/api_provider.dart';
import 'package:whater/feature/feature_whater/data/model/current_city_model.dart';
import 'package:whater/feature/feature_whater/domain/entitis/current_city_entity.dart';
import 'package:whater/feature/feature_whater/domain/repository/repository_weather.dart';

class RepositoryWeatherImpl extends RepositoryWeather{
  ApiProvider apiProvider;
  RepositoryWeatherImpl(this.apiProvider);

  @override
  Future<DataState<CurrentCityEntity>> fetchCurrentWeatherData(String city) async{

    try{
      Response response =await apiProvider.callCurrentWeather(city);

      if(response.statusCode==200){
        CurrentCityEntity currentCityEntity =CurrentCityModel.fromJson(response.data);
        return DataSuccess(currentCityEntity);
      }else{
        return const DataFailed("somthing went problem");
      }


    }catch(e){
      return const DataFailed("please check your connection");
    }

  }

}