import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:iwallet_project/core/constants/app/application_constants.dart';
import 'package:iwallet_project/view/user_list/model/user_info_model.dart';
import 'package:iwallet_project/view/user_list/model/user_list_model.dart';

class UserListService {
  static Future<List<UserListModel>?> getUserList() async {
    try {
      final _response = await http.get(
        Uri.parse(ApplicationConstants.USER_LIST_URL),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );
      if (_response.statusCode == 200) {
        return userListModelFromJson(_response.body);
      } else {
        return jsonDecode(_response.body)["message"];
      }
    } on Exception catch (e) {
      debugPrint(
        e.toString(),
      );
    }
  }

  static Future<UserInfoModel?> getUserPhoto(int index) async {
    try {
      final _response = await http.get(
        Uri.parse("https://picsum.photos/id/$index/info"),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );
      if (_response.statusCode == 200) {
        return userInfoModelFromJson(_response.body);
      } else {
        return jsonDecode(_response.body)["message"];
      }
    } on Exception catch (e) {
      debugPrint(
        e.toString(),
      );
    }
  }
}
