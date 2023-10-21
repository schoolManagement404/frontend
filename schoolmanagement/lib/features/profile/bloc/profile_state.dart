part of 'profile_bloc.dart';


abstract class ProfileState{
  final bool isLoading;
  final String? message;

  const ProfileState({required this.isLoading, this.message});
}

class profileInitialState extends ProfileState{
  const profileInitialState({required super.isLoading});
}

class profileLoadedState extends ProfileState{
  final Map<String,dynamic> profileList;
  const profileLoadedState({
    required this.profileList,
    required isLoading,
  }):super(isLoading: isLoading);
}

class profileErrorState extends ProfileState{
  final Exception? exception;
  const profileErrorState({
    required this.exception,
    required message,
    required isLoading,
  }) : super(isLoading: isLoading, message: message);
}