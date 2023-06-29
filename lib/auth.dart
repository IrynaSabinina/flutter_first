import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/model/user-model.dart';
import 'package:flutter/services.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/services.dart';


class Auth{

final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;


User? get currentUser => _firebaseAuth.currentUser;
Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();
final _db = FirebaseFirestore.instance;
Future<void> singInWithEmailAndPassword({
  required String email,
  required String password,
}) async {
  await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
}

Future<void> createUserWithEmailAndPassword({
  required String email,
  required String password,
}) async {
  await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
}

Future<void> singOut() async {
  await _firebaseAuth.signOut();
}



}