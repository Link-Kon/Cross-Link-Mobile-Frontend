import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../../domain/models/responses/base_response.dart';
import '../../../domain/models/responses/user_link_response.dart';
import '../../../domain/models/user_link.dart';
import '../../../utils/constants/strings.dart';

part 'relationship_api_service.g.dart';

@RestApi(baseUrl: baseUrlWebService)
abstract class RelationshipApiService {
  factory RelationshipApiService(Dio dio, {String baseUrl}) = _RelationshipApiService;

  @GET('/Friendship/{userCode}')
  Future<HttpResponse<List<UserLinkResponse>>> getUserLinks({
    @Path('userCode') String? userCode,
    //@Query("apiKey") String? apiKey,
  });

  @POST('/Friendship')
  Future<HttpResponse<BaseResponse>> addUserLink({
    @Body() UserLink? userLink,
    //@Query("apiKey") String? apiKey,
  });


}