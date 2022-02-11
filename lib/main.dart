import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iwallet_project/core/constants/colors/colors.dart';
import 'package:iwallet_project/view/user_list/view/user_list_view.dart';
import 'package:iwallet_project/view/user_list/view_model/bloc/user_list_bloc.dart';
import 'package:iwallet_project/view/user_list/view_model/bloc/user_photo_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<UserListBloc>(
          create: (context) => UserListBloc(),
        ),
        BlocProvider<UserPhotoBloc>(
          create: (context) => UserPhotoBloc(),
        )
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: UIColors.themeColor),
      home: const UserListView(),
    );
  }
}
