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
            userCode: request.userCode,
            token: request.token
          )
        )
    );
  }


}