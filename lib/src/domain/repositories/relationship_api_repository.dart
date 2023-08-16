import '../../utils/resources/data_state.dart';
import '../models/requests/user_links_request.dart';
import '../models/responses/base_response.dart';
import '../models/user_link.dart';

abstract class RelationshipApiRepository {
  Future<DataState<List<UserLink>>> getUserLinks({
    required UserLinksRequest request,
  });

  Future<DataState<BaseResponse>> addUserLink({
    required UserLinksRequest request,
  });
}