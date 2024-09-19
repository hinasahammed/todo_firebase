import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
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
          child: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("todo").snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasData ||
              snapshot.data != null ||
              snapshot.data!.docs.isNotEmpty) {
            return ListView.builder(
                padding: const EdgeInsets.all(16),
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
                      HomeViewmodel().confirmRemoveTask(context, data.id);
                      return null;
                    },
                    key: ValueKey(index),
                    child: Card(
                      clipBehavior: Clip.hardEdge,
                      child: ListTile(
                          tileColor: theme.colorScheme.primaryContainer,
                          leading: Checkbox(
                            value: data['isCompleted'],
                            onChanged: (value) {
                              HomeViewmodel()
                                  .completedTask(value!, context, data.id);
                            },
                          ),
                          title: Text(
                            data['taskName'],
                            style: theme.textTheme.titleLarge!.copyWith(
                              color: theme.colorScheme.primary,
                              fontWeight: FontWeight.w600,
                              decorationColor: theme.colorScheme.onPrimary,
                              decorationThickness: 3,
                              decoration: data['isCompleted']
                                  ? TextDecoration.lineThrough
                                  : TextDecoration.none,
                            ),
                          ),
                          subtitle: Text(
                            data['date'],
                            style: theme.textTheme.labelLarge!.copyWith(
                              color: theme.colorScheme.primary.withOpacity(.4),
                            ),
                          ),
                          trailing: Wrap(
                            children: [
                              IconButton(
                                onPressed: () {
                                  HomeViewmodel().showEdit(context, data.id);
                                },
                                icon: Icon(
                                  Icons.edit,
                                  color: theme.colorScheme.primary,
                                ),
                              ),
                            ],
                          )),
                    ),
                  );
                });
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
