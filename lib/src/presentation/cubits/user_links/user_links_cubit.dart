import '../../../domain/models/requests/user_links_request.dart';
import '../../../domain/models/responses/user_link_response.dart';
import '../../../domain/repositories/relationship_api_repository.dart';
import '../../../utils/resources/data_state.dart';
import '../base/base_cubit.dart';
import 'user_links_state.dart';

class UserLinksCubit extends BaseCubit<UserLinksState, List<UserLinkResponse>> {
  final RelationshipApiRepository _apiRepository;

  UserLinksCubit (this._apiRepository) : super(const UserLinksLoading(), []);


  Future<void> getUserLinks({required String apiKey, required String userCode}) async {
    data.clear();

    emit(const UserLinksLoading());

    if (isBusy) return;

    await run(() async {
      final response = await _apiRepository.getUserLinks(
        request: UserLinksRequest(apiKey: apiKey, user1Code: userCode),
      );

      if (response is DataSuccess) {
        final userLinks = response.data!;
        data.addAll(userLinks);
        emit(UserLinksSuccess(userLinks: data));

      } else if (response is DataFailed) {
        emit(UserLinksFailed(error: response.error));
      }
    });
  }

  Future<void> addUserLink({required String apiKey, required String userCode, required String user2Code}) async {
    emit(const UserLinksLoading());

    if (isBusy) return;

    await run(() async {
      final response = await _apiRepository.addUserLink(
        request: UserLinksRequest(apiKey: apiKey, user1Code: userCode, user2Code: user2Code),
      );

      if (response is DataSuccess) {
        final responseData = response.data!;
        emit(UserLinkAddSuccess(response: responseData));

      } else if (response is DataFailed) {
        emit(UserLinksFailed(error: response.error));
      }
    });
  }

}