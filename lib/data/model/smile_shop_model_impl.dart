import 'package:smile_shop/data/model/smile_shop_model.dart';

import '../../network/data_agents/retrofit_data_agent_impl.dart';
import '../../network/data_agents/smile_shop_data_agent.dart';

class MovieBookingModelImpl extends SmileShopModel {
  static final MovieBookingModelImpl _singleton =
      MovieBookingModelImpl._internal();

  factory MovieBookingModelImpl() {
    return _singleton;
  }

  MovieBookingModelImpl._internal();

  ///Data agent
  SmileShopDataAgent mDataAgent = RetrofitDataAgentImpl();



}
