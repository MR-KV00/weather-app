

import 'package:flutter/cupertino.dart';
import '../../domain/entitis/forecast_days_entity.dart';

@immutable
abstract class FwStatus {}


class FwLoading extends FwStatus{}

class FwCompleted extends FwStatus{
  final ForecastDaysEntity forecastDaysEntity;
  FwCompleted(this.forecastDaysEntity);
}

class FwError extends FwStatus{
  final String message;
  FwError(this.message);
}