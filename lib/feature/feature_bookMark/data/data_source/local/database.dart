
import 'dart:async';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import '../../../domain/entitis/city_entity.dart';
import 'dao.dart';

part 'database.g.dart'; // the generated code will be there

@Database(version: 1, entities: [CityEntity])
abstract class AppDatabase extends FloorDatabase {
  CityDao get cityDao;
}