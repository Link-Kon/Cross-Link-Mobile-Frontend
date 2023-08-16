import '../../domain/models/requests/user_links_request.dart';
import '../../domain/models/responses/base_response.dart';
import '../../domain/models/user_link.dart';
import '../../domain/repositories/relationship_api_repository.dart';
import '../../utils/resources/data_state.dart';
import '../datasources/remote/relationship_api_service.dart';
import 'base/base_api_repository.dart';

class RelationshipApiRepositoryImpl extends BaseApiRepository implements RelationshipApiRepository {
  final RelationshipApiService _relationshipApiService;

  RelationshipApiRepositoryImpl(this._relationshipApiService);

  @override
  Future<DataState<List<UserLink>>> getUserLinks({required UserLinksRequest request}) {
    return getStateOf<List<UserLink>>(
      request: () => _relationshipApiService.getUserLinks(
        apiKey: request.apiKey,
        userCode: request.user1Code,
      )
    );
  }

  @override
  Future<DataState<BaseResponse>> addUserLink({required UserLinksRequest request}) {
    return getStateOf<BaseResponse>(
        request: () => _relationshipApiService.addUserLink(
          apiKey: request.apiKey,
          userLink: UserLink(user2code: request.user2Code),
        )
    );
  }

  

}