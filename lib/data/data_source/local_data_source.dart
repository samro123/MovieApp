import 'package:movie_video/data/network/error_handler.dart';
import 'package:movie_video/data/responses/responses.dart';

const CACHE_MOVIE_KEY = "CACHE_MOVIE_KEY";
const CACHE_RECOMMEND_KEY = "CACHE_RECOMMEND_KEY";
const CACHE_COMMENT_KEY = "CACHE_COMMENT_KEY";
const CACHE_INTERVAL = 60 * 1000;

abstract class LocalDataSource{
  Future<PaginatedMoviesResponse> getMovie();
  Future<RecommendMoviesResponse> getRecommendMovies();
  Future<GetCommentResponse> getComment();
  Future<void> saveMovieToCache(PaginatedMoviesResponse paginatedMoviesResponse);
  Future<void> saveRecommendMoviesToCache(RecommendMoviesResponse recommendMoviesResponse);
  Future<void> saveCommentToCache(GetCommentResponse getCommentResponse);
  void clearCache();
  void removeFromCache(String key);
}

class LocalDataSourceImplementer implements LocalDataSource{
  Map<String, CachedItem> cacheMap = Map();


  @override
  Future<PaginatedMoviesResponse> getMovie() async{
    CachedItem? cachedItem = cacheMap[CACHE_MOVIE_KEY];
    if(cachedItem != null && cachedItem.isValid(CACHE_INTERVAL)){
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
  Future<RecommendMoviesResponse> getRecommendMovies() {
    CachedItem? cachedItem = cacheMap[CACHE_RECOMMEND_KEY];
    if(cachedItem != null && cachedItem.isValid(CACHE_INTERVAL)){
      return cachedItem.data;
    }else{
      throw ErrorHandler.handle(DataSource.CACHE_ERROR);
    }
  }

  @override
  Future<void> saveRecommendMoviesToCache(RecommendMoviesResponse recommendMoviesResponse) async{
    cacheMap[CACHE_RECOMMEND_KEY] = CachedItem(recommendMoviesResponse);
  }

  @override
  Future<GetCommentResponse> getComment() async{
    CachedItem? cacheItem = cacheMap[CACHE_COMMENT_KEY];
    if(cacheItem != null && cacheItem.isValid(CACHE_INTERVAL)){
      return cacheItem.data;
    }else{
      throw ErrorHandler.handle(DataSource.CACHE_ERROR);
    }
  }

  @override
  Future<void> saveCommentToCache(GetCommentResponse getCommentResponse) async{
    cacheMap[CACHE_COMMENT_KEY] = CachedItem(getCommentResponse);
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