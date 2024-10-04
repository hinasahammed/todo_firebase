import 'package:auto_route/auto_route.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:todo_firebase/model/user_model.dart';
import 'package:todo_firebase/viewmodel/controller/auth/auth_controller.dart';

@RoutePage()
class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final authController = Provider.of<AuthController>(context, listen: false);

    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.all(16),
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("Users")
              .doc(auth.currentUser!.uid)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.data == null ||
                !snapshot.hasData ||
                snapshot.data!.data()!.isEmpty) {
              return Center(
                child: Text("Something went wrong!"),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text("Something went wrong!"),
              );
            } else {
              final user = UserModel.fromMap(snapshot.data!.data()!);
              return Column(
                children: [
                  Gap(30),
                  AvatarGlow(
                    glowRadiusFactor: .3,
                    glowCount: 2,
                    startDelay: const Duration(milliseconds: 1000),
                    glowColor: theme.colorScheme.primary,
                    glowShape: BoxShape.circle,
                    curve: Curves.fastOutSlowIn,
                    child: Container(
                      width: 150,
                      height: 150,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: NetworkImage(user.imageUrl),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Gap(40),
                  Text(
                    user.userName.toUpperCase(),
                    style: theme.textTheme.titleLarge!.copyWith(
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                  Text(
                    user.email.toUpperCase(),
                    style: theme.textTheme.labelLarge!.copyWith(
                      color: theme.colorScheme.onSurface.withOpacity(.5),
                    ),
                  ),
                  Spacer(),
                  Card(
                    child: ListTile(
                      onTap: () {
                        authController.logout(context);
                      },
                      leading: Icon(Icons.logout),
                      title: Text("Logout"),
                      trailing: Icon(Icons.keyboard_arrow_right),
                    ),
                  )
                ],
              );
            }
          },
        ),
      )),
    );
  }
}
