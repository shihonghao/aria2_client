import 'package:flutter/cupertino.dart';

class Aria2ThemeModel with ChangeNotifier {
  String _theme = 'blue';

  String get value => _theme;

  void setTheme(color) async {
    _theme = color;
    notifyListeners(); //通知依赖的Widget更新
  }
}
