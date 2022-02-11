import 'package:flutter/material.dart';

class Shapes {
  final appbarShape = const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(15), bottomRight: Radius.circular(15)));

  final alertDialogShape = const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(20.0),
    ),
  );
}
