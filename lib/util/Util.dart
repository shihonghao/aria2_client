import 'dart:convert';
import 'dart:math';

import 'package:aria2_client/aria2/model/json/converter.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

typedef DataConverter = double Function(double value, DataUnit toUnit);

enum DataUnit {
  B("b"),
  KB("kb"),
  MB("mb"),
  GB("gb");

  final String name;

  const DataUnit(this.name);

  double convertData(double value, DataUnit toUnit) {
    DataUnit fromUnit = DataUnit.fromName(name);
    if (fromUnit == toUnit) {
      return value;
    }
    switch (DataUnit.fromName(name)) {
      case DataUnit.B:
        switch (toUnit) {
          case DataUnit.B:
            return value;
          case DataUnit.KB:
            return double.parse((value / 1024).toStringAsFixed(2));
          case DataUnit.MB:
            return double.parse((value / 1024 / 1024).toStringAsFixed(2));
          case DataUnit.GB:
            return double.parse(
                (value / 1024 / 1024 / 1024).toStringAsFixed(2));
        }
      case DataUnit.KB:
        switch (toUnit) {
          case DataUnit.B:
            // return double.parse((value / 1024).toStringAsFixed(2));
            return 0.0;
          case DataUnit.KB:
            return value;
          case DataUnit.MB:
            return double.parse((value / 1024).toStringAsFixed(2));
          case DataUnit.GB:
            return double.parse((value / 1024 / 1024).toStringAsFixed(2));
        }
      case DataUnit.MB:
        switch (toUnit) {
          case DataUnit.B:
            // return double.parse((value / 1024 / 1024).toStringAsFixed(2));
            return 0.0;
          case DataUnit.KB:
            // return double.parse((value / 1024).toStringAsFixed(2));
            return 0.0;
          case DataUnit.MB:
            return value;
          case DataUnit.GB:
            return double.parse((value / 1024).toStringAsFixed(2));
        }
      case DataUnit.GB:
        switch (toUnit) {
          case DataUnit.B:
            // return double.parse(
            // (value / 1024 / 1024 / 1024).toStringAsFixed(2));
            return 0.0;
          case DataUnit.KB:
            // return double.parse((value / 1024 / 1024).toStringAsFixed(2));
            return 0.0;
          case DataUnit.MB:
            // return double.parse((value / 1024).toStringAsFixed(2));
            return 0.0;
          case DataUnit.GB:
            return value;
        }
    }
  }

  static DataUnit fromName(String name) {
    for (var value in DataUnit.values) {
      if (value.name == name) {
        return value;
      }
    }
    return DataUnit.B;
  }
}

class Util {
  static generateId(String prefix) {
    var round = (DateTime.now().millisecond / 1000).round();
    String sourceId = '${prefix}_'
        '$round'
        '_${Random().nextInt(1000000000)}';
    var hashedId = base64Encode(utf8.encode(sourceId));
    return hashedId;
  }

  static Pair<double, DataUnit> formatBytes(int? bytes) {
    if (bytes == null) {
      return Pair(first: 0.0, second: DataUnit.B);
    }
    double first = 0;
    DataUnit second = DataUnit.B;
    if (bytes >= 1024 && bytes < 1024 * 1024) {
      first = double.parse((bytes.toDouble() / 1024).toStringAsFixed(2));
      second = DataUnit.KB;
    } else if (bytes >= 1024 * 1024 && bytes < 1024 * 1024 * 1024) {
      first = double.parse((bytes.toDouble() / 1024 / 1024).toStringAsFixed(2));
      second = DataUnit.MB;
    } else if (bytes >= 1024 * 1024 * 1024) {
      first = double.parse(
          (bytes.toDouble() / 1024 / 1024 / 1024).toStringAsFixed(2));
      second = DataUnit.GB;
    }
    return Pair(first: first, second: second);
  }

  static Pair<double, DataUnit> formatBytesWithUnit(int? bytes, DataUnit unit) {
    if (bytes == null) {
      return Pair(first: 0.0, second: unit);
    }
    double value = 0;

    switch (unit) {
      case DataUnit.B:
        value = bytes.toDouble();
      case DataUnit.KB:
        value = double.parse((bytes.toDouble() / 1024).toStringAsFixed(2));
      case DataUnit.MB:
        value =
            double.parse((bytes.toDouble() / 1024 / 1024).toStringAsFixed(2));
      case DataUnit.GB:
        value = double.parse(
            (bytes.toDouble() / 1024 / 1024 / 1024).toStringAsFixed(2));
    }

    return Pair(first: value, second: unit);
  }

  static void showErrorToast(String msg) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.redAccent,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}

class Pair<T1, T2> {
  T1 first;
  T2 second;

  Pair({required this.first, required this.second});
}
