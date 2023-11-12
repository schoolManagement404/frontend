part of 'navigation_bloc.dart';

sealed class NavigationEvent extends Equatable {
  const NavigationEvent();

  @override
  List<Object> get props => [];
}

class TabChanged extends NavigationEvent {
  final int tabIndex;
  const TabChanged({required this.tabIndex});
}
