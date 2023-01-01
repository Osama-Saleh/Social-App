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

class ProfileImageLoadingState extends HomeStates {}

class ProfileImageSuccessState extends HomeStates {}

class ProfileImageErrorState extends HomeStates {}

class CoverImageLoadingState extends HomeStates {}

class CoverImageSuccessState extends HomeStates {}

class CoverImageErrorState extends HomeStates {}

class UpdateUserDataLoadingState extends HomeStates {}

class UpdateUserDataSuccessState extends HomeStates {}

class UpdateUserDataErrorState extends HomeStates {}

class ChangeBottomNavigatBarState extends HomeStates {}

class CreatePostState extends HomeStates {}

class CreatPostLoadingState extends HomeStates {}

class CreatPostSuccessState extends HomeStates {}

class CreatPostErrorState extends HomeStates {}

class GetPostImageLoadingState extends HomeStates {}

class GetPostImageSuccessState extends HomeStates {}

class GetPostImageErrorState extends HomeStates {}

class UploadPostLoadingState extends HomeStates {}

class UploadPostSuccessState extends HomeStates {}

class UploadPostErrorState extends HomeStates {}

class UpdatePostImageLoadingState extends HomeStates {}

class UpdatePostImageSuccessState extends HomeStates {}

class UpdatePostImageErrorState extends HomeStates {}

class GetPostLoadingState extends HomeStates {}

class GetPostSuccessState extends HomeStates {}

class GetPostErrorState extends HomeStates {}
class RemovePostImageState extends HomeStates {}

