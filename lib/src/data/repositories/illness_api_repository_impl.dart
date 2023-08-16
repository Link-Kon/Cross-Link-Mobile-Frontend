import '../../domain/models/illness.dart';
import '../../domain/models/requests/illness_request.dart';
import '../../domain/repositories/illness_api_repository.dart';
import '../../utils/resources/data_state.dart';
import '../datasources/remote/illness_api_service.dart';
import 'base/base_api_repository.dart';

class IllnessApiRepositoryImpl extends BaseApiRepository implements IllnessApiRepository {
  final IllnessApiService _illnessApiService;

  IllnessApiRepositoryImpl(this._illnessApiService);

  @override
  Future<DataState<List<Illness>>> getAllIllnesses({required IllnessRequest request}) {
    return getStateOf<List<Illness>>(
        request: () => _illnessApiService.getAllIllnesses()
    );
  }


}