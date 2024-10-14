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
    UserInfo? provider;
    final theme = Theme.of(context);
    final authController = Provider.of<AuthController>(context, listen: false);
    final currentUser = auth.currentUser;
    if (currentUser != null) {
      for (UserInfo value in currentUser.providerData) {
        provider = value;
      }
    }

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
              },
              icon: Icon(Icons.logout))
        ],
      ),
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.all(16),
        child: provider?.providerId == "google.com"
            ? Image.network(auth.currentUser!.photoURL!)
            : StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("Users")
                    .doc(auth.currentUser!.uid)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text("Something went wrong!"),
                    );
                  } else if (!snapshot.hasData || !snapshot.data!.exists) {
                    return Center(
                      child: Text("No user data found."),
                    );
                  } else {
                    final data = snapshot.data!.data();
                    if (data == null || data.isEmpty) {
                      return Center(
                        child: Text("User data is empty."),
                      );
                    }
                    final user = UserModel.fromMap(data);
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
                                image: NetworkImage(user.imageUrl ??
                                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSwdIVSqaMsmZyDbr9mDPk06Nss404fosHjLg&s'),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        Gap(40),
                        Text(
                          user.userName ?? '',
                          style: theme.textTheme.titleLarge!.copyWith(
                            color: theme.colorScheme.onSurface,
                          ),
                        ),
                        Text(
                          user.email ?? "",
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
