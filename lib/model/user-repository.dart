import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';

Future<void> userSetap(String displayName) async {
  CollectionReference users = FirebaseFirestore.instance.collection("users");
  FirebaseAuth auth= FirebaseAuth.instance;
  String? uid = auth.currentUser?.uid.toString();
  users.add({'displayName': displayName, "uid":uid});
  return;
}