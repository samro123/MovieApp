import 'package:movie_video/data/network/error_handler.dart';
import 'package:movie_video/data/responses/responses.dart';

const CACHE_MOVIE_KEY = "CACHE_HOME_KEY";
const CACHE_MOVIE_INTERVAL = 60 * 1000;

abstract class LocalDataSource{
  Future<PaginatedMoviesResponse> getMovie();
  Future<void> saveMovieToCache(PaginatedMoviesResponse paginatedMoviesResponse);
  void clearCache();
  void removeFromCache(String key);
}

class LocalDataSourceImplementer implements LocalDataSource{
  Map<String, CachedItem> cacheMap = Map();


  @override
  Future<PaginatedMoviesResponse> getMovie() async{
    CachedItem? cachedItem = cacheMap[CACHE_MOVIE_KEY];
    if(cachedItem != null && cachedItem.isValid(CACHE_MOVIE_INTERVAL)){
      return cachedItem.data;
    }else{
      throw ErrorHandler.handle(DataSource.CACHE_ERROR);
    }
  }

  @override
  Future<void> saveMovieToCache(PaginatedMoviesResponse paginatedMoviesResponse) async {
    cacheMap[CACHE_MOVIE_KEY] = CachedItem(paginatedMoviesResponse);
  }

  @override
  void removeFromCache(String key) {
      cacheMap.remove(key);
  }

  @override
  void clearCache() {
    cacheMap.clear();
  }
}

class CachedItem{
  dynamic data;
  int cacheTime = DateTime.now().millisecondsSinceEpoch;
  CachedItem(this.data);
}

extension CachedItemExtension on CachedItem{
  bool isValid(int expirationTime){
    int currentTimeInMillis =
        DateTime.now().millisecondsSinceEpoch;
    bool isCacheValid = currentTimeInMillis - expirationTime < cacheTime;
    return isCacheValid;
  }
}