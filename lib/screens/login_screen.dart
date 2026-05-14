import 'package:flutter/material.dart';

import '../services/auth_service.dart';
import '../utils/app_theme.dart';

import 'home_screen.dart';
import 'signup_screen.dart';

class LoginScreen extends StatefulWidget {

  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() =>
      _LoginScreenState();
}

class _LoginScreenState
    extends State<LoginScreen>
    with SingleTickerProviderStateMixin {

  TextEditingController emailController =
  TextEditingController();

  TextEditingController passwordController =
  TextEditingController();

  final AuthService authService =
  AuthService();

  bool loading = false;

  bool obscurePassword = true;

  late AnimationController controller;

  late Animation<double> fadeAnimation;

  late Animation<Offset> slideAnimation;

  @override
  void initState() {

    super.initState();

    controller = AnimationController(

      vsync: this,

      duration: Duration(milliseconds: 900),
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

    emailController.dispose();

    passwordController.dispose();

    super.dispose();
  }

  // LOGIN
  loginUser() async {

    if(emailController.text.isEmpty ||
        passwordController.text.isEmpty){

      ScaffoldMessenger.of(context)
          .showSnackBar(

        SnackBar(
          content: Text(
            "Please fill all fields",
          ),
        ),
      );

      return;
    }

    try {

      setState(() {
        loading = true;
      });

      var user =
      await authService.login(

        emailController.text.trim(),

        passwordController.text.trim(),
      );

      setState(() {
        loading = false;
      });

      if(user != null){

        Navigator.pushReplacement(

          context,

          MaterialPageRoute(
            builder: (_) =>
                HomeScreen(),
          ),
        );

      } else {

        ScaffoldMessenger.of(context)
            .showSnackBar(

          SnackBar(
            content: Text(
              "Login Failed",
            ),
          ),
        );
      }

    } catch (e) {

      setState(() {
        loading = false;
      });

      ScaffoldMessenger.of(context)
          .showSnackBar(

        SnackBar(
          content: Text(
            e.toString(),
          ),
        ),
      );
    }
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
                EdgeInsets.all(24),

                child: Column(

                  crossAxisAlignment:
                  CrossAxisAlignment.start,

                  children: [

                    SizedBox(height: 40),

                    // LOGO
                    Center(

                      child: Container(

                        padding:
                        EdgeInsets.all(24),

                        decoration: BoxDecoration(

                          gradient:
                          LinearGradient(

                            colors: [

                              AppTheme.primary,

                              AppTheme.primaryDark,
                            ],
                          ),

                          shape: BoxShape.circle,

                          boxShadow: [

                            BoxShadow(

                              color:
                              AppTheme.primary
                                  .withOpacity(
                                0.3,
                              ),

                              blurRadius: 20,

                              offset:
                              Offset(0, 8),
                            ),
                          ],
                        ),

                        child: Icon(

                          Icons.task_alt,

                          color: Colors.white,

                          size: 70,
                        ),
                      ),
                    ),

                    SizedBox(height: 40),

                    Text(

                      "Welcome Back 👋",

                      style: TextStyle(

                        fontSize: 30,

                        fontWeight:
                        FontWeight.bold,

                        color:
                        AppTheme.textPrimary,
                      ),
                    ),

                    SizedBox(height: 10),

                    Text(

                      "Login to continue managing your daily tasks.",

                      style: TextStyle(

                        fontSize: 15,

                        color:
                        AppTheme.textSecondary,

                        height: 1.5,
                      ),
                    ),

                    SizedBox(height: 40),

                    // LOGIN CARD
                    Container(

                      padding:
                      EdgeInsets.all(22),

                      decoration: BoxDecoration(

                        color: Colors.white,

                        borderRadius:
                        BorderRadius.circular(
                          28,
                        ),

                        boxShadow: [

                          BoxShadow(

                            color:
                            Colors.black12,

                            blurRadius: 15,

                            offset:
                            Offset(0, 8),
                          ),
                        ],
                      ),

                      child: Column(

                        children: [

                          // EMAIL
                          TextField(

                            controller:
                            emailController,

                            keyboardType:
                            TextInputType
                                .emailAddress,

                            decoration:
                            InputDecoration(

                              labelText:
                              "Email",

                              hintText:
                              "Enter your email",

                              prefixIcon:
                              Icon(Icons.email),

                              border:
                              OutlineInputBorder(

                                borderRadius:
                                BorderRadius.circular(
                                  16,
                                ),
                              ),
                            ),
                          ),

                          SizedBox(height: 22),

                          // PASSWORD
                          TextField(

                            controller:
                            passwordController,

                            obscureText:
                            obscurePassword,

                            decoration:
                            InputDecoration(

                              labelText:
                              "Password",

                              hintText:
                              "Enter password",

                              prefixIcon:
                              Icon(Icons.lock),

                              suffixIcon:
                              IconButton(

                                onPressed: () {

                                  setState(() {

                                    obscurePassword =
                                    !obscurePassword;
                                  });
                                },

                                icon: Icon(

                                  obscurePassword
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                ),
                              ),

                              border:
                              OutlineInputBorder(

                                borderRadius:
                                BorderRadius.circular(
                                  16,
                                ),
                              ),
                            ),
                          ),

                          SizedBox(height: 35),

                          // LOGIN BUTTON
                          loading

                              ? CircularProgressIndicator()

                              : SizedBox(

                            width:
                            double.infinity,

                            height: 58,

                            child:
                            ElevatedButton(

                              onPressed:
                              loginUser,

                              style:
                              ElevatedButton.styleFrom(

                                elevation: 0,

                                backgroundColor:
                                AppTheme.primary,

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
                                    Icons.login,
                                    color:
                                    Colors.white,
                                  ),

                                  SizedBox(width: 10),

                                  Text(

                                    "Login",

                                    style: TextStyle(

                                      fontSize: 18,

                                      fontWeight:
                                      FontWeight.bold,

                                      color:
                                      Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          SizedBox(height: 20),

                          Row(

                            mainAxisAlignment:
                            MainAxisAlignment.center,

                            children: [

                              Text(

                                "Don't have an account?",

                                style: TextStyle(

                                  color:
                                  AppTheme
                                      .textSecondary,
                                ),
                              ),

                              TextButton(

                                onPressed: () {

                                  Navigator.push(

                                    context,

                                    MaterialPageRoute(
                                      builder: (_) =>
                                          SignupScreen(),
                                    ),
                                  );
                                },

                                child: Text(

                                  "Sign Up",

                                  style: TextStyle(

                                    color:
                                    AppTheme.primary,

                                    fontWeight:
                                    FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 30),

                    // BOTTOM CARD
                    Container(

                      width: double.infinity,

                      padding:
                      EdgeInsets.all(18),

                      decoration: BoxDecoration(

                        gradient:
                        LinearGradient(

                          colors: [

                            AppTheme.primary,

                            AppTheme.primaryDark,
                          ],
                        ),

                        borderRadius:
                        BorderRadius.circular(
                          22,
                        ),
                      ),

                      child: Row(

                        children: [

                          Icon(

                            Icons.lightbulb,

                            color: Colors.white,

                            size: 28,
                          ),

                          SizedBox(width: 14),

                          Expanded(

                            child: Text(

                              "Stay organized and boost productivity with smart task management.",

                              style: TextStyle(

                                color: Colors.white,

                                fontSize: 15,

                                height: 1.4,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}