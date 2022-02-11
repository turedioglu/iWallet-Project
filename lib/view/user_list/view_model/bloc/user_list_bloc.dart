import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:iwallet_project/core/services/user_list_service.dart';
import 'package:iwallet_project/view/user_list/model/user_list_model.dart';

part 'user_list_event.dart';
part 'user_list_state.dart';

class UserListBloc extends Bloc<UserListEvent, UserListState> {
  UserListBloc() : super(UserListInitialState());
   
      @override
      Stream<UserListState> mapEventToState(
        UserListEvent event,
      ) async* {
        if (event is GetUserListEvent) {
          yield UserListLoadingState();
          try {
            final userList = await UserListService.getUserList();
            if (userList != null) {
              yield UserListSuccessState(userListModel: userList);
            } else {
              yield UserListErrorState(error: "Başarısız");
            }
          } catch (e) {
            yield UserListErrorState(error: "Başarısız => $e");
          }
        }
        if (event is ClearUserListEvent) {
          yield UserListInitialState();
        }
      }
}
