import 'package:flutter/material.dart';

import '../services/firestore_services.dart';
import '../utils/app_theme.dart';

class EditTaskScreen extends StatefulWidget {

  final String id;
  final String title;
  final String description;
  final String date;
  final bool completed;

  const EditTaskScreen({

    super.key,

    required this.id,

    required this.title,

    required this.description,

    required this.date,

    required this.completed,
  });

  @override
  State<EditTaskScreen> createState() =>
      _EditTaskScreenState();
}

class _EditTaskScreenState
    extends State<EditTaskScreen>
    with SingleTickerProviderStateMixin {

  late TextEditingController titleController;

  late TextEditingController descriptionController;

  late TextEditingController dateController;

  bool completed = false;

  final FirestoreService firestoreService =
  FirestoreService();

  bool loading = false;

  late AnimationController animationController;

  late Animation<double> fadeAnimation;

  late Animation<Offset> slideAnimation;

  @override
  void initState() {

    super.initState();

    titleController =
        TextEditingController(text: widget.title);

    descriptionController =
        TextEditingController(text: widget.description);

    dateController =
        TextEditingController(text: widget.date);

    completed = widget.completed;

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

  // DATE PICKER
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

  // UPDATE TASK
  updateTask() async {

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

      await firestoreService.updateTask(

        id: widget.id,

        title:
        titleController.text.trim(),

        description:
        descriptionController.text.trim(),

        date:
        dateController.text.trim(),

        completed: completed,
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

                              "Update",

                              style: TextStyle(

                                fontSize: 16,

                                color:
                                AppTheme.textSecondary,
                              ),
                            ),

                            SizedBox(height: 4),

                            Text(

                              "Edit Task",

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

                          // DESCRIPTION
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

                          // DATE PICKER
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

                          SizedBox(height: 22),

                          // TASK STATUS
                          Container(

                            padding:
                            EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 6,
                            ),

                            decoration: BoxDecoration(

                              color:
                              completed
                                  ? AppTheme.completedBg
                                  : AppTheme.pendingBg,

                              borderRadius:
                              BorderRadius.circular(
                                16,
                              ),
                            ),

                            child: CheckboxListTile(

                              value: completed,

                              activeColor:
                              AppTheme.primary,

                              contentPadding:
                              EdgeInsets.zero,

                              title: Text(

                                completed
                                    ? "Task Completed"
                                    : "Task Pending",

                                style: TextStyle(

                                  fontWeight:
                                  FontWeight.w600,
                                ),
                              ),

                              onChanged: (value) {

                                setState(() {

                                  completed =
                                  value!;
                                });
                              },
                            ),
                          ),

                          SizedBox(height: 35),

                          // UPDATE BUTTON
                          loading

                              ? CircularProgressIndicator()

                              : SizedBox(

                            width:
                            double.infinity,

                            height: 58,

                            child:
                            ElevatedButton(

                              onPressed:
                              updateTask,

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
                                    Icons.save,
                                    color:
                                    Colors.white,
                                  ),

                                  SizedBox(width: 10),

                                  Text(

                                    "Update Task",

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

                            Icons.auto_awesome,

                            color: Colors.white,

                            size: 30,
                          ),

                          SizedBox(width: 14),

                          Expanded(

                            child: Text(

                              "Update your tasks and stay organized with productivity.",

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