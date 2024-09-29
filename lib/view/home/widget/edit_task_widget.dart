import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:todo_firebase/res/components/constants/custom_button.dart';
import 'package:todo_firebase/res/components/constants/custom_textformfield.dart';
import 'package:todo_firebase/viewmodel/controller/home/home_controller.dart';

class EditTaskDialogue extends StatefulWidget {
  final String docId;
  const EditTaskDialogue({super.key, required this.docId});

  @override
  State<EditTaskDialogue> createState() => _EditTaskDialogueState();
}

class _EditTaskDialogueState extends State<EditTaskDialogue> {
  final taskController = TextEditingController();
  final descController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.sizeOf(context);
    final homeProvider = Provider.of<HomeController>(context, listen: false);
    return Consumer<HomeController>(
      builder: (context, value, child) => Container(
        height: size.height * .3,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Edit task",
              style: theme.textTheme.titleLarge!.copyWith(
                color: theme.colorScheme.onSurface,
              ),
            ),
            const Gap(20),
            CustomTextFormfield(
              controller: taskController,
              fieldName: "Task name",
            ),
            const Gap(10),
            CustomTextFormfield(
              controller: descController,
              fieldName: "Description",
            ),
            const Spacer(),
            Row(
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Cancel"),
                ),
                const Gap(10),
                CustomButton(
                  status: value.status,
                  onPressed: () {
                    homeProvider.updateTask(
                      widget.docId,
                      taskController.text,
                      descController.text,
                      context,
                    );
                  },
                  btnText: "Update",
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
