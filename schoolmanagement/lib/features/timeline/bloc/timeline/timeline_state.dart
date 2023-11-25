part of 'timeline_bloc.dart';

sealed class TimelineState extends Equatable {
  final bool isLoading;
  final String? message;
  const TimelineState({required this.isLoading, this.message});

  @override
  List<Object> get props => [];
}

final class TimelineInitial extends TimelineState {
  const TimelineInitial({required super.isLoading});
}

class TimelineLoaded extends TimelineState {
  final List<Routine> routineList;
  const TimelineLoaded({
    required this.routineList,
    required isLoading,
  }) : super(isLoading: isLoading);
  TimelineLoaded copyWith({
    bool? isLoading,
    List<Routine>? routineList,
  }) {
    return TimelineLoaded(
      isLoading: isLoading ?? this.isLoading,
      routineList: routineList ?? this.routineList,
    );
  }
}

class TimelineError extends TimelineState {
  final Exception? exception;
  const TimelineError({
    required this.exception,
    required message,
    required isLoading,
  }) : super(isLoading: isLoading, message: message);
}
