part of 'navigation_bloc.dart';

sealed class NavigationState extends Equatable {
  final int tabIndex;
  const NavigationState({required this.tabIndex});

  @override
  List<Object> get props => [
        tabIndex,
      ];
}

final class NavigationInitial extends NavigationState {
  const NavigationInitial({required super.tabIndex});
}
