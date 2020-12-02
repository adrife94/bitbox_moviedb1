import 'package:bitbox_moviedb/models/movie.dart';
import 'package:bitbox_moviedb/repository/sql_favorite_database.dart';
import 'package:flutter/material.dart';

class FavoriteMovies with ChangeNotifier {
  final List<Movie> _listaPeliculas = [];

  PeliculasFavoritas() {
    // El factory revisa si ya existe una instancia, si existe devuelve la instancia, sino la crea
    cargardatos();
  }

  List<Movie> get listaPeliculas => _listaPeliculas;

  set listaPeliculas(List<Movie> value) {
    _listaPeliculas.clear();
    _listaPeliculas.addAll(value);
    //  DBProvider.db.getPeliculas().then((value) => _listaPeliculas.add(value);
    notifyListeners();
  }

  void updateProvider() {
    cargardatos();
    notifyListeners();
  }

  Future<List<Movie>> cargardatos() async {
    listaPeliculas = await SqlFavoriteDatabase.db.getMovies();
  }
}
