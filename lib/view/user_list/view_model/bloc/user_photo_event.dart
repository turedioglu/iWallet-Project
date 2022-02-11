part of 'user_photo_bloc.dart';

abstract class UserPhotoEvent extends Equatable {
  const UserPhotoEvent();

  @override
  List<Object> get props => [];
}

class GetUserPhotoEvent extends UserPhotoEvent {

  final int length;

  const GetUserPhotoEvent({required this.length});
  
}

class ClearUserPhotoEvent extends UserPhotoEvent {
  const ClearUserPhotoEvent();
}
