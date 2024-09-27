import 'dart:convert';
import 'dart:math';

import 'package:animations/animations.dart';
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

  static void showDialog(
      BuildContext context, WidgetBuilder contentBuilder, List<Widget> actions,
      {WidgetBuilder? titleBuilder}) {
    showModal(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: titleBuilder?.call(context),
            content: contentBuilder.call(context),
            actions: actions,
          );
        });
  }

  static void showConfirmDialog(BuildContext context,
      {required String title,
      required String content,
      VoidCallback? onConfirm}) {
    showDialog(
      context,
      titleBuilder: (context) {
        return Text(title);
      },
      (context) {
        return Text(content);
      },
      [
        TextButton(
          onPressed: () {
            onConfirm?.call();
            Navigator.of(context).pop();
          },
          child: const Text('确定'),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('取消'),
        ),
      ],
    );
  }

  static void showInputDialog(BuildContext context,
      {WidgetBuilder? contentBuilder,
      ValueChanged<String>? onConfirm,
      ValueChanged<String>? onCancel,
      String? text}) {
    TextEditingController controller = TextEditingController();
    controller.text = text ?? "";
    showDialog(
        context,
        contentBuilder ??
            (context) {
              return TextField(
                controller: controller,
                onChanged: (value) {
                  controller.text = value;
                },
              );
            },
        [
          TextButton(
            onPressed: () {
              onConfirm?.call(controller.text);
              Navigator.of(context).pop();
            },
            child: const Text('确定'),
          ),
          TextButton(
            onPressed: () {
              onCancel?.call(controller.text);
              Navigator.of(context).pop();
            },
            child: const Text('取消'),
          ),
        ], titleBuilder: (context) {
      return const Row(
        children: [
          Icon(Icons.edit),
          SizedBox(
            width: 10,
          ),
          Text("编辑"),
        ],
      );
    });
  }

  static showTextAlert(BuildContext context, String text,
      {VoidCallback? onConfirm, VoidCallback? onCancel}) {
    showModal(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Row(
              children: [
                Icon(Icons.info_outline),
                SizedBox(
                  width: 10,
                ),
                Text("提醒"),
              ],
            ),
            content: Text(text),
            actions: [
              TextButton(
                onPressed: () {
                  onConfirm?.call();
                  Navigator.of(context).pop();
                },
                child: const Text('确定'),
              ),
              TextButton(
                onPressed: () {
                  onCancel?.call();
                  Navigator.of(context).pop();
                },
                child: const Text('取消'),
              ),
            ],
          );
        });
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

  static void compareListAndFetch<T>(List<T> list1, List<T> list2,
      {bool Function(T o1, T o2)? compare,
      void Function(T o1, T o2)? fetch,
        Function(List<T> list, T item)? onRemove,
        Function(List<T> list, T item)? onInsert}) {
    onRemove ??= (list,item){
      list.remove(item);
    };
    onInsert ??= (list,item){
      list.add(item);
    };
    final result = compareList(list1, list2, compare: compare);
    final addList = result.first;
    final removeList = result.second;
    for (var item in removeList) {
     onRemove.call(list1,item);
    }

    for (var item in list1) {
      fetch?.call(
          item,
          list2.firstWhere(
              (e) => compare == null ? e == item : compare(e, item),orElse: () => item));
    }

    for (var item in addList) {
      onInsert.call(list1,item);
    }
  }

  static Pair<List<T>, List<T>> compareList<T>(List<T> list1, List<T> list2,
      {bool Function(T o1, T o2)? compare}) {
    List<T> addList = [];
    List<T> removeList = [];
    for (var item in list2) {
      if (list1.indexWhere(
              (e) => compare == null ? e == item : compare(e, item)) < 0 ) {
        addList.add(item);
      }
    }
    for (var item in list1) {
      if (list2.indexWhere(
              (e) => compare == null ? e == item : compare(e, item)) <
          0) {
        removeList.add(item);
      }
    }
    return Pair(first: addList, second: removeList);
  }
}

class Pair<T1, T2> {
  T1 first;
  T2 second;

  Pair({required this.first, required this.second});
}
