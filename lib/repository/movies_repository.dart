import 'package:bitbox_moviedb/net/standard_network.dart';

import '../global.dart';
import '../models/popular.dart';
import 'resource.dart';

class MoviesRepository {
  static StandardApiCall<Popular> getPopulars(
      int page, Resource<Popular> resource) {
    final call = StandardApiCall<Popular>(
      () => Global()
          .api
          .getPopularMovies("46514b47bc995b14fd13c566f27ac058", 'es-ES', page),
      resource,
    );
    call.call();
    return call;
  }

  static StandardApiCall<Popular> getPopularSearch(
      Resource<Popular> resource, String query) {
    final call = StandardApiCall<Popular>(
      () => Global()
          .api
          .getFindMovies("46514b47bc995b14fd13c566f27ac058", 'es-ES', query),
      resource,
    );
    call.call();
    call.cancel();
    return call;
  }

//   static Resource<Popular> getCollectionResource(*//*String url*//*) {
//     final Resource<Popular> resource = Resource();
//     resource.
//     getPopulars(resource);
//     return resource;
//   }
}
