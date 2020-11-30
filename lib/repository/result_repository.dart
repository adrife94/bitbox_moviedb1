import 'package:bitbox_moviedb/net/standard_network.dart';

import '../global.dart';
import '../models/popular.dart';
import 'resource.dart';


class ResultRepository {
  static StandardApiCall<Popular> getPopulars(String url, Resource<Popular> resource) {
    final call = StandardApiCall<Popular>( () => Global().api.getPopularMovies("46514b47bc995b14fd13c566f27ac058", 1),
        resource,
        retryForever: false);

    call.call();

    return call;
  }

  static Resource<Popular> getCollectionResource(String url) {
    final Resource<Popular> resource = Resource();

    getPopulars(url, resource);

    return resource;
  }
}