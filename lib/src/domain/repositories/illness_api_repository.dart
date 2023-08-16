import '../../utils/resources/data_state.dart';
import '../models/illness.dart';
import '../models/requests/illness_request.dart';

abstract class IllnessApiRepository {
  Future<DataState<List<Illness>>> getAllIllnesses({
    required IllnessRequest request,
  });
}