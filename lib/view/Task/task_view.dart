import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:todo_firebase/gen/assets.gen.dart';
import 'package:todo_firebase/res/utils/task_container_colors.dart';
import 'package:todo_firebase/viewmodel/controller/home/home_controller.dart';

class TaskView extends StatefulWidget {
  final String type;
  const TaskView({super.key, required this.type});

  @override
  State<TaskView> createState() => _TaskViewState();
}

class _TaskViewState extends State<TaskView> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return StreamBuilder(
      stream: widget.type == "All"
          ? FirebaseFirestore.instance.collection("todo").snapshots()
          : FirebaseFirestore.instance
              .collection("todo")
              .where("status", isEqualTo: widget.type)
              .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasData ||
            snapshot.data != null ||
            snapshot.data!.docs.isNotEmpty) {
          return snapshot.data!.docs.isEmpty
              ? Center(
                  child: Text(
                    "No Task Found",
                    style: theme.textTheme.titleLarge!.copyWith(
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                )
              : ListView.separated(
                  separatorBuilder: (context, index) => Gap(10),
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    final data = snapshot.data!.docs[index];
                    return Dismissible(
                      background: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.greenAccent,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Gap(20),
                            Icon(
                              Icons.check,
                              color: theme.colorScheme.onPrimary,
                            ),
                            const Gap(20),
                            Text(
                              "Mark as Done",
                              style: theme.textTheme.bodyLarge!.copyWith(
                                color: theme.colorScheme.onPrimary,
                              ),
                            ),
                          ],
                        ),
                      ),
                      secondaryBackground: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: theme.colorScheme.error,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Icon(
                              Icons.arrow_back,
                              color: theme.colorScheme.onError,
                            ),
                            const Gap(20),
                            Text(
                              "Delete Task",
                              style: theme.textTheme.bodyLarge!.copyWith(
                                color: theme.colorScheme.onError,
                              ),
                            ),
                            const Gap(20),
                            Icon(
                              Icons.delete,
                              color: theme.colorScheme.onError,
                            ),
                            const Gap(20),
                          ],
                        ),
                      ),
                      confirmDismiss: (direction) async {
                        if (direction == DismissDirection.endToStart) {
                          HomeController().confirmRemoveTask(context, data.id);
                        } else if (direction == DismissDirection.startToEnd) {
                          HomeController().updateStatus(context, data.id);
                        }
                        return null;
                      },
                      key: ValueKey(index),
                      child: Card(
                        child: Container(
                          width: double.infinity,
                          height: 180,
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: const Color(0xffEBEBEB),
                            borderRadius: BorderRadius.circular(20),
                            image: DecorationImage(
                              image:
                                  Assets.images.taskContainerShape.provider(),
                              fit: BoxFit.fill,
                              colorFilter: ColorFilter.mode(
                                taskShapeColor[
                                        Random().nextInt(taskShapeColor.length)]
                                    .withOpacity(.8),
                                BlendMode.srcATop,
                              ),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(6),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      border: Border.all(
                                        color: theme.colorScheme.surface,
                                      ),
                                    ),
                                    child: Text(
                                      data['status'],
                                      style: theme.textTheme.labelLarge!
                                          .copyWith(
                                              color:
                                                  theme.colorScheme.onSurface),
                                    ),
                                  ),
                                  const Gap(5),
                                  Icon(
                                    data['status'] == "pending"
                                        ? Icons.pending
                                        : Icons.done_all_sharp,
                                    color: theme.colorScheme.surface,
                                    size: 30,
                                  ),
                                  const Spacer(),
                                  Text(
                                    data['date'],
                                    style: theme.textTheme.labelLarge!.copyWith(
                                      color: theme.colorScheme.surface,
                                    ),
                                  ),
                                ],
                              ),
                              const Gap(20),
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      data['taskName'],
                                      style:
                                          theme.textTheme.bodyLarge!.copyWith(
                                        color: theme.colorScheme.surface,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                    ),
                                    onPressed: () {
                                      HomeController()
                                          .showEdit(context, data.id);
                                    },
                                    child: const Icon(Icons.edit),
                                  )
                                ],
                              ),
                              const Gap(10),
                              Text(
                                data['desc'],
                                style: theme.textTheme.bodyLarge!.copyWith(
                                  color: theme.colorScheme.surface,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
        } else {
          return Center(
            child: Text(
              "No data found",
              style: theme.textTheme.headlineLarge!.copyWith(
                color: theme.colorScheme.onSurface,
              ),
            ),
          );
        }
      },
    );
  }
}
