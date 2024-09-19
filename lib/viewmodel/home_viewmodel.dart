import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_firebase/data/response/status.dart';
import 'package:todo_firebase/model/task_model.dart';
import 'package:todo_firebase/res/utils/utils.dart';
import 'package:todo_firebase/view/widget/add_task_sheet_widget.dart';
import 'package:todo_firebase/view/widget/edit_task_widget.dart';

class HomeViewmodel extends ChangeNotifier {
  final firestore = FirebaseFirestore.instance;
  Status _status = Status.completed;
  Status get status => _status;
  DateTime? _selectedDate;
  DateTime? get selectedDate => _selectedDate;

  void changeStatus(Status newStatus) {
    _status = newStatus;
    notifyListeners();
  }

  void openSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (context) => const AddTaskSheet(),
    );
  }

  void showEdit(BuildContext context, String docId) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: EditTaskDialogue(
              docId: docId,
            ),
          );
        });
  }

  void selectDate(BuildContext context) async {
    final selectDate = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
    );
    if (selectDate == null) {
      if (context.mounted) {
        Utils().showFlushToast(context, "Error", "Select a date");
      }
    } else {
      _selectedDate = selectDate;
      notifyListeners();
    }
  }

  Future addTask(String taskName, BuildContext context) async {
    changeStatus(Status.loading);
    try {
      await firestore
          .collection("todo")
          .doc()
          .set(TaskModel(
            taskName: taskName,
            date: DateFormat.yMMMd().format(_selectedDate!),
          ).toMap())
          .then(
        (value) {
          if (context.mounted) {
            Navigator.pop(context);
          }
        },
      );
      _selectedDate = null;
      notifyListeners();
      changeStatus(Status.completed);
    } catch (e) {
      changeStatus(Status.error);

      if (context.mounted) {
        Utils().showFlushToast(context, "Error", e.toString());
      }
    }
  }

  Future completedTask(
      bool newValue, BuildContext context, String docId) async {
    try {
      await firestore.collection("todo").doc(docId).update({
        "isCompleted": newValue,
      });
    } catch (e) {
      if (context.mounted) {
        Utils().showFlushToast(context, "Error", e.toString());
      }
    }
  }

  Future updateTask(
    String docId,
    String newTaskname,
    BuildContext context,
  ) async {
    changeStatus(Status.loading);
    try {
      await firestore.collection("todo").doc(docId).update({
        "taskName": newTaskname,
      }).then(
        (value) {
          if (context.mounted) {
            Navigator.pop(context);
          }
        },
      ).whenComplete(
        () => changeStatus(Status.completed),
      );
    } catch (e) {
      changeStatus(Status.error);
      if (context.mounted) {
        Utils().showFlushToast(context, "Error", e.toString());
      }
    }
  }
}
