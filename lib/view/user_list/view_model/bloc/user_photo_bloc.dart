import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:iwallet_project/core/services/user_list_service.dart';
import 'package:iwallet_project/view/user_list/model/user_info_model.dart';

part 'user_photo_event.dart';
part 'user_photo_state.dart';

class UserPhotoBloc extends Bloc<UserPhotoEvent, UserPhotoState> {
  UserPhotoBloc() : super(UserPhotoInitialState());

  @override
  Stream<UserPhotoState> mapEventToState(
    UserPhotoEvent event,
  ) async* {
    if (event is GetUserPhotoEvent) {
      yield UserPhotoLoadingState();
      List<UserInfoModel> userphotos = [];
      try {
        for (var i = 0; i < event.length; i++) {
          final userPhoto = await UserListService.getUserPhoto(i);
          if (userPhoto != null) {
            userphotos.add(userPhoto);
          }
        }
        if (userphotos.isNotEmpty) {
          yield UserPhotoSuccessState(userInfoModelList: userphotos);
        }
      } catch (e) {
        yield UserPhotoErrorState(error: "Başarısız => $e");
      }
    }
    if (event is ClearUserPhotoEvent) {
      yield UserPhotoInitialState();
    }
  }
}
