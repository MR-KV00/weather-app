import 'package:equatable/equatable.dart';
import 'package:floor/floor.dart';

@entity
class CityEntity{
@PrimaryKey(autoGenerate: true)
final int id;

final String name ;

CityEntity({required this.id,required this.name});


}