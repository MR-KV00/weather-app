import 'package:equatable/equatable.dart';
import 'package:floor/floor.dart';

@Entity()
class CityEntity extends Equatable {
  CityEntity.name(this.name);

  @PrimaryKey(autoGenerate: true)
   int? id;

  final String name;

  @override
  List<Object?> get props => [name];
}
