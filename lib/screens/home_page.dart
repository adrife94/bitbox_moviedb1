import 'package:bitbox_moviedb/global.dart';
import 'package:bitbox_moviedb/models/popular.dart';
import 'package:bitbox_moviedb/net/api.dart';
import 'package:bitbox_moviedb/repository/result_repository.dart';
import 'package:bitbox_moviedb/widget/card_swiper_widget.dart';
import 'package:chopper/chopper.dart';
import 'package:chopper/chopper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:provider/provider.dart';

import '../models/popular.dart';
import '../models/popular.dart';
import '../models/popular.dart';
import '../models/popular.dart';
import '../models/popular.dart';
import '../models/popular.dart';
import '../net/api.dart';
import '../net/api.dart';
import '../net/api.dart';
import '../net/api.dart';
import '../repository/resource.dart';
import '../repository/resource.dart';
import '../repository/resource.dart';
import '../repository/resource.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
  //  Popular p = new Popular();
    final _apiKey = '46514b47bc995b14fd13c566f27ac058';
    int _page = 1;

    final _pageControler = ScrollController();

    final _screenSize = MediaQuery.of(context).size;

    _pageControler.addListener(() {
      if (_pageControler.position.pixels >=
          _pageControler.position.maxScrollExtent) {
        print('Cargar $_page');

    //    Global().api.getPopularMovies(_apiKey, _page);

       // Provider.of<ApiService>(context).getPopularMovies(_apiKey, _page);
        print('Cargar $_page');

      //  Global().api.getPopularMovies(_apiKey, _page);

      /*  ResultRepository result = new ResultRepository();
        ResultRepository.getCollectionResource("https://api.themoviedb.org/3/movie/popular?api_key=46514b47bc995b14fd13c566f27ac058&language=es_ES&page=1");
*/
     //   setState(() {  });



        //   Provider.of<ApiService>(context, listen: false).getPopularMovies().then((value) => null);
      }

    });

    // return Consumer<Resource<Popular>>(
    //   builder: (),
    //   child: FutureBuilder<Response<Popular>>(
    //     // 2
    //     future: Provider.of<ApiService>(context).getPopularMovies(_apiKey, _page),
    //     builder: (context, snapshot) {
    //       // 3
    //       if (snapshot.connectionState == ConnectionState.done) {
    //         // 4
    //         if (snapshot.hasError) {
    //           return Center(
    //             child: Text(
    //               snapshot.error.toString(),
    //               textAlign: TextAlign.center,
    //               textScaleFactor: 1.3,
    //             ),
    //           );
    //         }
    //
    //         final popular = snapshot.data.body;
    //
    //         return ListView.builder(
    //             controller: _pageControler,
    //             padding: EdgeInsets.only(top: 5.0),
    //             itemCount: popular.results.length,
    //             itemBuilder: (context, index) {
    //               return Column(
    //                 children: [
    //                   ListTile(
    //                     leading: Hero(
    //                       tag: popular.results[index].id,
    //                       child: ClipRRect(
    //                         child: FadeInImage(
    //                           image:
    //                           NetworkImage(popular.results[index].getPosterImg()),
    //                           placeholder:
    //                           AssetImage('assets/loading-48.gif'),
    //                           width: 50.0,
    //                           fit: BoxFit.contain,
    //                         ),
    //                       ),
    //                     ),
    //                     title: Text(popular.results[index].title.toString()),
    //                     trailing: IconButton(
    //                         icon: Icon(
    //                           Icons.favorite,
    //                           color: Colors.blue,
    //                         )
    //                     ),
    //                     //    trailing: _comparatorStreamSQL( context, pelicula, listaFavoritos),
    //                     onTap: () {
    //                       //   pelicula.uniqueId = '';
    //                       Navigator.pushNamed(context, 'detalle',
    //                           arguments: popular.results[index]);
    //                     },
    //                   ),
    //                   SizedBox(
    //                     height: 5,
    //                   ),
    //                   Divider()
    //                 ],
    //               );
    //             });
    //       } else {
    //         return Center(
    //           child: CircularProgressIndicator(),
    //         );
    //       }
    //     },
    //   ),
    // );


    return FutureBuilder<Response<Popular>>(
      // 2
      future: Provider.of<ApiService>(context).getPopularMovies(_apiKey, _page),
      builder: (context, snapshot) {
        // 3
        if (snapshot.connectionState == ConnectionState.done) {
          // 4
          if (snapshot.hasError) {
            return Center(
              child: Text(
                snapshot.error.toString(),
                textAlign: TextAlign.center,
                textScaleFactor: 1.3,
              ),
            );
          }

          final popular = snapshot.data.body;

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


// return snapshot.hasData ? CardSwiper( movies: snapshot.data ) : Center();