part of 'user_photo_bloc.dart';

abstract class UserPhotoState extends Equatable {
  const UserPhotoState();

  @override
  List<Object> get props => [];
}

class UserPhotoInitialState extends UserPhotoState {}

class UserPhotoLoadingState extends UserPhotoState {}

class UserPhotoErrorState extends UserPhotoState {
  final String? error;

  const UserPhotoErrorState({this.error});
}

class UserPhotoSuccessState extends UserPhotoState {
  final List<UserInfoModel> userInfoModelList;

  const UserPhotoSuccessState({required this.userInfoModelList});
}
