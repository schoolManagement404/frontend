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
        StudentFeeApi studentFeeApi = StudentFeeApi();
        final List<StudentFee> feeList =
            await studentFeeApi.getStudentFees(event.student_id);
        if (feeList.isEmpty) {
          emit(feeErrorState(
              exception: Exception('No fees found'),
              message: 'No fees found',
              isLoading: false));
        } else {
          emit(FeeLoadedState(
              feeList: feeList,
              isLoading: false,
              expandedStates: List.generate(feeList.length, (index) => false)));
        }
      } on Exception catch (e) {
        emit(feeErrorState(
            exception: e,
            message: 'Error while fetching fees $e',
            isLoading: false));
      }
    });
    on<toggleExpansionEvent>((event, emit) async {
      if (state is FeeLoadedState) {
        final currentState = state as FeeLoadedState;
        final updatedExpandedStates =
            List<bool>.from(currentState.expandedStates!);
        updatedExpandedStates[event.index] =
            !updatedExpandedStates[event.index];
        emit(currentState.copyWith(expandedStates: updatedExpandedStates));
      }
    });
  }
}
