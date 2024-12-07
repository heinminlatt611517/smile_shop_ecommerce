
import '../../network/requests/login_request.dart';
import '../../network/responses/login_response.dart';

abstract class SmileShopModel {
  Future<LoginResponse> login(LoginRequest loginRequest);

  //Future<SignUpResponse> signUp(SignUpRequest signUpRequest);
}
