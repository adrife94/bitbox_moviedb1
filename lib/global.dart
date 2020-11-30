
import 'dart:ui';
import 'package:bitbox_moviedb/models/result.dart';
import 'package:bitbox_moviedb/repository/resource.dart';
import 'net/api.dart';

/// Global scope app singleton, for initializations needed app wide
class Global {
  // ignore: public_member_api_docs
  factory Global() {
    _global ??= Global._internal();
    return _global;
  }

  Global._internal();

  /// Flag to be setted from tests to change behaviours
  /// Usually used to hide circularprogressbars and other widgets
  /// with infinite animations that would make pumpAndSettle fail
  bool testingActive = false;

  // this is a global singleton
  static Global _global;
 // Locale locale;
  Result result;
  List<Result> results;
  // User user;

  /// The api object used to make calls
  ApiService api;

  /// Recreates the api object with a new base url
  void initializeApi(
      {String url,
  //    String language,
      int page,
      Resource<Result> appLeveluserResource}) {

    api = ApiService.create(
        baseUrl: url != null ? url : "https://api.themoviedb.org/3/movie/popular?api_key=46514b47bc995b14fd13c566f27ac058&language=es_ES",
        page : page != null ? page : 1,
        apiKey: '46514b47bc995b14fd13c566f27ac058'
        );
  }
}

