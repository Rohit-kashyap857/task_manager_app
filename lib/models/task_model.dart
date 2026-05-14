class TaskModel {

  String id;
  String title;
  String description;
  String date;
  bool completed;

  TaskModel({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
    required this.completed,
  });

  // Convert Firestore -> Object
  factory TaskModel.fromMap(Map<String, dynamic> map, String docId) {

    return TaskModel(
      id: docId,
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      date: map['date'] ?? '',
      completed: map['completed'] ?? false,
    );
  }

  // Convert Object -> Firestore
  Map<String, dynamic> toMap() {

    return {
      'title': title,
      'description': description,
      'date': date,
      'completed': completed,
    };
  }
}