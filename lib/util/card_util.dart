import 'dart:ui';

import 'package:flutter/material.dart';

class CardUtil {
  static Widget buildFilterCard(Widget child) {
    return Card(
      color: const Color.fromARGB(0, 255, 255, 255),
      surfaceTintColor: Colors.black,
      shadowColor: Colors.black,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(30))),
      elevation: 5,
      margin: const EdgeInsets.all(10),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(30)),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 100, sigmaY: 100),
          child: child,
        ),
      ),
      // ),
    );
  }
}
