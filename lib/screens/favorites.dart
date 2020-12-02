import 'package:bitbox_moviedb/models/movie.dart';
import 'package:bitbox_moviedb/repository/peliculas_favoritas.dart';
import 'package:bitbox_moviedb/repository/sql_favorite_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Favourites extends StatefulWidget {
  @override
  _FavouritesState createState() => _FavouritesState();
}

class _FavouritesState extends State<Favourites> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text(
          "Peliculas favoritas",
          style: TextStyle(
              color: Colors.amber, fontWeight: FontWeight.bold, fontSize: 25.0),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              _deleteAll(context);
              //  Navigator.pushNamed(context, 'favorita',);
            },
          )
        ],
      ),
      body: Container(
        child: _favoriteCreate(),
      ),
    );
  }

  void _removeFavMovie(BuildContext context, Movie movie) {
    setState(() {
      SqlFavoriteDatabase.db.deleteMovieId(movie.id);
      final peliculasFavoritas =
          Provider.of<FavoriteMovies>(context, listen: false);
      peliculasFavoritas.updateProvider();
    });
  } //_removeFavMovie

  void _deleteAll(BuildContext context) {
    showDialog<void>(
      context: context,
      barrierDismissible: true,
      // false = user must tap button, true = tap outside dialog
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          // title: Text('title'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                  '¿Estas seguro que deseas eliminar todas las peliculas de tu lista de favoritos?'),
              Icon(
                Icons.delete,
                size: 100,
              )
            ],
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Si'),
              onPressed: () {
                setState(() {
                  SqlFavoriteDatabase.db.deleteAll();
                  final peliculasFavoritas =
                      Provider.of<FavoriteMovies>(context, listen: false);
                  peliculasFavoritas.updateProvider();
                  Navigator.of(dialogContext).pop();
                });
              },
            ),
            FlatButton(
                child: Text('No'),
                onPressed: () =>
                    Navigator.of(dialogContext).pop() // Dismiss alert dialog
                )
          ],
        );
      },
    );
  } // _deleteFavoriteList

  Widget _favoriteCreate() {
    return FutureBuilder(
      future: SqlFavoriteDatabase.db.getMovies(),
      builder: (BuildContext context, AsyncSnapshot<List<Movie>> snapshot) {
        if (snapshot.hasData) {
          final movies = snapshot.data;
          return ListView(
              children: movies.map((movie) {
            return Column(
              children: [
                ListTile(
                  leading: FadeInImage(
                    image: NetworkImage(movie.getPosterImg()),
                    placeholder: AssetImage('assets/loading-48.gif'),
                    width: 50.0,
                    fit: BoxFit.contain,
                  ),
                  title: Text(movie.title),
                  trailing: IconButton(
                    icon: Icon(
                      Icons.favorite,
                      color: Colors.red,
                    ),
                    onPressed: () {
                      _removeFavMovie(context, movie);
                    },
                  ),
                  onTap: () {
                    //   pelicula.uniqueId = '';
                    Navigator.pushNamed(context, 'detalle', arguments: movie);
                  },
                ),
                SizedBox(
                  height: 5,
                ),
                Divider()
              ],
            );
          }).toList());
        } else {
          return Container(
              height: 400.0, child: Center(child: CircularProgressIndicator()));
        }
      },
    );
  }
}
