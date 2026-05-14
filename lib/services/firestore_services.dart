import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreService {

  final String uid =
      FirebaseAuth.instance.currentUser!.uid;

  CollectionReference get taskCollection =>

      FirebaseFirestore.instance

          .collection('users')

          .doc(uid)

          .collection('tasks');

  // ADD TASK
  Future<void> addTask({

    required String title,

    required String description,

    required String date,

  }) async {

    await taskCollection.add({

      'title': title,

      'description': description,

      'date': date,

      'completed': false,
    });
  }

  Stream<QuerySnapshot> getTasks() {

    return taskCollection.snapshots();
  }

  Future<void> deleteTask(String id) async {

    await taskCollection.doc(id).delete();
  }
  Future<void> updateTask({

    required String id,

    required String title,

    required String description,

    required String date,

    required bool completed,

  }) async {

    await taskCollection.doc(id).update({

      'title': title,

      'description': description,

      'date': date,

      'completed': completed,
    });
  }
}