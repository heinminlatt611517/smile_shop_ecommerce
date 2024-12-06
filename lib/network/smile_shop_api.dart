import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:smile_shop/network/requests/login_request.dart';
import 'package:smile_shop/network/responses/login_response.dart';

import 'api_constants.dart';

part 'smile_shop_api.g.dart';

@RestApi(baseUrl: kBaseUrl)
abstract class SmileShopApi {
  factory SmileShopApi(Dio dio) = _SmileShopApi;

  @GET(kEndPointLogin)
  Future<LoginResponse> login(@Body() LoginRequest loginRequest);
}
