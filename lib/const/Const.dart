import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Const {
  static Duration duration500ms = const Duration(milliseconds: 500);
  static Duration duration200ms = const Duration(milliseconds: 200);
  static Duration duration300ms = const Duration(milliseconds: 300);
  static Duration duration400ms = const Duration(milliseconds: 400);
  static Duration duration100ms = const Duration(milliseconds: 100);
  static Duration duration1s = const Duration(seconds: 1);
  static Duration duration2s = const Duration(seconds: 1);

  static ShapeBorder roundedRectangleBorder10 = RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(10.w)));
  static ShapeBorder roundedRectangleBorder20 = RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(20.w)));
  static ShapeBorder roundedRectangleBorder30 = RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(30.w)));

  static TextStyle fontSm = TextStyle(fontSize: 10.sp);
  static TextStyle fontMd = TextStyle(fontSize: 15.sp);
  static TextStyle fontLg = TextStyle(fontSize: 20.sp);


  static Widget divider10 = const Padding(
    padding: EdgeInsets.symmetric(horizontal: 10),
    child: Divider(),
  );
}
