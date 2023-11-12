import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'navigation_event.dart';
part 'navigation_state.dart';

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  NavigationBloc() : super(NavigationInitial(tabIndex: 0)) {
    on<NavigationEvent>((event, emit) {
      if (event is TabChanged) {
        emit(NavigationInitial(tabIndex: event.tabIndex));
      }
    });
  }
}
