part of 'fee_bloc.dart';

@immutable
abstract class FeeState {
  final bool isLoading;
  final String? message;
  final List<bool>? expandedStates;
  const FeeState({required this.isLoading, this.message, this.expandedStates});
}

class FeeInitialState extends FeeState {
  const FeeInitialState({required super.isLoading});
}

class FeeLoadedState extends FeeState {
  final List<StudentFee> feeList;
  const FeeLoadedState({
    required this.feeList,
    required List<bool>? expandedStates,
    required isLoading,
  }) : super(isLoading: isLoading, expandedStates: expandedStates);
  FeeLoadedState copyWith({
    bool? isLoading,
    List<bool>? expandedStates,
    List<StudentFee>? feeList,
  }) {
    return FeeLoadedState(
      isLoading: isLoading ?? this.isLoading,
      expandedStates: expandedStates ?? this.expandedStates,
      feeList: feeList ?? this.feeList,
    );
  }
}

class feeErrorState extends FeeState {
  final Exception? exception;
  const feeErrorState({
    required this.exception,
    required message,
    required isLoading,
  }) : super(isLoading: isLoading, message: message);
}

class toggleExpansionState extends FeeState {
  final int index;
  const toggleExpansionState({
    required this.index,
    required isLoading,
  }) : super(isLoading: isLoading);
}
