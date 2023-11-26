import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:schoolmanagement/features/timeline/data/routine.dart';
import 'package:schoolmanagement/features/timeline/data/sample_routine.dart';

part 'timeline_event.dart';
part 'timeline_state.dart';

class TimelineBloc extends Bloc<TimelineEvent, TimelineState> {
  TimelineBloc() : super(const TimelineInitial(isLoading: true)) {
    on<fetchTimelineEvent>((event, emit) {
      final List<Routine> list = listOfRoutine;
      emit(TimelineLoaded(routineList: list, isLoading: false));
    });
  }
}
