import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo_firebase/res/components/constants/custom_button.dart';
import 'package:todo_firebase/res/components/constants/custom_textformfield.dart';
import 'package:todo_firebase/res/utils/utils.dart';
import 'package:todo_firebase/viewmodel/controller/home/home_controller.dart';

class AddTaskSheet extends StatefulWidget {
  const AddTaskSheet({super.key});

  @override
  State<AddTaskSheet> createState() => _AddTaskSheetState();
}

class _AddTaskSheetState extends State<AddTaskSheet> {
  final taskController = TextEditingController();
  final desController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

   @override
  void dispose() {
    super.dispose();
    taskController.dispose();
    desController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final homeProvider = Provider.of<HomeController>(context, listen: false);

    final size = MediaQuery.sizeOf(context);
    final theme = Theme.of(context);
    return Consumer<HomeController>(
      builder: (context, value, child) => Container(
        padding: const EdgeInsets.all(16),
        width: size.width,
        height: size.height,
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Text(
                "Add Task",
                style: theme.textTheme.titleLarge!.copyWith(
                  color: theme.colorScheme.onSurface,
                ),
              ),
              const Gap(10),
              CustomTextFormfield(
                controller: taskController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Enter a task name";
                  }
                  return null;
                },
                fieldName: "Task",
              ),
              const Gap(10),
              CustomTextFormfield(
                controller: desController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Enter a description";
                  }
                  return null;
                },
                fieldName: "Description",
              ),
              const Gap(20),
              Align(
                alignment: Alignment.centerRight,
                child: CustomButton(
                  isIcon: true,
                  icon: Icons.calendar_month,
                  onPressed: () {
                    homeProvider.selectDate(context);
                  },
                  btnText: value.selectedDate == null
                      ? 'Select date'
                      : DateFormat.yMMMd().format(value.selectedDate!),
                ),
              ),
              const Gap(50),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("Cancel"),
                  ),
                  CustomButton(
                    status: value.status,
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        if (value.selectedDate == null) {
                          Utils().showToast("Select a date");
                        } else {
                          homeProvider.addTask(
                            taskController.text,
                            desController.text,
                            context,
                          );
                        }
                      }
                    },
                    btnText: "Add",
                  )
                ],
              ),
              const Gap(20),
            ],
          ),
        ),
      ),
    );
  }

 
}
