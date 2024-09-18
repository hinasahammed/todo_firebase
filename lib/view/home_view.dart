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
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView.builder(
              itemCount: 2,
              shrinkWrap: true,
              itemBuilder: (context, index) {
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
                    return null;
                  },
                  key: ValueKey(index),
                  child: Card(
                    clipBehavior: Clip.hardEdge,
                    child: ListTile(
                        tileColor: theme.colorScheme.primaryContainer,
                        leading: Checkbox(
                          value: false,
                          onChanged: (value) {},
                        ),
                        title: Text(
                          "Title",
                          style: theme.textTheme.titleLarge!.copyWith(
                            color: theme.colorScheme.primary,
                            fontWeight: FontWeight.w600,
                            decorationColor: theme.colorScheme.onPrimary,
                            decorationThickness: 3,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                        subtitle: Text(
                          "Date",
                          style: theme.textTheme.labelLarge!.copyWith(
                            color: theme.colorScheme.primary.withOpacity(.4),
                          ),
                        ),
                        trailing: Wrap(
                          children: [
                            IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.edit,
                                color: theme.colorScheme.primary,
                              ),
                            ),
                          ],
                        )),
                  ),
                );
              }),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          HomeViewmodel().openSheet(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
