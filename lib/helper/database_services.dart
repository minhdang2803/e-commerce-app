import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String? uid;
  DatabaseService({this.uid});

  // reference for our collections
  final CollectionReference userHistoryCollection =
      FirebaseFirestore.instance.collection("users");
  final CollectionReference groupCollection =
      FirebaseFirestore.instance.collection("groups");

  // saving the userdata
  Future savingUserData(String fullName, String email) async {
    return await userHistoryCollection.doc(uid).set({
      "fullName": fullName,
      "email": email,
      "histories": [],
      "addresses": [],
      "uid": uid,
    });
  }

  // getting user data
  Future gettingUserData(String email) async {
    QuerySnapshot snapshot =
        await userHistoryCollection.where("email", isEqualTo: email).get();
    return snapshot;
  }
}
