// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iwallet_project/core/constants/box_decorations/box_decorations.dart';
import 'package:iwallet_project/core/constants/colors/colors.dart';
import 'package:iwallet_project/core/constants/paddings/paddings.dart';
import 'package:iwallet_project/core/constants/shapes/shapes.dart';
import 'package:iwallet_project/core/constants/strings/strings.dart';
import 'package:iwallet_project/core/constants/styles/text_styles.dart';
import 'package:iwallet_project/view/user_list/model/user_info_model.dart';
import 'package:iwallet_project/view/user_list/model/user_list_model.dart';
import 'package:iwallet_project/view/user_list/view_model/bloc/user_list_bloc.dart';
import 'package:iwallet_project/view/user_list/view_model/bloc/user_photo_bloc.dart';

class UserListView extends StatefulWidget {
  const UserListView({Key? key}) : super(key: key);

  @override
  _UserListViewState createState() => _UserListViewState();
}

class _UserListViewState extends State<UserListView> {
  TextEditingController userListController = TextEditingController();
  List<UserListModel> users = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: UIColors.themeColor,
        shape: Shapes().appbarShape,
        title: const Text('IWallet APP'),
        centerTitle: true,
        elevation: 0,
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: SizedBox(
          child: BlocBuilder<UserListBloc, UserListState>(
              builder: (context, state) {
            if (state is UserListSuccessState) {
              return BlocBuilder<UserPhotoBloc, UserPhotoState>(
                  builder: (context, photoState) {
                if (photoState is UserPhotoSuccessState) {
                  return Column(
                    children: [
                      searchBox(state.userListModel!),
                      userListController.text.isNotEmpty
                          ? users.isEmpty
                              ? Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Image.network(Strings.userNotFoundPicUrl),
                                    Text('Kullanıcı Bulunamadı!',
                                        style: TextStyles.nameTextStyle),
                                  ],
                                )
                              : Expanded(
                                  child: searchResultListView(
                                      state.userListModel!,
                                      photoState.userInfoModelList))
                          : Expanded(
                              child: userListView(state.userListModel!,
                                  photoState.userInfoModelList),
                            ),
                    ],
                  );
                }
                if (photoState is UserPhotoInitialState) {
                  BlocProvider.of<UserPhotoBloc>(context).add(
                      GetUserPhotoEvent(length: state.userListModel!.length));
                }

                if (photoState is UserPhotoErrorState) {
                  return const Center(
                    child: Text('Kullanıcılar Yüklenemedi..'),
                  );
                }
                if (photoState is UserPhotoLoadingState) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return const Center(
                  child: Text('Bloc Başarısız'),
                );
              });
            }
            if (state is UserListInitialState) {
              BlocProvider.of<UserListBloc>(context).add(GetUserListEvent());
            }
            if (state is UserListErrorState) {
              return const Center(
                child: Text('Kullanıcılar Yüklenemedi..'),
              );
            }
            if (state is UserListLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return Center(child: const Text('Bloc Başarısız'));
          }),
        ),
      ),
    );
  }

  Future<dynamic> userInfoPopup(
      BuildContext context, UserListModel user, UserInfoModel infoModel) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: Shapes().alertDialogShape,
            content: SizedBox(
              height: MediaQuery.of(context).size.height * 0.55,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Align(
                        alignment: Alignment.topRight,
                        child: InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Icon(Icons.clear))),
                    Container(
                      decoration: BoxDecorations.alertDialogBoxDecoration,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CircleAvatar(
                              radius: 60,
                              backgroundImage: NetworkImage(
                                  infoModel.downloadUrl.toString())),
                          SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.02),
                          Text(
                            user.name!,
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.003),
                          Text(
                            "@" + user.username!,
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.003),
                          Text(
                            "Email: " + user.email!,
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.003),
                          Text(
                            "Telefon: " + user.phone!,
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.003),
                          Text(
                            "Adres: " +
                                user.address!.city! +
                                user.address!.street! +
                                user.address!.suite!.toString(),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.003),
                          Text(
                            "Şehir " + user.address!.city.toString(),
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            "Konum: " +
                                user.address!.geo!.lat.toString() +
                                "/" +
                                user.address!.geo!.lng!.toString(),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  Widget searchResultListView(
      List<UserListModel> userList, List<UserInfoModel> infoList) {
    return ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: Paddings().listViewPaddings,
            child: Container(
              decoration: BoxDecorations.searchResultBoxDecoration,
              child: ListTile(
                onTap: () {
                  userInfoPopup(context, userList[index], infoList[index]);
                },
                leading: CircleAvatar(
                    radius: 45,
                    backgroundImage:
                        NetworkImage(infoList[index].downloadUrl.toString())),
                title: Text(
                  users[index].name!,
                  style: TextStyles.listTextStyle,
                ),
                subtitle: Text(
                  users[index].username!,
                  style: TextStyles.listTextStyle,
                ),
                trailing: const Icon(Icons.arrow_forward_ios),
              ),
            ),
          );
        });
  }

  Widget userListView(
      List<UserListModel> userList, List<UserInfoModel> infoList) {
    return ListView.builder(
        itemCount: userList.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: Paddings().listViewPaddings,
            child: Container(
              decoration: BoxDecorations.userListViewBoxDecoration,
              child: ListTile(
                onTap: () {
                  userInfoPopup(context, userList[index], infoList[index]);
                },
                leading: CircleAvatar(
                    radius: 45,
                    backgroundImage:
                        NetworkImage(infoList[index].downloadUrl.toString())),
                title: Text(
                  userList[index].name!,
                  style:TextStyles.listTextStyle,
                ),
                subtitle: Text(
                  userList[index].username!,
                  style: TextStyles.listTextStyle,
                ),
                trailing: const Icon(Icons.arrow_forward_ios),
              ),
            ),
          );
        });
  }

  Widget searchBox(List<UserListModel> userList) {
    return Container(
      padding: Paddings().searchBoxPaddings,
      child: Theme(
        data: Theme.of(context).copyWith(
          colorScheme: ThemeData().colorScheme.copyWith(
                primary: UIColors.themeColor,
              ),
        ),
        child: TextFormField(
          controller: userListController,
          onChanged: (text) {
            users.clear();
            if (text.isEmpty) {
              setState(() {});
              return;
            }
            for (var element in userList) {
              if (element.name!.toLowerCase().contains(text.toLowerCase())) {
                users.add(element);
              }
            }
            setState(() {});
          },
          decoration: InputDecoration(
            hintText: 'Search',
            prefixIcon: const Icon(Icons.search, size: 30),
            filled: true,
            suffixIcon: userListController.text.isNotEmpty
                ? InkWell(
                    onTap: () {
                      setState(() {
                        userListController.text = "";
                      });
                    },
                    child:
                        Icon(Icons.clear, color: UIColors.themeColor, size: 30))
                : const SizedBox(),
            fillColor: UIColors.searchBoxColor,
            contentPadding: const EdgeInsets.all(15),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(
                color: UIColors.searchBoxColor,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(
                color: UIColors.searchBoxColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
