import 'dart:async';

import 'package:flutter/material.dart';

import '../utils/app_theme.dart';

import 'login_screen.dart';

class SplashScreen extends StatefulWidget {

  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() =>
      _SplashScreenState();
}

class _SplashScreenState
    extends State<SplashScreen>
    with TickerProviderStateMixin {

  late AnimationController scaleController;

  late AnimationController fadeController;

  late Animation<double> scaleAnimation;

  late Animation<double> fadeAnimation;

  @override
  void initState() {

    super.initState();

    // SCALE ANIMATION
    scaleController = AnimationController(

      vsync: this,

      duration: Duration(milliseconds: 1200),
    );

    scaleAnimation = Tween<double>(
      begin: 0.6,
      end: 1,
    ).animate(

      CurvedAnimation(
        parent: scaleController,
        curve: Curves.easeOutBack,
      ),
    );

    // FADE ANIMATION
    fadeController = AnimationController(

      vsync: this,

      duration: Duration(milliseconds: 1500),
    );

    fadeAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(

      CurvedAnimation(
        parent: fadeController,
        curve: Curves.easeIn,
      ),
    );

    scaleController.forward();

    fadeController.forward();

    // NAVIGATION
    Timer(

      Duration(seconds: 3),

          () {

        Navigator.pushReplacement(

          context,

          MaterialPageRoute(
            builder: (_) =>
                LoginScreen(),
          ),
        );
      },
    );
  }

  @override
  void dispose() {

    scaleController.dispose();

    fadeController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: Container(

        width: double.infinity,

        decoration: BoxDecoration(

          gradient: LinearGradient(

            begin: Alignment.topLeft,

            end: Alignment.bottomRight,

            colors: [

              AppTheme.primary,

              AppTheme.primaryDark,

              Colors.indigo.shade900,
            ],
          ),
        ),

        child: SafeArea(

          child: Column(

            mainAxisAlignment:
            MainAxisAlignment.center,

            children: [

              Spacer(),

              // ANIMATED LOGO
              ScaleTransition(

                scale: scaleAnimation,

                child: Container(

                  padding: EdgeInsets.all(28),

                  decoration: BoxDecoration(

                    color:
                    Colors.white.withOpacity(0.15),

                    shape: BoxShape.circle,

                    border: Border.all(

                      color:
                      Colors.white.withOpacity(0.3),

                      width: 2,
                    ),
                  ),

                  child: Icon(

                    Icons.task_alt_rounded,

                    color: Colors.white,

                    size: 90,
                  ),
                ),
              ),

              SizedBox(height: 35),

              // APP NAME
              FadeTransition(

                opacity: fadeAnimation,

                child: Text(

                  "Task Manager",

                  style: TextStyle(

                    color: Colors.white,

                    fontSize: 34,

                    fontWeight: FontWeight.bold,

                    letterSpacing: 1,
                  ),
                ),
              ),

              SizedBox(height: 14),

              FadeTransition(

                opacity: fadeAnimation,

                child: Text(

                  "Organize your work efficiently",

                  style: TextStyle(

                    color: Colors.white70,

                    fontSize: 16,

                    letterSpacing: 0.5,
                  ),
                ),
              ),

              Spacer(),

              // LOADER
              Column(

                children: [

                  SizedBox(

                    width: 28,

                    height: 28,

                    child:
                    CircularProgressIndicator(

                      strokeWidth: 3,

                      valueColor:
                      AlwaysStoppedAnimation(
                        Colors.white,
                      ),
                    ),
                  ),

                  SizedBox(height: 20),

                  Text(

                    "Loading...",

                    style: TextStyle(

                      color: Colors.white70,

                      fontSize: 15,
                    ),
                  ),
                ],
              ),

              SizedBox(height: 45),
            ],
          ),
        ),
      ),
    );
  }
}