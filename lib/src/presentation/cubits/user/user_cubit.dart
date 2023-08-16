import '../../../domain/models/requests/user_request.dart';
import '../../../domain/models/user.dart';
import '../../../domain/repositories/user_api_repository.dart';
import '../../../utils/resources/data_state.dart';
import '../base/base_cubit.dart';
import 'user_state.dart';

class UserCubit extends BaseCubit<UserState, List<User>> {
  final UserApiRepository _apiRepository;

  UserCubit (this._apiRepository) : super(const UserLoading(), []);

  Future<void> addUser({required String username, required String userCode, required String token}) async {

    emit(const UserLoading());

    if (isBusy) return;

    await run(() async {
      final response = await _apiRepository.addUser(
        request: UserRequest(username: username, userCode: userCode, token: token),
      );

      print('run add');
      if (response is DataSuccess) {
        print('success');
        print('data: ${response.data!.response}');
        print('data: ${response.data!.token}');
        final userResponse = response.data!;
        emit(UserSuccess(response: userResponse));

      } else if (response is DataFailed) {
        print('failed: ${response.error!.response}');
        emit(UserFailed(error: response.error));
      }
    });
  }

}