import 'package:bitbox_moviedb/models/result.dart';
import 'package:bitbox_moviedb/repository/sql_favorite_database.dart';
import 'package:flutter/material.dart';


class FavoriteMovies with ChangeNotifier {

   final List<Result> _listaPeliculas = [];


  PeliculasFavoritas() {     // El factory revisa si ya existe una instancia, si existe devuelve la instancia, sino la crea
    cargardatos();
  }

  List<Result> get listaPeliculas => _listaPeliculas;

  set listaPeliculas(List<Result> value) {
    _listaPeliculas.clear();
    _listaPeliculas.addAll(value);
  //  DBProvider.db.getPeliculas().then((value) => _listaPeliculas.add(value);
    notifyListeners();

  }

  void updateProvider() {
    cargardatos();
    notifyListeners();
  }

  Future<List<Result>> cargardatos() async {
  listaPeliculas = await SqlFavoriteDatabase.db.getMovies();
}

}