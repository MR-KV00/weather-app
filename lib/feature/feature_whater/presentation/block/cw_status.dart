
import 'package:flutter/cupertino.dart';
import 'package:whater/feature/feature_whater/domain/entitis/current_city_entity.dart';

 @immutable
 abstract class CwStatus {}

 class CwLoading extends CwStatus{}

 class CwCompleted extends CwStatus{
   final CurrentCityEntity currentCityEntity;
   CwCompleted(this.currentCityEntity);
}

 class CwError extends CwStatus{
   final String message;
   CwError(this.message);
}