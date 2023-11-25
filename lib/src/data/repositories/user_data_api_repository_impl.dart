import '../../domain/models/requests/user_data_request.dart';
import '../../domain/models/responses/user_data_response.dart';
import '../../domain/models/user_data.dart';
import '../../domain/repositories/user_data_api_repository.dart';
import '../../utils/resources/data_state.dart';
import '../datasources/remote/user_data_api_service.dart';
import 'base/base_api_repository.dart';

class UserDataApiRepositoryImpl extends BaseApiRepository implements UserDataApiRepository {
  final UserDataApiService _userDataApiService;

  UserDataApiRepositoryImpl(this._userDataApiService);

  @override
  Future<DataState<UserDataResponse>> addUserData({required UserDataRequest request}) {
    return getStateOf<UserDataResponse>(
        request: () => _userDataApiService.addUserData(
            userData: UserData(
              state: request.state,
              email: request.email,
              name: request.name,
              lastname: request.lastname,
              photo: request.photo,
              userCode: request.code,
            )
        )
    );
  }

  @override
  Future<DataState<UserDataResponse>> getUserData({required UserDataRequest request}) {
    return getStateOf<UserDataResponse>(
        request: () => _userDataApiService.getUserData(
            userCode: request.code!,
        )
    );
  }


}