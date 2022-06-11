import 'package:garbage_system/models/user_model.dart';
import 'package:garbage_system/services/auth_service.dart';
import 'package:garbage_system/services/firestore_service.dart';

class UserService {
  static Future<void> addUser() async {
    if (!(await isUserExist)) {
      final user = User(
          name: AuthService.currentUser!.displayName!,
          email: AuthService.currentUser!.email!,
          phone: 'Not Given');
      FirestoreService.usersRef.doc(AuthService.currentUser!.uid).set(user);
    }
  }

  static Future get isUserExist async {
    final docs = await FirestoreService.usersRef.doc(AuthService.currentUser!.uid).get();
    return docs.exists;
  }

  static Future<User> get user async {
    final user = await FirestoreService.userRef!.get();
    return user.data()!;
  }
}
