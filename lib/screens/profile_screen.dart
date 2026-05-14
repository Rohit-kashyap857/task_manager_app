import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:task_manager_app/screens/home_screen.dart';

import '../services/auth_service.dart';
import '../utils/app_theme.dart';

import 'login_screen.dart';

class ProfileScreen extends StatefulWidget {

  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() =>
      _ProfileScreenState();
}

class _ProfileScreenState
    extends State<ProfileScreen>
    with SingleTickerProviderStateMixin {

  final AuthService authService =
  AuthService();

  late AnimationController controller;

  late Animation<double> fadeAnimation;

  late Animation<Offset> slideAnimation;

  User? user =
      FirebaseAuth.instance.currentUser;

  @override
  void initState() {

    super.initState();

    controller = AnimationController(

      vsync: this,

      duration: Duration(milliseconds: 800),
    );

    fadeAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(controller);

    slideAnimation = Tween<Offset>(
      begin: Offset(0, .08),
      end: Offset.zero,
    ).animate(

      CurvedAnimation(
        parent: controller,
        curve: Curves.easeOut,
      ),
    );

    controller.forward();
  }

  @override
  void dispose() {

    controller.dispose();

    super.dispose();
  }

  logout() async {

    await authService.logout();

    Navigator.pushAndRemoveUntil(

      context,

      MaterialPageRoute(
        builder: (_) => LoginScreen(),
      ),

          (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor:
      AppTheme.background,

      body: FadeTransition(

        opacity: fadeAnimation,

        child: SlideTransition(

          position: slideAnimation,

          child: SafeArea(

            child: SingleChildScrollView(

              child: Padding(

                padding:
                EdgeInsets.all(20),

                child: Column(

                  children: [

                    // TOP BAR
                    Row(

                      children: [

                        GestureDetector(

                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (_)=>HomeScreen()));
                          },

                          child: Container(

                            padding:
                            EdgeInsets.all(12),

                            decoration:
                            BoxDecoration(

                              color:
                              Colors.white,

                              borderRadius:
                              BorderRadius.circular(
                                14,
                              ),

                              boxShadow: [

                                BoxShadow(

                                  color:
                                  Colors.black12,

                                  blurRadius: 8,

                                  offset:
                                  Offset(0, 4),
                                ),
                              ],
                            ),

                            child: Icon(
                              Icons.arrow_back_ios_new,
                              size: 20,
                            ),
                          ),
                        ),

                        Spacer(),

                        Text(

                          "Profile",

                          style: TextStyle(

                            fontSize: 24,

                            fontWeight:
                            FontWeight.bold,
                          ),
                        ),

                        Spacer(),
                      ],
                    ),

                    SizedBox(height: 40),

                    // PROFILE CARD
                    Container(

                      width: double.infinity,

                      padding:
                      EdgeInsets.all(28),

                      decoration:
                      BoxDecoration(

                        gradient:
                        LinearGradient(

                          colors: [

                            AppTheme.primary,

                            AppTheme.primaryDark,
                          ],
                        ),

                        borderRadius:
                        BorderRadius.circular(
                          30,
                        ),

                        boxShadow: [

                          BoxShadow(

                            color:
                            AppTheme.primary
                                .withOpacity(
                              0.3,
                            ),

                            blurRadius: 18,

                            offset:
                            Offset(0, 8),
                          ),
                        ],
                      ),

                      child: Column(

                        children: [

                          Hero(

                            tag: "profile",

                            child: CircleAvatar(

                              radius: 52,

                              backgroundColor:
                              Colors.white,

                              child: Text(

                                user?.email
                                    ?.substring(0, 1)
                                    .toUpperCase() ??
                                    "U",

                                style: TextStyle(

                                  fontSize: 38,

                                  fontWeight:
                                  FontWeight.bold,

                                  color:
                                  AppTheme.primary,
                                ),
                              ),
                            ),
                          ),

                          SizedBox(height: 20),

                          Text(

                            "Task Manager User",

                            style: TextStyle(

                              color: Colors.white,

                              fontSize: 24,

                              fontWeight:
                              FontWeight.bold,
                            ),
                          ),

                          SizedBox(height: 8),

                          Text(

                            user?.email ?? "",

                            style: TextStyle(

                              color:
                              Colors.white70,

                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 28),

                    // ACCOUNT CARD
                    buildCard(

                      icon:
                      Icons.email_outlined,

                      title: "Email",

                      subtitle:
                      user?.email ?? "",
                    ),

                    SizedBox(height: 18),

                    buildCard(

                      icon:
                      Icons.security,

                      title:
                      "Authentication",

                      subtitle:
                      "Firebase Auth",
                    ),

                    SizedBox(height: 18),

                    buildCard(

                      icon:
                      Icons.workspace_premium,

                      title:
                      "App Version",

                      subtitle:
                      "Premium v1.0",
                    ),

                    SizedBox(height: 40),

                    // LOGOUT BUTTON
                    SizedBox(

                      width: double.infinity,

                      height: 58,

                      child: ElevatedButton(

                        onPressed: logout,

                        style:
                        ElevatedButton.styleFrom(

                          backgroundColor:
                          Colors.red,

                          shape:
                          RoundedRectangleBorder(

                            borderRadius:
                            BorderRadius.circular(
                              18,
                            ),
                          ),
                        ),

                        child: Row(

                          mainAxisAlignment:
                          MainAxisAlignment.center,

                          children: [

                            Icon(
                              Icons.logout,
                              color: Colors.white,
                            ),

                            SizedBox(width: 10),

                            Text(

                              "Logout",

                              style: TextStyle(

                                fontSize: 18,

                                fontWeight:
                                FontWeight.bold,

                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // PREMIUM CARD
  Widget buildCard({

    required IconData icon,

    required String title,

    required String subtitle,

  }) {

    return Container(

      width: double.infinity,

      padding: EdgeInsets.all(18),

      decoration: BoxDecoration(

        color: Colors.white,

        borderRadius:
        BorderRadius.circular(22),

        boxShadow: [

          BoxShadow(

            color: Colors.black12,

            blurRadius: 10,

            offset: Offset(0, 5),
          ),
        ],
      ),

      child: Row(

        children: [

          Container(

            padding: EdgeInsets.all(14),

            decoration: BoxDecoration(

              color:
              AppTheme.primary
                  .withOpacity(0.1),

              borderRadius:
              BorderRadius.circular(
                16,
              ),
            ),

            child: Icon(

              icon,

              color: AppTheme.primary,
            ),
          ),

          SizedBox(width: 16),

          Expanded(

            child: Column(

              crossAxisAlignment:
              CrossAxisAlignment.start,

              children: [

                Text(

                  title,

                  style: TextStyle(

                    fontSize: 16,

                    fontWeight:
                    FontWeight.w600,
                  ),
                ),

                SizedBox(height: 4),

                Text(

                  subtitle,

                  style: TextStyle(

                    color: Colors.grey,

                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}