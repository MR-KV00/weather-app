// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorCityDataBase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$CityDataBaseBuilder databaseBuilder(String name) =>
      _$CityDataBaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$CityDataBaseBuilder inMemoryDatabaseBuilder() =>
      _$CityDataBaseBuilder(null);
}

class _$CityDataBaseBuilder {
  _$CityDataBaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$CityDataBaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$CityDataBaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<CityDataBase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$CityDataBase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$CityDataBase extends CityDataBase {
  _$CityDataBase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  CityDao? _cityDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `CityEntity` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `name` TEXT NOT NULL)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  CityDao get cityDao {
    return _cityDaoInstance ??= _$CityDao(database, changeListener);
  }
}

class _$CityDao extends CityDao {
  _$CityDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _cityEntityInsertionAdapter = InsertionAdapter(
            database,
            'CityEntity',
            (CityEntity item) =>
                <String, Object?>{'id': item.id, 'name': item.name});

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<CityEntity> _cityEntityInsertionAdapter;

  @override
  Future<List<CityEntity>> getAllCity() async {
    return _queryAdapter.queryList('select * from CityEntity',
        mapper: (Map<String, Object?> row) =>
            CityEntity(row['name'] as String));
  }

  @override
  Future<CityEntity?> findByName(String name) async {
    return _queryAdapter.query('select * from CityEntity Where name = ?1',
        mapper: (Map<String, Object?> row) => CityEntity(row['name'] as String),
        arguments: [name]);
  }

  @override
  Future<void> deleteById(String name) async {
    await _queryAdapter.queryNoReturn('delete  from CityEntity Where name = ?1',
        arguments: [name]);
  }

  @override
  Future<void> addCity(CityEntity cityEntity) async {
    await _cityEntityInsertionAdapter.insert(
        cityEntity, OnConflictStrategy.abort);
  }
}
