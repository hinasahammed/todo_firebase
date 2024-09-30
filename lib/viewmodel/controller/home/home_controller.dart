import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_firebase/data/response/response.dart';
import 'package:todo_firebase/model/task_model.dart';
import 'package:todo_firebase/res/components/constants/custom_button.dart';
import 'package:todo_firebase/res/utils/utils.dart';
import 'package:todo_firebase/view/home/widget/add_task_sheet_widget.dart';
import 'package:todo_firebase/view/home/widget/edit_task_widget.dart';

class HomeController extends ChangeNotifier {
  final firestore = FirebaseFirestore.instance;
  Response _status = Response.completed;
  Response get status => _status;
  DateTime? _selectedDate;
  DateTime? get selectedDate => _selectedDate;

  void changeStatus(Response newStatus) {
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
        Utils().showToast("Select a date");
      }
    } else {
      _selectedDate = selectDate;
      notifyListeners();
    }
  }

  Future addTask(String taskName, String desc, BuildContext context) async {
    changeStatus(Response.loading);
    try {
      await firestore
          .collection("todo")
          .doc()
          .set(TaskModel(
            taskName: taskName,
            desc: desc,
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
      changeStatus(Response.completed);
    } catch (e) {
      changeStatus(Response.error);

      if (context.mounted) {
        Utils().showToast(e.toString());
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
        Utils().showToast(e.toString());
      }
    }
  }

  Future updateTask(
    String docId,
    String newTaskname,
    String newDesc,
    BuildContext context,
  ) async {
    changeStatus(Response.loading);
    try {
      await firestore.collection("todo").doc(docId).update({
        "taskName": newTaskname,
        "desc": newDesc,
      }).then(
        (value) {
          if (context.mounted) {
            Navigator.pop(context);
          }
        },
      ).whenComplete(
        () => changeStatus(Response.completed),
      );
    } catch (e) {
      changeStatus(Response.error);
      if (context.mounted) {
        Utils().showToast(e.toString());
      }
    }
  }

  void confirmRemoveTask(BuildContext context, String docId) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: const Text("Are you want to remove task?"),
        icon: const Icon(Icons.delete),
        title: const Text("Remove"),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Cancel")),
          CustomButton(
            onPressed: () {
              removeTask(docId, context);
              Navigator.pop(context);
              Utils().showToast("Successfully task removed");
            },
            btnText: "Remove",
          ),
        ],
      ),
    );
  }

  Future removeTask(
    String docId,
    BuildContext context,
  ) async {
    changeStatus(Response.loading);
    try {
      await firestore.collection("todo").doc(docId).delete();
    } catch (e) {
      changeStatus(Response.error);
      if (context.mounted) {
        Utils().showToast(e.toString());
      }
    }
  }

  Future updateStatus(
    BuildContext context,
    String docId,
  ) async {
    try {
      await firestore
          .collection("todo")
          .doc(docId)
          .update({"status": "completed"});
    } catch (e) {
      if (context.mounted) {
        Utils().showToast(e.toString());
      }
    }
  }
}
