import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:carcreator/models/Car.dart';

class CarsDatabase {
  static final CarsDatabase instance = CarsDatabase._init();

  static Database? _database;

  CarsDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('cars.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';
    const integerType = 'INTEGER NOT NULL';

    await db.execute('''
CREATE TABLE $tableCars (
  ${CarFields.id} $idType,
  ${CarFields.type} $textType,
  ${CarFields.soundId} $integerType,
  ${CarFields.bodyColor} $textType,
  ${CarFields.glassColor} $textType,
  ${CarFields.grillColor} $textType,
  ${CarFields.name} $textType,
  ${CarFields.realisticCar} $textType,
       )
    ''');
  }

  Future<Car> create(Car car) async {
    final db = await instance.database;

    final id = await db.insert(tableCars, car.toJson());
    return car.copy(id: id, type: car.type);
  }

  Future<Car> readCar(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      tableCars,
      columns: CarFields.values,
      where: '${CarFields.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Car.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<List<Car>> readAllCars() async {
    final db = await instance.database;

    final result = await db.query(tableCars);

    return result.map((json) => Car.fromJson(json)).toList();
  }

  Future<int> update(Car car) async {
    final db = await instance.database;

    return db.update(
      tableCars,
      car.toJson(),
      where: '${CarFields.id} = ?',
      whereArgs: [car.id],
    );
  }

  Future<int> delete(int id) async {
    final db = await instance.database;

    return await db.delete(
      tableCars,
      where: '${CarFields.id} = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    final db = await instance.database;

    db.close();
  }

}