import 'package:cross_link/src/domain/models/requests/user_links_request.dart';
import 'package:cross_link/src/domain/models/responses/user_links_response.dart';
import 'package:cross_link/src/utils/resources/data_state.dart';

abstract class RelationshipApiRepository {
  Future<DataState<UserLinksResponse>> getUserLinks({
    required UserLinksRequest request,
  });
}