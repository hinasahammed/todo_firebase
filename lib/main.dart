import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_firebase/view/home_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:todo_firebase/viewmodel/home_viewmodel.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HomeViewmodel(),
      child: MaterialApp(
        title: 'Todo firebase',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.greenAccent,
            brightness: Brightness.dark,
          ),
          useMaterial3: true,
        ),
        home: const HomeView(),
      ),
    );
  }
}
