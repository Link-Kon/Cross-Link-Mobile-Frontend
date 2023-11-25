import '../../utils/resources/data_state.dart';
import '../models/requests/user_request.dart';
import '../models/responses/base_response.dart';
import '../models/responses/user_response.dart';

abstract class UserApiRepository {
  Future<DataState<UserResponse>> addUser({
    required UserRequest request,
  });

  Future<DataState<UserResponse>> getUser({
    required String username
  });

  Future<DataState<BaseResponse>> updateDeviceToken({
    required UserRequest request,
  });

  Future<DataState<UserResponse>> updateUser({
    required UserRequest request,
  });

}