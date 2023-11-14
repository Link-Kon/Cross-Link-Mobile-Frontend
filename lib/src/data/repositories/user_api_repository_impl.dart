import '../../domain/models/requests/user_request.dart';
import '../../domain/models/responses/user_response.dart';
import '../../domain/models/user.dart';
import '../../domain/repositories/user_api_repository.dart';
import '../../utils/resources/data_state.dart';
import '../datasources/remote/user_api_service.dart';
import 'base/base_api_repository.dart';

class UserApiRepositoryImpl extends BaseApiRepository implements UserApiRepository {
  final UserApiService _userApiService;

  UserApiRepositoryImpl(this._userApiService);

  @override
  Future<DataState<UserResponse>> addUser({required UserRequest request}) {
    return getStateOf<UserResponse>(
        request: () => _userApiService.addUser(
          user: User(
            username: request.username,
            deviceToken: request.deviceToken,
            token: request.token
          )
        )
    );
  }

  @override
  Future<DataState<UserResponse>> getUser({required String username}) {
    return getStateOf<UserResponse>(
        request: () => _userApiService.getUser(
            username: username
        )
    );
  }

  @override
  Future<DataState<UserResponse>> updateUser({required UserRequest request}) {
    return getStateOf<UserResponse>(
        request: () => _userApiService.updateUser(
            user: User(
                username: request.username,
                deviceToken: request.deviceToken,
                token: request.token
            )
        )
    );
  }


}