import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:schoolmanagement/features/fee/data/services/feeApi.dart';
import '../data/model/feeModel.dart';

part 'fee_event.dart';
part 'fee_state.dart';

class FeeBloc extends Bloc<FeeEvent, FeeState> {
  FeeBloc() : super(const FeeInitialState(isLoading: false)) {
    on<fetchFeeEvent>((event, emit) async {
      emit(const FeeInitialState(isLoading: true));
      try {
        final List<StudentFee> feeList =
            await StudentFeeApi().getStudentFees(event.student_id);
        if (feeList.isEmpty) {
          emit(feeErrorState(
              exception: Exception('No fees found'),
              message: 'No fees found',
              isLoading: false));
        } else {
          emit(FeeLoadedState(feeList: feeList, isLoading: false));
        }
      } on Exception catch (e) {
        emit(feeErrorState(
            exception: e,
            message: 'Error while fetching fees $e',
            isLoading: false));
      }
    });
    on<toggleExpansionEvent>((event, emit) async {
      emit(toggleExpansionState(index: event.index, isLoading: false));
    });
  }
}
