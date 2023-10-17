part of 'fee_bloc.dart';

@immutable
abstract class FeeEvent {}

class fetchFeeEvent extends FeeEvent {
  final String student_id;

  fetchFeeEvent({
    required this.student_id,
  });
}

class toggleExpansionEvent extends FeeEvent {
  final int index;

  toggleExpansionEvent({
    required this.index,
  });
}
