import '../../utils/resources/data_state.dart';
import '../models/requests/user_links_request.dart';
import '../models/responses/base_response.dart';
import '../models/responses/user_link_response.dart';

abstract class RelationshipApiRepository {
  Future<DataState<List<UserLinkResponse>>> getUserLinks({
    required UserLinksRequest request,
  });

  Future<DataState<BaseResponse>> addUserLink({
    required UserLinksRequest request,
  });
}