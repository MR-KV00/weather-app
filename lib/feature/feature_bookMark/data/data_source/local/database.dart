
import 'dart:async';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'package:whater/feature/feature_bookMark/data/data_source/local/dao.dart';
import 'package:whater/feature/feature_bookMark/domain/entitis/city_entiti.dart';


part 'database.g.dart'; // the generated code will be there

@Database(version: 1, entities: [CityEntity])
abstract class CityDataBase extends FloorDatabase {
  CityDao get cityDao;
}