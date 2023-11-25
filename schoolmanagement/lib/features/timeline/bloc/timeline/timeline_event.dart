part of 'timeline_bloc.dart';

sealed class TimelineEvent extends Equatable {
  const TimelineEvent();

  @override
  List<Object> get props => [];
}

final class fetchTimelineEvent extends TimelineEvent {
  final DateTime date;
  const fetchTimelineEvent({
    required this.date,
  });
}
