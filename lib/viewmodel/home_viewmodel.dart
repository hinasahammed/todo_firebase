import 'package:flutter/material.dart';
import 'package:todo_firebase/view/widget/add_task_sheet_widget.dart';
import 'package:todo_firebase/view/widget/edit_task_widget.dart';

class HomeViewmodel {
  void openSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (context) => const AddTaskSheet(),
    );
  }

  void showEdit(BuildContext context, int index) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: EditTaskDialogue(
              index: index,
            ),
          );
        });
  }

  void addTask(String taskName, BuildContext context) {}
}
