import 'package:cross_link/src/data/datasources/remote/relationship_api_service.dart';
import 'package:cross_link/src/data/repositories/base_api_repository.dart';
import 'package:cross_link/src/domain/models/requests/user_links_request.dart';
import 'package:cross_link/src/domain/models/responses/user_links_response.dart';
import 'package:cross_link/src/domain/repositories/relationship_api_repository.dart';
import 'package:cross_link/src/utils/resources/data_state.dart';

class RelationshipApiRepositoryImpl extends BaseApiRepository implements RelationshipApiRepository {
  final RelationshipApiService _relationshipApiService;

  RelationshipApiRepositoryImpl(this._relationshipApiService);

  @override
  Future<DataState<UserLinksResponse>> getUserLinks({required UserLinksRequest request}) {
    return getStateOf<UserLinksResponse>(
      request: () => _relationshipApiService.getUserLinks(
        apiKey: request.apiKey,
        userCode: request.userCode,
      )
    );
  }

  

}