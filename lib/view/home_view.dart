import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:todo_firebase/gen/assets.gen.dart';
import 'package:todo_firebase/res/utils/task_container_colors.dart';
import 'package:todo_firebase/viewmodel/home_viewmodel.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Hello,",
              style: theme.textTheme.titleLarge!.copyWith(
                color: theme.colorScheme.onSurface,
              ),
            ),
            const Gap(10),
            StreamBuilder(
              stream: FirebaseFirestore.instance.collection("todo").snapshots(),
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
                      : ListView.builder(
                          itemCount: snapshot.data!.docs.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            final data = snapshot.data!.docs[index];
                            return Dismissible(
                              background: Container(
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
                                      "Remove",
                                      style:
                                          theme.textTheme.bodyLarge!.copyWith(
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
                                HomeViewmodel()
                                    .confirmRemoveTask(context, data.id);
                                return null;
                              },
                              key: ValueKey(index),
                              child: Card(
                                child: Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: const Color(0xffEBEBEB),
                                    borderRadius: BorderRadius.circular(20),
                                    image: DecorationImage(
                                      image: Assets.images.taskContainerShape
                                          .provider(),
                                      fit: BoxFit.fitWidth,
                                      colorFilter: ColorFilter.mode(
                                        taskShapeColor[Random()
                                                .nextInt(taskShapeColor.length)]
                                            .withOpacity(.8),
                                        BlendMode.srcATop,
                                      ),
                                    ),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.all(6),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              border: Border.all(
                                                color:
                                                    theme.colorScheme.surface,
                                              ),
                                            ),
                                            child: Text(
                                              data['status'],
                                              style: theme.textTheme.labelLarge!
                                                  .copyWith(
                                                      color: theme.colorScheme
                                                          .onSurface),
                                            ),
                                          ),
                                          const Gap(5),
                                          Icon(
                                            data['status'] == "pending"
                                                ? Icons.pending
                                                : Icons.done,
                                            color: theme.colorScheme.surface,
                                          ),
                                          const Spacer(),
                                          Text(
                                            data['date'],
                                            style: theme.textTheme.labelLarge!
                                                .copyWith(
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
                                              style: theme.textTheme.bodyLarge!
                                                  .copyWith(
                                                color:
                                                    theme.colorScheme.surface,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                          ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ),
                                            ),
                                            onPressed: () {
                                              HomeViewmodel()
                                                  .showEdit(context, data.id);
                                            },
                                            child: const Icon(Icons.edit),
                                          )
                                        ],
                                      ),
                                      const Gap(20)
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
            ),
          ],
        ),
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          HomeViewmodel().openSheet(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
