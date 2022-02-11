part of 'user_list_bloc.dart';

@immutable
abstract class UserListState {}

class UserListInitialState extends UserListState {}

class UserListLoadingState extends UserListState {}

class UserListErrorState extends UserListState {
  final String? error;

  UserListErrorState({this.error});
}

class UserListSuccessState extends UserListState {
  final List<UserListModel>? userListModel;

  UserListSuccessState({required this.userListModel});

  UserListSuccessState getUserList() {
    return UserListSuccessState(userListModel : userListModel);
  }
}
