import '../../utils/resources/data_state.dart';
import '../models/requests/patient_request.dart';
import '../models/responses/patient_response.dart';

abstract class UserPatientApiRepository {
  Future<DataState<UserPatientResponse>> addUserPatient({
    required UserPatientRequest request,
  });

  Future<DataState<UserPatientResponse>> getUserPatient({
    required String username
  });

  Future<DataState<UserPatientResponse>> updateUserPatient({
    required UserPatientRequest request,
  });

}