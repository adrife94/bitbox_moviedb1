import 'dart:async';

import 'package:bitbox_moviedb/models/popular.dart';
import 'package:bitbox_moviedb/models/result.dart';
import 'package:bitbox_moviedb/net/api.dart';
import 'package:bitbox_moviedb/repository/peliculas_favoritas.dart';
import 'package:bitbox_moviedb/repository/resource.dart';
import 'package:bitbox_moviedb/repository/result_repository.dart';
import 'package:bitbox_moviedb/repository/sql_favorite_database.dart';
import 'package:bitbox_moviedb/widget/fav_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/popular.dart';
import '../net/api.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  ApiService a = ApiService.create(/*baseUrl: 'https://api.themoviedb.org/3/',*/ page: 1, apiKey: '46514b47bc995b14fd13c566f27ac058');

  final _popularesStreamController = StreamController<Resource<Popular>>.broadcast();
  // Para poder insertar informacion
  Function(Resource<Popular>) get popularesSink => _popularesStreamController.sink.add;
// Para escuchar la informacion
  Stream<Resource<Popular>> get popularesStream => _popularesStreamController.stream;

  @override
  Widget build(BuildContext context) {
    Popular popular = new Popular();
    // ApiService apiService = new ApiService();

      return Scaffold(
          appBar: AppBar(
            title: Text('Cine', style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold, fontSize: 25.0),),
            backgroundColor: Colors.deepPurple,
            actions: [
              IconButton(
                  icon: Icon(Icons.search),
                  onPressed: (){

                    print("hola");
                    /* showSearch(
                   context: context,
                   delegate: null,
                   query: '' );*/
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
            child: Center(
              child: _swiperCards(context),
              /* child:  Consumer<Popular>(
             builder: (context, popular, child){
             return _swiperCards(context);
             }
        ),*/
            ),
          ));
    }

  Widget _swiperCards(BuildContext context) {

  //  List<Result> _listMovie = new List();

    final Resource<Popular> recursoPopularess = Resource();
    //if (recursoPopularess.data.)

    Popular popular;

    final _apiKey = '46514b47bc995b14fd13c566f27ac058';
    int _page = 1;

    final _pageControler = ScrollController();

    final _screenSize = MediaQuery.of(context).size;

    Future<Popular> fetchMovieResult() async {
      popular = await  a.getPopularMovies(_apiKey, _page++).then((value) => popular = value.body);
      ResultRepository.getPopulars(recursoPopularess);
      popularesSink(recursoPopularess);
      return popular;
    }
    recursoPopularess.addListener(() {
      switch (recursoPopularess.status) {
        case Status.loaded:
          print("hola");
          print(recursoPopularess.data.results.first.title);
          break;
        case Status.error:
          print("aadios");
      }
    });

    _pageControler.addListener(() {
      if (_pageControler.position.pixels >=
          _pageControler.position.maxScrollExtent) {
          fetchMovieResult();
      }
    });

    a.getPopularMovies(_apiKey, _page);
    fetchMovieResult();

    return Center(
      child: CircularProgressIndicator(),
    );

   /* return StreamBuilder(
      stream: popularesStream,
      builder: (context, snapshot) {
        if (popular.results == null) {
            print("hola");
        }

        if (snapshot.hasData || popular.results != null) {
          print(popular.results.toString());
          Popular p = snapshot.data;
          return ListView.builder(
              controller: _pageControler,
              padding: EdgeInsets.only(top: 5.0),
              itemCount: popular.results.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    ListTile(
                      leading: Hero(
                        tag: popular.results[index].id,
                        child: ClipRRect(
                          child: FadeInImage(
                            image:
                            NetworkImage(popular.results[index].getPosterImg()),
                            placeholder:
                            AssetImage('assets/loading-48.gif'),
                            width: 50.0,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      title: Text(popular.results[index].title.toString()),
                      trailing: IconButton(
                          icon: Icon(
                            Icons.favorite,
                            color: Colors.blue,
                          )
                      ),
                      //    trailing: _comparatorStreamSQL( context, pelicula, listaFavoritos),
                      onTap: () {
                        //   pelicula.uniqueId = '';
                        Navigator.pushNamed(context, 'detalle',
                            arguments: popular.results[index]);
                      },
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Divider()
                  ],
                );
              });
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );*/


    /*return StreamBuilder(
      stream: popularesStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          final moviesList = snapshot.data;
          // List<Result> mList= popular.results;
          return Consumer<FavoriteMovies>(
              builder: (context, listaFavoritos, child) => ListView(
                controller: _pageControler,
                padding: EdgeInsets.only(top: 5.0),
                children: moviesList.map((pelicula) {
                  return Column(
                    children: [
                      ListTile(
                        leading: Hero(
                          tag: pelicula.id,
                          child: ClipRRect(
                            child: FadeInImage(
                              image:
                              NetworkImage(pelicula.getPosterImg()),
                              placeholder:
                              AssetImage('assets/loading-48.gif'),
                              width: 50.0,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        title: Text(pelicula.title.toString()),
                       *//* trailing: IconButton(
                            icon: Icon(
                              Icons.favorite,
                              color: Colors.blue,
                            )
                        ),*//*
                            trailing: comparatorStreamSQL( context, pelicula, listaFavoritos),
                        onTap: () {
                          //   pelicula.uniqueId = '';
                          Navigator.pushNamed(context, 'detalle',
                              arguments: pelicula);
                        },
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Divider()
                    ],
                  );
                }),
          ));

        } else {
       return Center(
         child: CircularProgressIndicator(),
       );*/
   /*  }

      },
    );*/
  } // _swiperTarjetas

/*  void _mostrarAlertParaBorrar(BuildContext context, FavoriteMovies peliculasFavoritas, Result pelicula) {
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
                  '¿Estas seguro que deseas eliminar \"${pelicula.title}\" de la lista de favoritos?'),
              FadeInImage(
                  placeholder: AssetImage("assets/loading-48.gif"),
                  image: NetworkImage(pelicula.getPosterImg()))
            ],
          ),

          actions: <Widget>[
            FlatButton(
              child: Text('Si'),
              onPressed: () {
                setState(() {
                  SqlFavoriteDatabase.db.deletePMovieId(pelicula.id);
                  peliculasFavoritas.updateProvider();
                  Navigator.of(dialogContext).pop();
                  Scaffold.of(context).showSnackBar(SnackBar(
                    content: Text(
                        "Se ha eliminado de tu lista de favoritos correctamente"),
                  ));
                });
                // Dismiss alert dialog

                if (SqlFavoriteDatabase.db.deletePMovieId(pelicula.id) == true) {
                  Scaffold.of(context).showSnackBar(SnackBar(
                    content: Text("Se ha añadido a tu lista de favoritos correctamente"),
                  ));
                }

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
  }

  void _mostrarAlert(BuildContext context, FavoriteMovies peliculasFavoritas, Result pelicula) {
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
                  '¿Estas seguro que deseas añadir \"${pelicula.title}\" a la lista de favoritos?'),
              FadeInImage(
                  placeholder: AssetImage("assets/loading-48.gif"),
                  image: NetworkImage(pelicula.getPosterImg()))
            ],
          ),

          actions: <Widget>[
            FlatButton(
              child: Text('Si'),
              onPressed: () {
                setState(() {
                  SqlFavoriteDatabase.db.newMovieRaw(pelicula);
                  peliculasFavoritas.updateProvider();
                  Navigator.of(dialogContext).pop();
                  Scaffold.of(context).showSnackBar(SnackBar(
                    content: Text(
                        "Se ha añadido a tu lista de favoritos correctamente"),
                  ));
                });
                // Dismiss alert dialog

                if (SqlFavoriteDatabase.db.newMovieRaw(pelicula) == true) {
                  Scaffold.of(context).showSnackBar(SnackBar(
                    content: Text("Se ha añadido a tu lista de favoritos correctamente"),
                  ));
                }

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
  }*/

}


