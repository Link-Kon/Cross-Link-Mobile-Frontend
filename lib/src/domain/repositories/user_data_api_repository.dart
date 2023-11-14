import '../../utils/resources/data_state.dart';
import '../models/requests/user_data_request.dart';
import '../models/responses/user_data_response.dart';

abstract class UserDataApiRepository {
  Future<DataState<UserDataResponse>> addUserData({
    required UserDataRequest request,
  });

  Future<DataState<UserDataResponse>> getUserData({
    required UserDataRequest request,
  });
}