class HomeStates {}

class HomeInitState extends HomeStates {}

class RegisterLoadingDataState extends HomeStates {}

class RegisterSuccessDataState extends HomeStates {}

class RegisterErrorDataState extends HomeStates {}

class LoginLoadingDataState extends HomeStates {}

class LoginSuccessDataState extends HomeStates {
  final String? uid;

  LoginSuccessDataState(this.uid);
}

class LoginErrorDataState extends HomeStates {}

class CreatUserLoadingState extends HomeStates {}

class CreatUserSuccessState extends HomeStates {}

class CreatUserErrorState extends HomeStates {}

class GetUserLoadingState extends HomeStates {}

class GetUserSuccessState extends HomeStates {}

class GetUserErrorState extends HomeStates {}
