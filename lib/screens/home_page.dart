import 'dart:async';

import 'package:bitbox_moviedb/models/popular.dart';
import 'package:bitbox_moviedb/models/result.dart';
import 'package:bitbox_moviedb/net/api.dart';
import 'package:flutter/material.dart';
import '../models/popular.dart';
import '../net/api.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  ApiService a = ApiService.create(baseUrl: 'https://api.themoviedb.org/3/', page: 1, apiKey: '46514b47bc995b14fd13c566f27ac058');

  final _popularesStreamController = StreamController<Popular>.broadcast();
  // Para poder insertar informacion
  Function(Popular) get popularesSink => _popularesStreamController.sink.add;
// Para escuchar la informacion
  Stream<Popular> get popularesStream => _popularesStreamController.stream;

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

    List<Result> _listMovie = new List();
    Result asa ;
    Popular popular;

  //  Popular p = new Popular();
    final _apiKey = '46514b47bc995b14fd13c566f27ac058';
    int _page = 1;

    final _pageControler = ScrollController();

    final _screenSize = MediaQuery.of(context).size;

    Future<Popular> fetchMovieResult() async {
      popular = await  a.getPopularMovies(_apiKey, _page++).then((value) => popular = value.body);
      popularesSink(popular);
      print(popular.results.toString());
      return popular;
      //  Function(List<Result>) get popularesSink => _popularesStreamController.sink.add;
    }

    _pageControler.addListener(() {
      if (_pageControler.position.pixels >=
          _pageControler.position.maxScrollExtent) {

          fetchMovieResult();

        // setState(() {
        // });
      }
    });

    a.getPopularMovies(_apiKey, _page);
    fetchMovieResult();


    return StreamBuilder(
      stream: popularesStream,
      // future: Provider.of<ApiService>(context).getPopularMovies(_apiKey, _page),
      builder: (context, snapshot) {
      //  if (snapshot.connectionState == ConnectionState.done) {

        if (snapshot.hasData) {
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
       );
     }

      },
    );
  } // _swiperTarjetas

}


