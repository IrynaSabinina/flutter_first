import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/user-repository.dart';
import 'auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'home-login_page.dart';
import 'package:firebase_storage/firebase_storage.dart';
class LoginRegisterPage extends StatefulWidget{
  const LoginRegisterPage({Key? key}) :super (key:key);

  @override
  State<LoginRegisterPage> createState() => _LoginRegisterPageState();
}
class _LoginRegisterPageState extends State<LoginRegisterPage> {
final db = FirebaseFirestore.instance;
  String? errorMessage = '';
  bool isLogin = false;

TextEditingController _controllerEmail = TextEditingController();
  TextEditingController _controllerPassword = TextEditingController();
  final storage = FirebaseStorage.instance;

// final ava = FirebaseStorage.instance.ref().child("dog.jpeg");

Future<void> singInWithEmailAndPassword() async {
  try {
    await Auth().singInWithEmailAndPassword(email: _controllerEmail.text, password: _controllerPassword.text);
  } on FirebaseAuthException catch (e) {
    setState(() {
      errorMessage = e.message;
    });
  }
}

Future<void> createUserWithEmailAndPassword() async {
  try {
    await Auth().createUserWithEmailAndPassword(email: _controllerEmail.text, password: _controllerPassword.text);
  final User? user = Auth().currentUser;
//   final userAdd = <String, dynamic>{
//   "email": Auth().currentUser?.email,
//   "uid": Auth().currentUser?.uid,
// };

//   db.collection("users").add(userAdd);
userSetap(_controllerEmail.text);
  } on FirebaseAuthException catch (e) {
    setState(() {
      errorMessage = e.message;
    });
  }
}

// Future<void> addUserToFiresstore() {
//   final User? user = Auth().currentUser;
  

// final currentuid = user?.uid;
//   final userAdd = <String, dynamic>{
//   "email": Auth().currentUser?.email,
//   "uid": Auth().currentUser?.uid,
// };

// db.collection("users/$currentuid").add(userAdd)
  
// }



Widget _title() {
  return const Text('Welkome to Travel diary');
}


Widget _enrtyField(
  String title,
  TextEditingController controller,
  ) {
    return TextField(
      controller: controller,
      decoration: InputDecoration( labelText: title),
      
    );
  }

Widget _errorMessage() {
  return Text(errorMessage == '' ? '' : '$errorMessage');
}

Widget _submitButton() {
  
  return ElevatedButton(
    onPressed:
    isLogin? singInWithEmailAndPassword : createUserWithEmailAndPassword, 
   
    child: Text(isLogin ? 'Login' : 'Register'),);
}

Widget _loginOrRegisterButton() {
  
  return TextButton(
    onPressed: () {
      setState((){
        isLogin=!isLogin;
      });
    },
    child: Text(isLogin ? 'Register instead' : 'Login instead'),);
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: _title(),
       
       
      ),
      body: Container( 
        height:double.infinity,
        width: double.infinity,
        padding: const EdgeInsets.all(5),
        child: Column(
          
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.network( // <-- SEE HERE
      'https://firebasestorage.googleapis.com/v0/b/test-flutter-663cd.appspot.com/o/Traveler.jpg?alt=media&token=1f9bd3ef-bb16-4241-a470-4436321dfa12',
    ),
            _enrtyField('email', _controllerEmail),
            _enrtyField('password', _controllerPassword),
            _errorMessage(),
            _submitButton(),
            _loginOrRegisterButton(),
          ],
          ),
        ),
    );
  }
  
}