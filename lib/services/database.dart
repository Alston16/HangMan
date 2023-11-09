import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:math';
import '../models/userData.dart';

class DatabaseService {
  final String uid;

  DatabaseService(this.uid);

  // Collection references
  final CollectionReference userCollection =
  FirebaseFirestore.instance.collection('users');

  final CollectionReference movieCollection =
  FirebaseFirestore.instance.collection('movies');

  // Create user data in the 'users' collection
  Future<void> createUserData(String name) async {
    return await userCollection.doc(uid).set({
      'name': name,
      'score': 0,
    });
  }

  // Update user score in the 'users' collection
  Future<void> updateUserScore(int score) async {
    return await userCollection
        .doc(uid)
        .update({'score': FieldValue.increment(score)});
  }

  // Get a random movie name from the 'movies' collection
  Future<String> getMovieName() async {
    Random random = Random();
    int index = random.nextInt(15);
    QuerySnapshot querySnapshot =
    await movieCollection.where('index', isEqualTo: index).get();

    return querySnapshot.docs[0].get('name');
  }

  // Convert leaderboard entries from QuerySnapshot to a list of UserData
  List<UserData> _leaderboardEntriesFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return UserData(uid, doc.get('name'), doc.get('score'));
    }).toList();
  }

  // Convert user data from DocumentSnapshot to UserData
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(uid, snapshot.get('name'), snapshot.get('score'));
  }

  // Stream for the leaderboard entries
  Stream<List<UserData>> get leaderboardEntries {
    return userCollection
        .orderBy('score', descending: true)
        .limit(10)
        .snapshots()
        .map(_leaderboardEntriesFromSnapshot);
  }

  // Stream for the user-specific data
  Stream<UserData> get userData {
    return userCollection.doc(uid).snapshots().map(_userDataFromSnapshot);
  }
}