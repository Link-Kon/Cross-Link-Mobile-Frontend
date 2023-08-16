import '../../../domain/models/illness.dart';
import '../../../domain/models/requests/illness_request.dart';
import '../../../domain/repositories/illness_api_repository.dart';
import '../../../utils/resources/data_state.dart';
import '../base/base_cubit.dart';
import 'illness_state.dart';

class IllnessCubit extends BaseCubit<IllnessState, List<Illness>> {
  final IllnessApiRepository _apiRepository;

  IllnessCubit (this._apiRepository) : super(const IllnessLoading(), []);


  Future<void> getAllIllnesses(String apiKey, String userDataId) async {
    emit(const IllnessLoading());

    if (isBusy) {
      return;
    }

    await run(() async {
      final response = await _apiRepository.getAllIllnesses(
        request: IllnessRequest(apiKey: apiKey, userDataId: userDataId),
      );

      if (response is DataSuccess) {
        final illnesses = response.data!;
        data.addAll(illnesses);
        emit(IllnessSuccess(illnesses: data));

      } else if (response is DataFailed) {
        emit(IllnessFailed(error: response.error));
      }
    });
  }

}