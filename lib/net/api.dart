import 'package:chopper/chopper.dart';
import 'package:bitbox_moviedb/models/popular.dart';
import 'package:bitbox_moviedb/services/model_converter.dart';
import '../models/popular.dart';
import '../models/result.dart';
import '../repository/resource.dart';
import 'interceptor.dart';



part 'api.chopper.dart';

// Anotación ChopperApi para que el generador de chopper sepa crear el archivo movie_service.chopper
@ChopperApi()

abstract class ApiService extends ChopperService {

  @Get(path: 'movie/popular')
  Future<Response<Popular>> getPopularMovies(
      @Query('api_key') String _apiKey,
      @Query('page') int _page,);


  static ApiService create() {

    final client = ChopperClient(

      baseUrl: 'https://api.themoviedb.org/3/',
   //   interceptors: [Interceptor(), HttpLoggingInterceptor()],
      converter: ModelConverter(),
      errorConverter: JsonConverter(),
      services: [
        _$ApiService(),
      ],
    );

    return _$ApiService(client);
  }
}