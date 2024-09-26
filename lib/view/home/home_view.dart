import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:todo_firebase/view/task/task_view.dart';
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
    return DefaultTabController(
      length: 3,
      child: Scaffold(
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
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Gap(5),
                Text(
                  "Look at your task",
                  style: theme.textTheme.bodyLarge!.copyWith(
                    color: theme.colorScheme.onSurface,
                  ),
                ),
                const Gap(10),
                TabBar(
                  dividerColor: Colors.transparent,
                  tabs: [
                    Tab(
                      child: Card(
                        child: Container(
                          padding: const EdgeInsets.all(6),
                          child: const Text("All"),
                        ),
                      ),
                    ),
                    Tab(
                      child: Card(
                        child: Container(
                          padding: const EdgeInsets.all(6),
                          child: const Text("Pending"),
                        ),
                      ),
                    ),
                    Tab(
                      child: Card(
                        child: Container(
                          padding: const EdgeInsets.all(6),
                          child: const Text("Completed"),
                        ),
                      ),
                    ),
                  ],
                ),
                const Gap(10),
                const Expanded(
                  child: TabBarView(
                    children: [
                      TaskView(
                        type: "All",
                      ),
                      TaskView(
                        type: "pending",
                      ),
                      TaskView(
                        type: "completed",
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            HomeViewmodel().openSheet(context);
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
