import 'package:bitbox_moviedb/global.dart';
import 'package:bitbox_moviedb/models/popular.dart';
import 'package:bitbox_moviedb/repository/movies_repository.dart';
import 'package:bitbox_moviedb/repository/resource.dart';
import 'package:chopper/chopper.dart';
import 'package:flutter/material.dart';

class DataSearch extends SearchDelegate {
  String seleccion;
  final movieRepository = MoviesRepository();
  Resource<Popular> resourcePopular;

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            //   print("click");
            query = "";
          })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Center(
      child: Container(
        height: 100.0,
        width: 100.0,
        color: Colors.blueAccent,
        child: Text(seleccion),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return Container();
    }

    return FutureBuilder(
      future: Global()
          .api
          .getFindMovies('46514b47bc995b14fd13c566f27ac058', 'es-ES', query),
      // future: MoviesRepository.getPopularSearch(resourcePopular, query),
      builder:
          (BuildContext context, AsyncSnapshot<Response<Popular>> snapshot) {
        if (snapshot.hasData) {
          final peliculas = snapshot.data.body.results;
          return ListView(
              children: peliculas.map((pelicula) {
            return ListTile(
              leading: FadeInImage(
                image: NetworkImage(pelicula.getPosterImg()),
                placeholder: AssetImage('assets/img/no-image.jpg'),
                width: 50.0,
                fit: BoxFit.contain,
              ),
              title: Text(pelicula.title),
              subtitle: Text(pelicula.originalTitle),
              onTap: () {
                close(context, null);
                //     peliculas.uniqueId = '';
                Navigator.pushNamed(context, 'detalle', arguments: pelicula);
              },
            );
          }).toList());
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
