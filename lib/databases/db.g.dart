// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'db.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$AppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  SleepDao? _sleepDaoInstance;

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
            'CREATE TABLE IF NOT EXISTS `Sleep` (`dateTime` INTEGER NOT NULL, `startTime` INTEGER NOT NULL, `endTime` INTEGER NOT NULL, `minAsleep` INTEGER NOT NULL, `timeInBed` INTEGER NOT NULL, `rem` INTEGER NOT NULL, `deep` INTEGER NOT NULL, `light` INTEGER NOT NULL, `wake` INTEGER NOT NULL, PRIMARY KEY (`dateTime`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  SleepDao get sleepDao {
    return _sleepDaoInstance ??= _$SleepDao(database, changeListener);
  }
}

class _$SleepDao extends SleepDao {
  _$SleepDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _sleepInsertionAdapter = InsertionAdapter(
            database,
            'Sleep',
            (Sleep item) => <String, Object?>{
                  'dateTime': _dateTimeConverter.encode(item.dateTime),
                  'startTime': _dateTimeConverter.encode(item.startTime),
                  'endTime': _dateTimeConverter.encode(item.endTime),
                  'minAsleep': item.minAsleep,
                  'timeInBed': item.timeInBed,
                  'rem': item.rem,
                  'deep': item.deep,
                  'light': item.light,
                  'wake': item.wake
                }),
        _sleepUpdateAdapter = UpdateAdapter(
            database,
            'Sleep',
            ['dateTime'],
            (Sleep item) => <String, Object?>{
                  'dateTime': _dateTimeConverter.encode(item.dateTime),
                  'startTime': _dateTimeConverter.encode(item.startTime),
                  'endTime': _dateTimeConverter.encode(item.endTime),
                  'minAsleep': item.minAsleep,
                  'timeInBed': item.timeInBed,
                  'rem': item.rem,
                  'deep': item.deep,
                  'light': item.light,
                  'wake': item.wake
                }),
        _sleepDeletionAdapter = DeletionAdapter(
            database,
            'Sleep',
            ['dateTime'],
            (Sleep item) => <String, Object?>{
                  'dateTime': _dateTimeConverter.encode(item.dateTime),
                  'startTime': _dateTimeConverter.encode(item.startTime),
                  'endTime': _dateTimeConverter.encode(item.endTime),
                  'minAsleep': item.minAsleep,
                  'timeInBed': item.timeInBed,
                  'rem': item.rem,
                  'deep': item.deep,
                  'light': item.light,
                  'wake': item.wake
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Sleep> _sleepInsertionAdapter;

  final UpdateAdapter<Sleep> _sleepUpdateAdapter;

  final DeletionAdapter<Sleep> _sleepDeletionAdapter;

  @override
  Future<List<Sleep>> findSleepbyDate(
    DateTime startTime,
    DateTime endTime,
  ) async {
    return _queryAdapter.queryList(
        'SELECT * FROM Sleep WHERE dateTime between ?1 and ?2 ORDER BY dateTime ASC',
        mapper: (Map<String, Object?> row) => Sleep(_dateTimeConverter.decode(row['dateTime'] as int), _dateTimeConverter.decode(row['startTime'] as int), _dateTimeConverter.decode(row['endTime'] as int), row['minAsleep'] as int, row['timeInBed'] as int, row['rem'] as int, row['deep'] as int, row['light'] as int, row['wake'] as int),
        arguments: [
          _dateTimeConverter.encode(startTime),
          _dateTimeConverter.encode(endTime)
        ]);
  }

  @override
  Future<Sleep?> findSleepByDateTime(DateTime targetDateTime) async {
    return _queryAdapter.query('SELECT * FROM Sleep WHERE dateTime =?1',
        mapper: (Map<String, Object?> row) => Sleep(
            _dateTimeConverter.decode(row['dateTime'] as int),
            _dateTimeConverter.decode(row['startTime'] as int),
            _dateTimeConverter.decode(row['endTime'] as int),
            row['minAsleep'] as int,
            row['timeInBed'] as int,
            row['rem'] as int,
            row['deep'] as int,
            row['light'] as int,
            row['wake'] as int),
        arguments: [_dateTimeConverter.encode(targetDateTime)]);
  }

  @override
  Future<List<Sleep>> findAllSleep() async {
    return _queryAdapter.queryList('SELECT * FROM Sleep',
        mapper: (Map<String, Object?> row) => Sleep(
            _dateTimeConverter.decode(row['dateTime'] as int),
            _dateTimeConverter.decode(row['startTime'] as int),
            _dateTimeConverter.decode(row['endTime'] as int),
            row['minAsleep'] as int,
            row['timeInBed'] as int,
            row['rem'] as int,
            row['deep'] as int,
            row['light'] as int,
            row['wake'] as int));
  }

  @override
  Future<Sleep?> findFirstDayInDb() async {
    return _queryAdapter.query(
        'SELECT * FROM Sleep ORDER BY dateTime ASC LIMIT 1',
        mapper: (Map<String, Object?> row) => Sleep(
            _dateTimeConverter.decode(row['dateTime'] as int),
            _dateTimeConverter.decode(row['startTime'] as int),
            _dateTimeConverter.decode(row['endTime'] as int),
            row['minAsleep'] as int,
            row['timeInBed'] as int,
            row['rem'] as int,
            row['deep'] as int,
            row['light'] as int,
            row['wake'] as int));
  }

  @override
  Future<Sleep?> findLastDayInDb() async {
    return _queryAdapter.query(
        'SELECT * FROM Sleep ORDER BY dateTime DESC LIMIT 1',
        mapper: (Map<String, Object?> row) => Sleep(
            _dateTimeConverter.decode(row['dateTime'] as int),
            _dateTimeConverter.decode(row['startTime'] as int),
            _dateTimeConverter.decode(row['endTime'] as int),
            row['minAsleep'] as int,
            row['timeInBed'] as int,
            row['rem'] as int,
            row['deep'] as int,
            row['light'] as int,
            row['wake'] as int));
  }

  @override
  Future<void> insertSleep(Sleep sleep) async {
    await _sleepInsertionAdapter.insert(sleep, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateSleep(Sleep sleep) async {
    await _sleepUpdateAdapter.update(sleep, OnConflictStrategy.replace);
  }

  @override
  Future<void> deleteSleep(Sleep sleep) async {
    await _sleepDeletionAdapter.delete(sleep);
  }
}

// ignore_for_file: unused_element
final _dateTimeConverter = DateTimeConverter();
