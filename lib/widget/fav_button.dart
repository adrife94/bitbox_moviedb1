

import 'package:bitbox_moviedb/design/app_colors.dart';
import 'package:bitbox_moviedb/models/result.dart';
import 'package:bitbox_moviedb/repository/peliculas_favoritas.dart';
import 'package:flutter/material.dart';

Widget comparatorStreamSQL(context, Result pelicula, FavoriteMovies listaFavoritos) {
  if (listaFavoritos.listaPeliculas.isNotEmpty) {
    for (int i = 0; i <= listaFavoritos.listaPeliculas.length - 1; i++) {
      if (listaFavoritos.listaPeliculas[i].id == pelicula.id) {
        return IconButton(
          icon: Icon(
            Icons.favorite,
            color: AppColors.custom_red,
          ),
          onPressed: () {
          //  mostrarAlertParaBorrar(context, listaFavoritos, pelicula);
          },
        );
      }
    }
  }

  return IconButton(
    icon: Icon(
      Icons.favorite,
      color: Colors.blue,
    ),
    onPressed: () {
   //   _mostrarAlert(context, listaFavoritos, pelicula);
    },
  );
}

