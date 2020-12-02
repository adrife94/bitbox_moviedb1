import 'package:bitbox_moviedb/models/movie.dart';
import 'package:bitbox_moviedb/models/popular.dart';
import 'package:bitbox_moviedb/repository/movies_repository.dart';
import 'package:bitbox_moviedb/repository/peliculas_favoritas.dart';
import 'package:bitbox_moviedb/repository/resource.dart';
import 'package:bitbox_moviedb/repository/sql_favorite_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _popularMoviesRes = Resource<List<Movie>>(
      status: Status.working); //Esta es la primera (primeras 20 peliculas)
  final _newPageRes = Resource<Popular>(); //Estas son las que saca despues
  ScrollController _scrollController = new ScrollController();
  var _currentPage = 0;
  Movie movie;
  FavoriteMovies favoriteMovies;

  @override
  void initState() {
    super.initState();

    _popularMoviesRes.addListener(() {
      setState(() {});
    });

    _newPageRes.addListener(() {
      setState(() {
        if (_newPageRes.status == Status.loaded) {
          List<Movie> movies = _popularMoviesRes.data ?? [];
          movies.addAll(_newPageRes.data.results);
          _popularMoviesRes.change(data: movies, status: Status.loaded);
        }
      });
    });

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        setState(() {
          _loadNextPage();
        });
      }
    });

    _loadNextPage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Cine',
            style: TextStyle(
                color: Colors.amber,
                fontWeight: FontWeight.bold,
                fontSize: 25.0),
          ),
          backgroundColor: Colors.deepPurple,
          actions: [
            IconButton(
                icon: Icon(Icons.search),
                onPressed: () {
                  showSearch(context: context, delegate: null, query: '');
                }),
            IconButton(
              icon: Icon(Icons.favorite),
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  'favorita',
                );
              },
            )
          ],
        ),
        body: Container(
          child: Stack(
            children: [
              Center(
                child: ListView.builder(
                  controller: _scrollController,
                  itemCount: _popularMoviesRes.data?.length ?? 0,
                  itemBuilder: (context, index) => Column(
                    children: [
                      ListTile(
                        leading: FadeInImage(
                          image: NetworkImage(
                              _popularMoviesRes.data[index].getPosterImg()),
                          placeholder: AssetImage('assets/loading-48.gif'),
                          width: 50.0,
                          fit: BoxFit.contain,
                        ),
                        title: Text(_popularMoviesRes.data[index].title),
                        trailing: Consumer<FavoriteMovies>(
                            builder: (context, favMovies, child) =>
                                _comparatorStreamSQL(context,
                                    _popularMoviesRes.data[index], favMovies)
                            //     IconButton(
                            //   onPressed: () {
                            //     SqlFavoriteDatabase.db
                            //         .newMovieRaw(_popularMoviesRes.data[index]);
                            //     favoriteMovies.updateProvider();
                            //   },
                            //   icon: Icon(
                            //     Icons.favorite,
                            //     color: Colors.blue,
                            //   ),
                            // ),
                            ),
                        //   trailing: _comparatorStreamSQL(
                        //     context, movie, listaFavoritos),
                        onTap: () {
                          //   pelicula.uniqueId = '';
                          Navigator.pushNamed(context, 'detalle',
                              arguments: _popularMoviesRes.data[index]);
                        },
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Divider()
                    ],
                  ),
                ),
              ),
              // Center(
              //   child: OverlayProgressIndicator(
              //   visible: _popularMoviesRes.status != Status.loaded),
              // )
            ],
          ),
        ));
  }

  void _loadNextPage() {
    _currentPage++;
    MoviesRepository.getPopulars(_currentPage, _newPageRes);
  }

  Widget _comparatorStreamSQL(
      context, Movie movie, FavoriteMovies listaFavoritos) {
    if (listaFavoritos.listaPeliculas.isNotEmpty) {
      for (int i = 0; i <= listaFavoritos.listaPeliculas.length - 1; i++) {
        if (listaFavoritos.listaPeliculas[i].id == movie.id) {
          return IconButton(
            icon: Icon(
              Icons.favorite,
              color: Colors.red,
            ),
            onPressed: () {
              setState(() {
                SqlFavoriteDatabase.db.deleteMovieId(movie.id);
                listaFavoritos.updateProvider();
                Scaffold.of(context).showSnackBar(SnackBar(
                  content: Text(
                      "Se ha eliminado de tu lista de favoritos correctamente"),
                ));
              });

              //  _mostrarAlertParaBorrar(context, listaFavoritos, pelicula);
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
        setState(() {
          SqlFavoriteDatabase.db.newMovieRaw(movie);
          listaFavoritos.updateProvider();
          Scaffold.of(context).showSnackBar(SnackBar(
            content:
                Text("Se ha añadido de tu lista de favoritos correctamente"),
          ));
        });
        //   _mostrarAlert(context, listaFavoritos, pelicula);
      },
    );
  }
}
