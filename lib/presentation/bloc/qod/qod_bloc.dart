import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:phrase_of_the_day/domain/entities/quote_entity.dart';
import 'package:phrase_of_the_day/domain/usescases/get_qod_usecase.dart';

part 'qod_event.dart';
part 'qod_state.dart';

class QodBloc extends Bloc<QodEvent, QodState> {
  final GetQodUsecase _getQodUsecase;

  QodBloc(this._getQodUsecase) : super(InitialState()) {
    on<GetQodEvent>(_getQodEvent);
  }

  void _getQodEvent(GetQodEvent event, Emitter<QodState> emit) async {
    try {
      emit(LoadingState());

      final qod = await _getQodUsecase.call();

      emit(SuccessState(qod));
    } catch (e) {
      emit(FailedState());
    }
  }
}
