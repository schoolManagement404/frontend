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

class NavigationErrorState extends NavigationState {
  final Exception? exception;
  final String? message;
  const NavigationErrorState({
    required this.exception,
    required this.message,
    required tabIndex,
  }) : super(tabIndex: tabIndex);
}
