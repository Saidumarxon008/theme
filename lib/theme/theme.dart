import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'constant.dart';

class ThemeProvider with ChangeNotifier {
  bool isLightTheme;

  ThemeProvider({required this.isLightTheme});

    getCurrentNavigationColor() {
    if (isLightTheme) {
      SystemChrome.setSystemUIOverlayStyle(
          const SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarBrightness: Brightness.light,
            statusBarIconBrightness: Brightness.dark,
            systemNavigationBarColor: Colors.white,
            systemNavigationBarIconBrightness: Brightness.dark,
          )
      );
    } else {
      SystemChrome.setSystemUIOverlayStyle(
          const SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarBrightness: Brightness.dark,
            statusBarIconBrightness: Brightness.light,
            systemNavigationBarColor: Colors.black,
            systemNavigationBarIconBrightness: Brightness.light,
          )
      );
    }
  }

  toggleThemeData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if (isLightTheme) {
      sharedPreferences.setBool(SPref.isLight, false);
      isLightTheme = !isLightTheme;
      notifyListeners();
    }
    else {
      sharedPreferences.setBool(SPref.isLight, true);
      isLightTheme = !isLightTheme;
      notifyListeners();
  }
    getCurrentNavigationColor();
    notifyListeners();
  }

  ThemeData themeData() {
    return ThemeData(
      brightness: isLightTheme ? Brightness.light : Brightness.dark,
      scaffoldBackgroundColor: isLightTheme ? Colors.deepOrangeAccent : Colors
          .black,
    );
  }

  ThemeMode themeMode() {
    return ThemeMode(
      gradientColors: isLightTheme ? [Colors.deepOrange, Colors.orange] : [
        Colors.black,
        Colors.black
      ],
      switchColor: isLightTheme ? Colors.black : Colors.deepOrange,
      switchBgColor: isLightTheme ? Colors.black.withOpacity(.1) : Colors.grey
          .withOpacity(.3),
      thumbColor: isLightTheme ? Colors.deepOrange : Colors.black,
    );
  }
}

class ThemeMode {
  List<Color>? gradientColors;
  Color? switchColor;
  Color? thumbColor;
  Color? switchBgColor;

  ThemeMode(
      {this.gradientColors, this.switchColor, this.thumbColor, this.switchBgColor,});
}