
 import 'package:floor/floor.dart';

import '../../../domain/entitis/city_entity.dart';


@dao
 abstract class CityDao{
 @Query('select * from CityEntity')
 Future<List<CityEntity>> getAllCity();
 @Query("select * from CityEntity Where name = :name")
 Future<CityEntity?> findByName(String name);
 @Insert()
 Future<void> addCity(CityEntity cityEntity);

 @Query("delete  from CityEntity Where name = :name")
 Future<void> deleteById(String name);





 }