import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../../domain/models/responses/patient_response.dart';
import '../../../domain/models/patient.dart';
import '../../../utils/constants/strings.dart';

part 'user_patient_api_service.g.dart';

@RestApi(baseUrl: baseUrlWebService)
abstract class UserPatientApiService {
  factory UserPatientApiService(Dio dio, {String baseUrl}) = _UserPatientApiService;

  @POST('/Patient')
  Future<HttpResponse<UserPatientResponse>> addUserPatient({
    @Body() required UserPatient userPatient,
  });

  @GET('/Patient/GetByUsername/{username}')
  Future<HttpResponse<UserPatientResponse>> getUserPatient({
    @Path("username") required String username,
  });

  @PUT('/Patient/{id}')
  Future<HttpResponse<UserPatientResponse>> updateUserPatient({
    @Body() required UserPatient userPatient,
  });

}