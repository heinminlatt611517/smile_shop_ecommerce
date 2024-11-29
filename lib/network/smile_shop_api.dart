import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';

import 'api_constants.dart';

part 'smile_shop_api.g.dart';

@RestApi(baseUrl: kBaseUrl)
abstract class SmileShopApi {
  factory SmileShopApi(Dio dio) = _SmileShopApi;

  @GET(kEndPointGetNowPlaying)
  Future<void> getNowPlayingMovies(
      @Query(kParamApiKey) String apiKey,
      @Query(kParamLanguage) String language,
      @Query(kParamPage) String page,
      );
}
