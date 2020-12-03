import 'package:bitbox_moviedb/models/popular.dart';
import 'package:bitbox_moviedb/net/json_to_type_converter.dart';
import 'package:chopper/chopper.dart';

import '../models/popular.dart';

part 'api.chopper.dart';

// Anotación ChopperApi para que el generador de chopper
// sepa crear el archivo movie_service.chopper
@ChopperApi(baseUrl: '')
abstract class ApiService extends ChopperService {
  static ApiService create() {
    final client = ChopperClient(
      baseUrl: 'https://api.themoviedb.org/3/',
      converter: JsonToTypeConverter({
        Popular: (json) => Popular.fromJson(json),
      }),
      services: [
        _$ApiService(),
      ],
    );

    return _$ApiService(client);
  }

  @Get(path: 'movie/popular')
  Future<Response<Popular>> getPopularMovies(
    @Query('api_key') String _apiKey,
    @Query('language') String language,
    @Query('page') int _page,
  );

  @Get(path: 'search/movie')
  Future<Response<Popular>> getFindMovies(
    @Query('api_key') String _apiKey,
    @Query('language') String language,
    @Query('query') String query,
  );
}
