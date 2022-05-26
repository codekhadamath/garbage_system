import 'package:firebase_database/firebase_database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:garbage_system/models/user_model.dart';
import 'package:garbage_system/services/auth_service.dart';

class FirestoreService {
  static FirebaseDatabase get database => FirebaseDatabase.instance;
  static FirebaseFirestore get firestore => FirebaseFirestore.instance;

  static DatabaseReference get postsRef => database.ref('places');

  static DocumentReference<User>? get userRef {
    if (AuthService.currentUser == null) return null;
    return firestore
      .doc('users/${AuthService.currentUser!.uid}')
      .withConverter<User>(
          fromFirestore: ((snapshot, options) =>
              User.fromJson(snapshot.data()!)),
          toFirestore: (user, _) => user.toJson());
  }

  static CollectionReference<User> get usersRef =>
      firestore.collection('users').withConverter<User>(
          fromFirestore: ((snapshot, options) =>
              User.fromJson(snapshot.data()!)),
          toFirestore: (user, _) => user.toJson());
}
