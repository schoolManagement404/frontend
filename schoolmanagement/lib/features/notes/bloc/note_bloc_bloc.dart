import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'note_bloc_event.dart';
part 'note_bloc_state.dart';

class NoteBlocBloc extends Bloc<NoteBlocEvent, NoteBlocState> {
  NoteBlocBloc() : super(NoteBlocInitial()) {
    on<NoteBlocEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
