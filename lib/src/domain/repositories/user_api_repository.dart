import '../../utils/resources/data_state.dart';
import '../models/requests/user_request.dart';
import '../models/responses/user_response.dart';

abstract class UserApiRepository {
  Future<DataState<UserResponse>> addUser({
    required UserRequest request,
  });
}