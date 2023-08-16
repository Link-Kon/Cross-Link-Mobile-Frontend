import 'package:cross_link/src/domain/models/requests/user_links_request.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../../domain/models/responses/base_response.dart';
import '../../../domain/models/user_link.dart';
import '../../../utils/constants/strings.dart';

part 'relationship_api_service.g.dart';

@RestApi(baseUrl: baseUrlWebService)
abstract class RelationshipApiService {
  factory RelationshipApiService(Dio dio, {String baseUrl}) = _RelationshipApiService;

  @GET('/Friendship/{userCode}')
  Future<HttpResponse<List<UserLink>>> getUserLinks({
    @Path('userCode') String? userCode,
    @Query("apiKey") String? apiKey,
  });

  @POST('/Friendship')
  Future<HttpResponse<BaseResponse>> addUserLink({
    @Body() UserLink? userLink,
    @Query("apiKey") String? apiKey,
  });


}