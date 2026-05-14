import 'package:flutter/material.dart';

import '../services/firestore_services.dart';
import '../utils/app_theme.dart';

class AddTaskScreen extends StatefulWidget {

  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() =>
      _AddTaskScreenState();
}

class _AddTaskScreenState
    extends State<AddTaskScreen>
    with SingleTickerProviderStateMixin {

  TextEditingController titleController =
  TextEditingController();

  TextEditingController descriptionController =
  TextEditingController();

  TextEditingController dateController =
  TextEditingController();

  final FirestoreService firestoreService =
  FirestoreService();

  bool loading = false;

  late AnimationController animationController;

  late Animation<double> fadeAnimation;

  late Animation<Offset> slideAnimation;

  @override
  void initState() {

    super.initState();

    animationController = AnimationController(

      vsync: this,

      duration: Duration(milliseconds: 900),
    );

    fadeAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(

      CurvedAnimation(
        parent: animationController,
        curve: Curves.easeIn,
      ),
    );

    slideAnimation = Tween<Offset>(
      begin: Offset(0, 0.2),
      end: Offset.zero,
    ).animate(

      CurvedAnimation(
        parent: animationController,
        curve: Curves.easeOut,
      ),
    );

    animationController.forward();
  }

  @override
  void dispose() {

    animationController.dispose();

    titleController.dispose();

    descriptionController.dispose();

    dateController.dispose();

    super.dispose();
  }
  Future<void> pickDate() async {

    DateTime? pickedDate =
    await showDatePicker(

      context: context,

      initialDate: DateTime.now(),

      firstDate: DateTime(2020),

      lastDate: DateTime(2100),
    );

    if(pickedDate != null){

      String formattedDate =

          "${pickedDate.day}/"
          "${pickedDate.month}/"
          "${pickedDate.year}";

      setState(() {

        dateController.text =
            formattedDate;
      });
    }
  }
  addTask() async {

    if(titleController.text.isEmpty ||
        descriptionController.text.isEmpty ||
        dateController.text.isEmpty){

      ScaffoldMessenger.of(context).showSnackBar(

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

      await firestoreService.addTask(

        title:
        titleController.text.trim(),

        description:
        descriptionController.text.trim(),

        date:
        dateController.text.trim(),
      );

      setState(() {
        loading = false;
      });

      Navigator.pop(context);

    } catch (e) {

      setState(() {
        loading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(

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

      body: SafeArea(

        child: FadeTransition(

          opacity: fadeAnimation,

          child: SlideTransition(

            position: slideAnimation,

            child: SingleChildScrollView(

              child: Padding(

                padding: EdgeInsets.all(22),

                child: Column(

                  crossAxisAlignment:
                  CrossAxisAlignment.start,

                  children: [

                    // TOP BAR
                    Row(

                      children: [

                        GestureDetector(

                          onTap: () {
                            Navigator.pop(context);
                          },

                          child: Container(

                            padding:
                            EdgeInsets.all(12),

                            decoration: BoxDecoration(

                              color: Colors.white,

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

                        SizedBox(width: 16),

                        Column(

                          crossAxisAlignment:
                          CrossAxisAlignment.start,

                          children: [

                            Text(

                              "Create",

                              style: TextStyle(

                                fontSize: 16,

                                color:
                                AppTheme.textSecondary,
                              ),
                            ),

                            SizedBox(height: 4),

                            Text(

                              "New Task",

                              style: TextStyle(

                                fontSize: 28,

                                fontWeight:
                                FontWeight.bold,

                                color:
                                AppTheme.textPrimary,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

                    SizedBox(height: 40),

                    // PREMIUM CARD
                    Container(

                      padding:
                      EdgeInsets.all(22),

                      decoration: BoxDecoration(

                        color: Colors.white,

                        borderRadius:
                        BorderRadius.circular(28),

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

                          // TITLE
                          TextField(

                            controller:
                            titleController,

                            decoration:
                            InputDecoration(

                              labelText:
                              "Task Title",

                              hintText:
                              "Enter task title",

                              prefixIcon:
                              Icon(Icons.title),

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
                          TextField(

                            controller:
                            descriptionController,

                            maxLines: 4,

                            decoration:
                            InputDecoration(

                              labelText:
                              "Description",

                              hintText:
                              "Enter task details",

                              prefixIcon:
                              Padding(

                                padding:
                                EdgeInsets.only(
                                  bottom: 70,
                                ),

                                child: Icon(
                                  Icons.description,
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

                          SizedBox(height: 22),
                          TextField(

                            controller:
                            dateController,

                            readOnly: true,

                            onTap: pickDate,

                            decoration:
                            InputDecoration(

                              labelText:
                              "Select Date",

                              hintText:
                              "Choose task date",

                              prefixIcon:
                              Icon(
                                Icons.calendar_month,
                              ),

                              suffixIcon:
                              Icon(
                                Icons.arrow_drop_down,
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

                          // BUTTON
                          loading

                              ? CircularProgressIndicator()

                              : SizedBox(

                            width:
                            double.infinity,

                            height: 58,

                            child:
                            ElevatedButton(

                              onPressed:
                              addTask,

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
                                    Icons.add_task,
                                    color:
                                    Colors.white,
                                  ),

                                  SizedBox(width: 10),

                                  Text(

                                    "Save Task",

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
                        ],
                      ),
                    ),

                    SizedBox(height: 30),

                    // BOTTOM INFO CARD
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
                        BorderRadius.circular(22),
                      ),

                      child: Row(

                        children: [

                          Icon(

                            Icons.lightbulb,

                            color: Colors.white,

                            size: 30,
                          ),

                          SizedBox(width: 14),

                          Expanded(

                            child: Text(

                              "Stay productive by organizing your tasks efficiently.",

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