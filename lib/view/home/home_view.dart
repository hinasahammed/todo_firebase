import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:todo_firebase/view/task/task_view.dart';
import 'package:todo_firebase/viewmodel/controller/auth/auth_controller.dart';
import 'package:todo_firebase/viewmodel/controller/home/home_controller.dart';

@RoutePage()
class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final authController = Provider.of<AuthController>(context);
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Home"),
          actions: [
            IconButton(
              onPressed: () {
                authController.logout(context);
              },
              icon: const Icon(Icons.logout),
            ),
          ],
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
                  isScrollable: true,
                  dividerColor: Colors.transparent,
                  tabs: [
                    Tab(
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        child: const Text("All"),
                      ),
                    ),
                    Tab(
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        child: const Text("Pending"),
                      ),
                    ),
                    Tab(
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        child: const Text("Completed"),
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
            HomeController().openSheet(context);
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
