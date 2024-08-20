import 'package:flutter/material.dart';

class Const {
  static Duration duration500ms = const Duration(milliseconds: 500);
  static Duration duration200ms = const Duration(milliseconds: 200);
  static Duration duration300ms = const Duration(milliseconds: 300);
  static Duration duration400ms = const Duration(milliseconds: 400);
  static Duration duration100ms = const Duration(milliseconds: 100);
  static Duration duration1s = const Duration(seconds: 1);
  static Duration duration2s = const Duration(seconds: 1);

  static Widget divider10 = const Padding(
    padding: EdgeInsets.symmetric(horizontal: 10),
    child: Divider(),
  );
}
