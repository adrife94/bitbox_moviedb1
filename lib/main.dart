import 'package:bitbox_moviedb/models/popular.dart';
import 'package:bitbox_moviedb/net/api.dart';
import 'package:bitbox_moviedb/screens/favorites.dart';
import 'package:bitbox_moviedb/screens/pelicula_detalle.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import 'screens/home_page.dart';


void main() {
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => Popular(),
       // dispose: (_, ApiService service) => service.client.dispose(),
        child: MaterialApp(
          initialRoute: '/',
          routes: {
            '/': (_) => HomePage(),
            "detalle": (context) => PeliculaDetalle(),
            "favorita": (context) => Favourites(),
          },
        )
    );
  }
}

