import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'navigation_event.dart';
part 'navigation_state.dart';

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  NavigationBloc() : super(const NavigationInitial(tabIndex: 1)) {
    on<NavigationEvent>((event, emit) {
      if (event is TabChanged) {
        emit(NavigationInitial(tabIndex: event.tabIndex));
      }
    });
  }
}
