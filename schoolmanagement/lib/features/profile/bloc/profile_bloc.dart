import 'package:bloc/bloc.dart';

import '../data/userData.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent,ProfileState>{
  ProfileBloc():super(const profileInitialState(isLoading: false)){
  on<viewProfileEvent>((event,emit)async{
    emit(const profileInitialState(isLoading: true));
    try {
      UserProfile userProfile=UserProfile();
      final Map<String,dynamic> userData=await userProfile.getUserProfile();
      if(userData.isEmpty)
      {
        emit(profileErrorState(exception: Exception("No Data Found"), message: "No data Found", isLoading: false));

      }else{
        emit(profileLoadedState(profileList: userData, isLoading: false));
      }
    } catch (e) {
      emit(profileErrorState(
        exception: Exception(e), 
        message: "error while fetching $e", 
        isLoading: false));
      
    }
  });
}
}