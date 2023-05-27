import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:whater/core/params/forecast_params.dart';
import 'package:whater/core/resource/data_state.dart';
import 'package:whater/feature/feature_whater/presentation/block/cw_status.dart';
import 'package:whater/feature/feature_whater/presentation/block/fw_status.dart';

import '../../domain/use_cases/get_current_weather_use_case.dart';
import '../../domain/use_cases/get_forecast_weather.dart';



part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetCurrentWeatherUseCase getCurrentWeatherUseCase;
  final GetForecastWeatherUseCase getForecastWeatherUseCase;
  HomeBloc(this.getCurrentWeatherUseCase, this.getForecastWeatherUseCase) : super(HomeState(cwStatus: CwLoading(), fwStatus: FwLoading())) {

    on<LoadCwEvent>((event, emit) async {
      emit(state.copyWith(newCwStatus: CwLoading()));


      DataState dataState = await getCurrentWeatherUseCase(event.cityName);

      if( dataState is DataSuccess){
        emit(state.copyWith(newCwStatus: CwCompleted(dataState.data)));
      }
      if( dataState is DataFailed){
        emit(state.copyWith(newCwStatus:CwError(dataState.error!)));
      }



    });

    on<LoadFwEvent>((event, emit) async{
      emit(state.copyWith(newFwStatus: FwLoading()));


      DataState dataState = await getForecastWeatherUseCase (event.params);


      if(dataState is DataSuccess){
        emit(state.copyWith(newFwStatus: FwCompleted(dataState.data)));

      }
      if(dataState is DataFailed){}

      emit(state.copyWith(newFwStatus: FwError(dataState.error!)));

    });
  }
}
