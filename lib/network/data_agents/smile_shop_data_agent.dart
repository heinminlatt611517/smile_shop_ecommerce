import '../requests/login_request.dart';
import '../responses/login_response.dart';

abstract class SmileShopDataAgent
{
  Future<LoginResponse> login(LoginRequest loginRequest);
}
