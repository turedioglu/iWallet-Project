import 'package:flutter/material.dart';

class BoxDecorations {
  static BoxDecoration userListViewBoxDecoration = BoxDecoration(
      border: Border.all(color: Colors.black),
      borderRadius: const BorderRadius.all(Radius.circular(15)));

  static BoxDecoration alertDialogBoxDecoration = BoxDecoration(
    borderRadius: BorderRadius.circular(40),
  );

  static BoxDecoration searchResultBoxDecoration = BoxDecoration(
      border: Border.all(color: Colors.black),
      borderRadius: const BorderRadius.all(Radius.circular(15)));
}
