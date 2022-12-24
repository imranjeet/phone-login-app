import 'package:cloud_firestore/cloud_firestore.dart';

class UsersApi {
  /// Get firestore instance
  ///
  final _firestore = FirebaseFirestore.instance;
  Future<void> uploadingData(
      String name, String uid, String phone, String email, String city, String userImage) async {
    await _firestore.collection("users").doc(uid).set({
      'name': name,
      'uid': uid,
      'phone': phone,
      'email': email,
      'city': city,
      'userImage': userImage,
    });
  }

  // Future<void> getData(
  //     String name, String uid, String phone, String email, String city, String userImage) async {
  //   await _firestore.collection("users").doc(uid).get();
  // }
}
