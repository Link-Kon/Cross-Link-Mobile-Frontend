import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../../domain/models/responses/user_data_response.dart';
import '../../../domain/models/user_data.dart';
import '../../../utils/constants/strings.dart';

part 'user_data_api_service.g.dart';

@RestApi(baseUrl: baseUrlWebService)
abstract class UserDataApiService {
  factory UserDataApiService(Dio dio, {String baseUrl}) = _UserDataApiService;

  @POST('/UserData')
  Future<HttpResponse<UserDataResponse>> addUserData({
    @Body() required UserData userData,
  });

  @GET('/UserData/GetByUserCode/{userCode}')
  Future<HttpResponse<UserDataResponse>> getUserData({
    @Path("userCode") required String userCode,
  });

}