import 'package:aria2_client/model/task.dart';
import 'package:aria2_client/ui/pages/download/detail/pieces_info.dart';
import 'package:aria2_client/util/Util.dart';
import 'package:flutter/material.dart';

class TaskModel extends ChangeNotifier {
  final String key;
  final ValueNotifier<Piece> piece;
  Task task;
  bool isSelected;

  TaskModel({required this.task, this.isSelected = false})
      : key = Util.generateId("TASK"),
        piece = ValueNotifier(Piece(
            bitfield: task.bitfield ?? "f", numPieces: task.numPieces ?? 1));

  update(Task task) {
    piece.value =
        Piece(bitfield: task.bitfield ?? "f", numPieces: task.numPieces ?? 1);
    this.task = task;
    notifyListeners();
  }
}
