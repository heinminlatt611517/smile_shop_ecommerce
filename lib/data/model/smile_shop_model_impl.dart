import 'package:smile_shop/data/model/smile_shop_model.dart';
import 'package:smile_shop/network/requests/login_request.dart';
import 'package:smile_shop/network/responses/login_response.dart';

import '../../network/data_agents/retrofit_data_agent_impl.dart';
import '../../network/data_agents/smile_shop_data_agent.dart';

class SmileShopModelImpl extends SmileShopModel {
  static final SmileShopModelImpl _singleton =
      SmileShopModelImpl._internal();

  factory SmileShopModelImpl() {
    return _singleton;
  }

  SmileShopModelImpl._internal();

  ///Data agent
  SmileShopDataAgent mDataAgent = RetrofitDataAgentImpl();

  @override
  Future<LoginResponse> login(LoginRequest loginRequest) {
    return mDataAgent.login(loginRequest);
  }



}
