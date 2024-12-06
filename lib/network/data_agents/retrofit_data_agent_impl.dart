import 'package:dio/dio.dart';
import 'package:smile_shop/network/data_agents/smile_shop_data_agent.dart';
import 'package:smile_shop/network/requests/login_request.dart';
import 'package:smile_shop/network/responses/login_response.dart';
import 'package:smile_shop/network/smile_shop_api.dart';

class RetrofitDataAgentImpl extends SmileShopDataAgent {
  late SmileShopApi mApi;

  static RetrofitDataAgentImpl? _singleton;

  ///singleton
  factory RetrofitDataAgentImpl() {
    _singleton ??= RetrofitDataAgentImpl._internal();
    return _singleton!;
  }
  ///private constructor
  RetrofitDataAgentImpl._internal() {
    final dio = Dio();
    mApi = SmileShopApi(dio);
  }

  @override
  Future<LoginResponse> login(LoginRequest loginRequest) {
    return mApi.login(loginRequest);
  }
}
