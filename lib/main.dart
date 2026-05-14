import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'screens/home_screen.dart';
import 'screens/splash_screen.dart';

import 'utils/app_theme.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  runApp(TaskManagerApp());
}

class TaskManagerApp extends StatelessWidget {

  const TaskManagerApp({super.key});

  @override
  Widget build(BuildContext context) {

    return MaterialApp(

      debugShowCheckedModeBanner: false,

      title: "Task Manager",

      theme: AppTheme.theme,

      home:
      FirebaseAuth.instance.currentUser != null

          ? HomeScreen()

          : SplashScreen(),
    );
  }
}