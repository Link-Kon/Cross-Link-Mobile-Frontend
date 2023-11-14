import '../../domain/models/requests/patient_request.dart';
import '../../domain/models/responses/patient_response.dart';
import '../../domain/models/patient.dart';
import '../../domain/repositories/user_patient_api_repository.dart';
import '../../utils/resources/data_state.dart';
import '../datasources/remote/user_patient_api_service.dart';
import 'base/base_api_repository.dart';

class UserPatientApiRepositoryImpl extends BaseApiRepository implements UserPatientApiRepository {
  final UserPatientApiService _userPatientApiService;

  UserPatientApiRepositoryImpl(this._userPatientApiService);

  @override
  Future<DataState<UserPatientResponse>> addUserPatient({required UserPatientRequest request}) {
    return getStateOf<UserPatientResponse>(
        request: () => _userPatientApiService.addUserPatient(
          userPatient: UserPatient(
            state: request.state,
            weight: request.weight,
            height: request.height,
            country: request.country,
            userDataId: request.userDataId
          )
        )
    );
  }

  @override
  Future<DataState<UserPatientResponse>> getUserPatient({required String username}) {
    return getStateOf<UserPatientResponse>(
        request: () => _userPatientApiService.getUserPatient(
            username: username
        )
    );
  }

  @override
  Future<DataState<UserPatientResponse>> updateUserPatient({required UserPatientRequest request}) {
    return getStateOf<UserPatientResponse>(
        request: () => _userPatientApiService.updateUserPatient(
            userPatient: UserPatient(
              state: request.state,
              weight: request.weight,
              height: request.height,
              country: request.country,
              userDataId: request.userDataId
            )
        )
    );
  }


}