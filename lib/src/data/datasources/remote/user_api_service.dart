import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../../domain/models/responses/user_response.dart';
import '../../../domain/models/user.dart';
import '../../../utils/constants/strings.dart';

part 'user_api_service.g.dart';

@RestApi(baseUrl: baseUrlWebService)
abstract class UserApiService {
  factory UserApiService(Dio dio, {String baseUrl}) = _UserApiService;

  @POST('/User')
  Future<HttpResponse<UserResponse>> addUser({
    @Body() required User user,
  });

}