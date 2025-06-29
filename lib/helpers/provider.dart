import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_app/helpers/global_variable.dart';
import 'dart:async';

class AppStateModel extends ChangeNotifier {
  final _box = Hive.box('hivebox');

  List<MapEntry<dynamic, dynamic>> get enteries =>
      _box.toMap().entries.toList();

  void initstate() {
    calculateTimeLeftToday();
    startTimer();
  }

  void calculateTimeLeftToday() {
    final now = DateTime.now();
    final midnight = DateTime(now.year, now.month, now.day + 1);
    d = midnight.difference(now);
  }

  void startTimer() {
    Timer.periodic(Duration(seconds: 1), (timer) {
      d = d - Duration(seconds: 1);

      if (d.isNegative || d.inSeconds == 0) {
        calculateTimeLeftToday();
      }
      notifyListeners();
    });
  }

  String formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    return "${twoDigits(duration.inHours)}:"
        "${twoDigits(duration.inMinutes % 60)}:"
        "${twoDigits(duration.inSeconds % 60)}";
  }

  void updateTasks(dynamic key, bool newValue) {
    final task = _box.get(key);
    if (task is Map && task.containsKey('title')) {
      _box.put(key, {'title': task['title'], 'completion': newValue});
    }
    notifyListeners();
  }

  void write(Map newTask) {
    _box.add(newTask);
    notifyListeners();
    myController.clear();
  }

  void taskRemoval(keyz) {
    _box.delete(keyz);
    notifyListeners();
  }

  bool? toggleInputBox() {
    textinputs = false;
    notifyListeners();
    return null;
  }
}
