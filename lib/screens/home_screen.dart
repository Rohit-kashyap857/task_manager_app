import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:task_manager_app/screens/profile_screen.dart';
import 'package:task_manager_app/screens/profile_screen.dart';

import '../services/api_service.dart';
import '../services/auth_service.dart';
import '../services/firestore_services.dart';

import '../utils/app_theme.dart';

import 'add_task_screen.dart';
import 'edit_task_screen.dart';
import 'login_screen.dart';

class HomeScreen extends StatefulWidget {

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() =>
      _HomeScreenState();
}

class _HomeScreenState
    extends State<HomeScreen>
    with SingleTickerProviderStateMixin {

  final apiService = ApiService();


  final firestoreService =
  FirestoreService();

  final authService =
  AuthService();
  final user =
      FirebaseAuth.instance.currentUser;

  late AnimationController controller;

  late Animation<double> fade;

  late Animation<Offset> slide;

  @override
  void initState() {

    super.initState();

    controller = AnimationController(

      vsync: this,

      duration:
      Duration(milliseconds: 800),
    );

    fade = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(controller);

    slide = Tween<Offset>(
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

    Navigator.pushReplacement(

      context,

      MaterialPageRoute(
        builder: (_) => LoginScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor:
      AppTheme.background,

      floatingActionButton:
      FloatingActionButton(

        backgroundColor:
        AppTheme.primary,

        elevation: 6,

        child: Icon(
          Icons.add,
          color: Colors.white,
        ),

        onPressed: () {

          Navigator.push(

            context,

            MaterialPageRoute(
              builder: (_) =>
                  AddTaskScreen(),
            ),
          );
        },
      ),

      body: FadeTransition(

        opacity: fade,

        child: SlideTransition(

          position: slide,

          child: SafeArea(

            child: Padding(

              padding:
              EdgeInsets.all(16),

              child: Column(

                children: [
                  AnimatedContainer(

                    duration:
                    Duration(milliseconds: 500),

                    padding:
                    EdgeInsets.symmetric(

                      horizontal: 18,

                      vertical: 16,
                    ),

                    decoration:
                    BoxDecoration(

                      color: Colors.white,

                      borderRadius:
                      BorderRadius.circular(
                        24,
                      ),

                      boxShadow: [

                        BoxShadow(

                          color:
                          Colors.black12,

                          blurRadius: 12,

                          offset:
                          Offset(0, 4),
                        ),
                      ],
                    ),

                    child: Row(

                      children: [

                        // LOGO
                        AnimatedContainer(

                          duration:
                          Duration(
                            milliseconds:
                            600,
                          ),

                          padding:
                          EdgeInsets.all(
                            14,
                          ),

                          decoration:
                          BoxDecoration(

                            gradient:
                            LinearGradient(

                              colors: [

                                AppTheme
                                    .primary,

                                AppTheme
                                    .primaryDark,
                              ],
                            ),

                            borderRadius:
                            BorderRadius.circular(
                              18,
                            ),
                          ),

                          child: Icon(

                            Icons
                                .task_alt_rounded,

                            color:
                            Colors.white,

                            size: 30,
                          ),
                        ),

                        SizedBox(width: 16),

                        // TITLE
                        Expanded(

                          child: Column(

                            crossAxisAlignment:
                            CrossAxisAlignment
                                .start,

                            children: [

                              Text(

                                "Task Manager",

                                style:
                                TextStyle(

                                  fontSize:
                                  22,

                                  fontWeight:
                                  FontWeight
                                      .bold,

                                  color:
                                  AppTheme
                                      .textPrimary,
                                ),
                              ),

                              SizedBox(
                                height: 4,
                              ),

                              Text(

                                "Manage your daily productivity",

                                style:
                                TextStyle(

                                  fontSize:
                                  13,

                                  color:
                                  AppTheme
                                      .textSecondary,
                                ),
                              ),
                            ],
                          ),
                        ),

                        // PROFILE AVATAR
                        GestureDetector(

                          onTap: () {

                            Navigator.push(

                              context,

                              MaterialPageRoute(
                                builder: (_) =>
                                    ProfileScreen(),
                              ),
                            );
                          },

                          child: Hero(

                            tag: "profile",

                            child: Container(

                              padding: EdgeInsets.all(2),

                              decoration: BoxDecoration(

                                shape: BoxShape.circle,

                                gradient: LinearGradient(

                                  colors: [

                                    AppTheme.primary,

                                    AppTheme.primaryDark,
                                  ],
                                ),
                              ),

                              child: CircleAvatar(

                                radius: 24,

                                backgroundColor:
                                Colors.white,

                                child: Text(
                                  user?.email
                                      ?.substring(0, 1)
                                      .toUpperCase() ?? "U",

                                  style: TextStyle(

                                    color:
                                    AppTheme.primary,

                                    fontWeight:
                                    FontWeight.bold,

                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 24),

                  // QUOTE CARD
                  FutureBuilder(

                    future:
                    apiService.getQuote(),

                    builder:
                        (context, snapshot) {

                      if(snapshot
                          .connectionState ==
                          ConnectionState
                              .waiting){

                        return Center(
                          child:
                          CircularProgressIndicator(),
                        );
                      }

                      if(snapshot.hasData){

                        var data =
                        snapshot.data
                        as Map<String,
                            dynamic>;

                        return Container(

                          width:
                          double.infinity,

                          padding:
                          EdgeInsets.all(20),

                          decoration:
                          BoxDecoration(

                            gradient:
                            LinearGradient(

                              colors: [

                                AppTheme
                                    .primary,

                                AppTheme
                                    .primaryDark,
                              ],
                            ),

                            borderRadius:
                            BorderRadius.circular(
                              22,
                            ),
                          ),

                          child: Column(

                            crossAxisAlignment:
                            CrossAxisAlignment
                                .start,

                            children: [

                              Icon(

                                Icons
                                    .format_quote,

                                color:
                                Colors.white,
                              ),

                              SizedBox(
                                height: 10,
                              ),

                              Text(

                                data['content'],

                                style:
                                TextStyle(

                                  color:
                                  Colors.white,

                                  fontSize:
                                  15,

                                  height:
                                  1.5,
                                ),
                              ),

                              SizedBox(
                                height: 12,
                              ),

                              Align(

                                alignment:
                                Alignment
                                    .centerRight,

                                child: Text(

                                  "- ${data['author']}",

                                  style:
                                  TextStyle(
                                    color:
                                    Colors
                                        .white70,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }

                      return SizedBox();
                    },
                  ),

                  SizedBox(height: 24),

                  // TASKS
                  Expanded(

                    child:
                    StreamBuilder<
                        QuerySnapshot>(

                      stream:
                      firestoreService
                          .getTasks(),

                      builder:
                          (context, snapshot) {

                        if(snapshot
                            .connectionState ==
                            ConnectionState
                                .waiting){

                          return Center(
                            child:
                            CircularProgressIndicator(),
                          );
                        }

                        if(!snapshot
                            .hasData ||
                            snapshot.data!
                                .docs.isEmpty){

                          return Center(

                            child: Column(

                              mainAxisAlignment:
                              MainAxisAlignment
                                  .center,

                              children: [

                                Icon(

                                  Icons
                                      .task_alt,

                                  size: 80,

                                  color: Colors
                                      .grey
                                      .shade400,
                                ),

                                SizedBox(
                                  height: 10,
                                ),

                                Text(
                                  "No Tasks Found",
                                ),
                              ],
                            ),
                          );
                        }

                        var tasks =
                            snapshot
                                .data!.docs;

                        return ListView
                            .builder(

                          physics:
                          BouncingScrollPhysics(),

                          itemCount:
                          tasks.length,

                          itemBuilder:
                              (_, index) {

                            var task =
                            tasks[index];

                            bool completed =
                            task[
                            'completed'];

                            return AnimatedContainer(

                              duration:
                              Duration(
                                milliseconds:
                                400,
                              ),

                              margin:
                              EdgeInsets.only(
                                bottom: 16,
                              ),

                              padding:
                              EdgeInsets.all(
                                18,
                              ),

                              decoration:
                              BoxDecoration(

                                color:
                                Colors.white,

                                borderRadius:
                                BorderRadius.circular(
                                  22,
                                ),

                                boxShadow: [

                                  BoxShadow(

                                    color:
                                    Colors
                                        .black12,

                                    blurRadius:
                                    10,

                                    offset:
                                    Offset(
                                      0,
                                      5,
                                    ),
                                  ),
                                ],
                              ),

                              child: Row(

                                crossAxisAlignment:
                                CrossAxisAlignment
                                    .start,

                                children: [

                                  CircleAvatar(

                                    radius:
                                    28,

                                    backgroundColor:
                                    completed
                                        ? AppTheme
                                        .completedBg
                                        : AppTheme
                                        .pendingBg,

                                    child: Icon(

                                      completed
                                          ? Icons
                                          .check
                                          : Icons
                                          .pending,

                                      color:
                                      completed
                                          ? Colors
                                          .green
                                          : Colors
                                          .orange,
                                    ),
                                  ),

                                  SizedBox(
                                    width: 14,
                                  ),

                                  Expanded(

                                    child:
                                    Column(

                                      crossAxisAlignment:
                                      CrossAxisAlignment
                                          .start,

                                      children: [

                                        Text(

                                          task[
                                          'title'],

                                          maxLines:
                                          1,

                                          overflow:
                                          TextOverflow
                                              .ellipsis,

                                          style:
                                          TextStyle(

                                            fontSize:
                                            17,

                                            fontWeight:
                                            FontWeight
                                                .w600,

                                            decoration:
                                            completed
                                                ? TextDecoration
                                                .lineThrough
                                                : null,
                                          ),
                                        ),

                                        SizedBox(
                                          height:
                                          8,
                                        ),

                                        Text(

                                          task[
                                          'description'],

                                          style:
                                          TextStyle(

                                            height:
                                            1.4,

                                            color:
                                            Colors
                                                .grey
                                                .shade700,
                                          ),
                                        ),

                                        SizedBox(
                                          height:
                                          10,
                                        ),

                                        Row(

                                          children: [

                                            Icon(

                                              Icons
                                                  .calendar_month,

                                              size:
                                              17,

                                              color:
                                              Colors
                                                  .grey,
                                            ),

                                            SizedBox(
                                              width:
                                              5,
                                            ),

                                            Text(
                                              task[
                                              'date'],
                                            ),
                                          ],
                                        ),

                                        SizedBox(
                                          height:
                                          12,
                                        ),

                                        Container(

                                          padding:
                                          EdgeInsets.symmetric(

                                            horizontal:
                                            12,

                                            vertical:
                                            6,
                                          ),

                                          decoration:
                                          BoxDecoration(

                                            color:
                                            completed
                                                ? AppTheme
                                                .completedBg
                                                : AppTheme
                                                .pendingBg,

                                            borderRadius:
                                            BorderRadius.circular(
                                              18,
                                            ),
                                          ),

                                          child:
                                          Text(

                                            completed
                                                ? "Completed"
                                                : "Pending",

                                            style:
                                            TextStyle(

                                              color:
                                              completed
                                                  ? Colors.green
                                                  : Colors.orange,

                                              fontWeight:
                                              FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  Column(

                                    children: [

                                      IconButton(

                                        onPressed:
                                            () {

                                          Navigator.push(

                                            context,

                                            MaterialPageRoute(

                                              builder:
                                                  (_) =>
                                                  EditTaskScreen(

                                                    id:
                                                    task.id,

                                                    title:
                                                    task['title'],

                                                    description:
                                                    task['description'],

                                                    date:
                                                    task['date'],

                                                    completed:
                                                    task['completed'],
                                                  ),
                                            ),
                                          );
                                        },

                                        icon:
                                        Icon(

                                          Icons
                                              .edit,

                                          color:
                                          AppTheme
                                              .primary,
                                        ),
                                      ),

                                      IconButton(

                                        onPressed:
                                            () async {

                                          await firestoreService
                                              .deleteTask(
                                            task.id,
                                          );
                                        },

                                        icon:
                                        Icon(

                                          Icons
                                              .delete,

                                          color:
                                          Colors
                                              .red,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}