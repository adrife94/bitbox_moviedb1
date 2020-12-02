import 'dart:io';

import 'package:bitbox_moviedb/models/movie.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class SqlFavoriteDatabase {
  static Database _database;
  static final SqlFavoriteDatabase db = SqlFavoriteDatabase._();

  SqlFavoriteDatabase._(); //Esto es un constructor privado

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await initDB();
    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'MoviesDB.db');
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute(
          'CREATE TABLE Movie (id INTEGER PRIMARY KEY, title TEXT, posterPath TEXT);');
      // 'CREATE TABLE Movie (id INTEGER PRIMARY KEY, popularity REAL, voteCount INTEGER, voteAverage REAL, title TEXT, originalLanguage TEXT, overview TEXT, backdropPath TEXT, releaseDate TEXT, posterPath TEXT);'
    });
  }

  // Crear registros

  newMovieRaw(Movie movie) async {
    final db = await database;
    try {
      final res = await db.rawInsert(
          "INSERT INTO Movie (id, title, posterPath) VALUES (${movie.id}, '${movie.title}', '${movie.posterPath}' );");
      // "INSERT INTO Movie (id, popularity, voteCount, voteAverage, title, originalLanguage, overview, backdropPath, releaseDate, posterPath) VALUES (${movie.id}, ${movie.popularity}, ${movie.voteCount}, ${movie.voteAverage}, '${movie.title}', '${movie.originalLanguage}', '${movie.overview}', '${movie.backdropPath}', '${movie.releaseDate}', '${movie.posterPath}' );"
      print(res.toString());
      return true;
    } catch (Exception) {
      return false;
    }
  }

// Obtener informacion
  Future<bool> getMovieId(int id) async {
    final db = await database;
    final response = await db.query('Movie', where: 'id= ?', whereArgs: [id]);
    return response.isNotEmpty ? true : false;
  }

  Future<List<Movie>> getMovies() async {
    final db = await database;
    final response = await db.query('Movie');

    List<Movie> list = response.isNotEmpty
        ? response.map((peli) => Movie.fromJsonMap2(peli)).toList()
        : [];

    return list;
  }

// Eliminar registro
  Future<int> deleteMovieId(int id) async {
    final db = await database;
    final res = await db.delete('Movie', where: 'id = ?', whereArgs: [id]);
    print('Delete One');
    return res;
  }

// Eliminar todos los registros
  Future<int> deleteAll() async {
    final db = await database;
    final res = await db.rawDelete('DELETE FROM Movie');
    return res;
  }
}
