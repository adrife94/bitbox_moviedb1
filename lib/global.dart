import 'package:bitbox_moviedb/models/movie.dart';

import 'net/api.dart';

/// Global scope app singleton, for initializations needed app wide
class Global {
  /// The api object used to make calls
  ApiService api = ApiService.create();

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
  Movie result;
  List<Movie> results;
  // User user;

}
