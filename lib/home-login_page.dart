import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_auth_project/auth.dart';
import "auth.dart";
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';

class HomeLoginPage extends StatefulWidget {
  const HomeLoginPage({super.key});


  @override
  State<HomeLoginPage> createState() => _HomeLoginPageState();
}

class _HomeLoginPageState extends State<HomeLoginPage> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController _controllerCountry = TextEditingController();
  TextEditingController _controllerPost = TextEditingController();
final User? user = Auth().currentUser;
final storage = FirebaseStorage.instance;

final ava = FirebaseStorage.instance.ref().child("dog.jpeg");

Future<void> singOut() async {
  await Auth().singOut();
}

Future<void> addCountry(String _controllerCountry, String _controllerPost) async {
  
   FirebaseAuth auth= FirebaseAuth.instance;
  String? uid = auth.currentUser?.uid.toString();
 
  CollectionReference users = FirebaseFirestore.instance.collection("users");
  var current_user = users.where("uid", isEqualTo: uid).get().then((value) {
    
    var sec_path = value.docs[0].id;
    
    users.doc(sec_path).collection("countries").add({"country":_controllerCountry, 'post about': _controllerPost});
  
  });
}




List contryList = [];

// Widget _list(contryList) {
//   return Text(contryList?[0] ?? 'list ot visited counrtys');
// }
  




Future<void> getCountrys (user) async {

  String? uid = user?.uid.toString();
 
  CollectionReference users = FirebaseFirestore.instance.collection("users");
  var current_user = users.where("uid", isEqualTo: uid).get().then((value) {
    var sec_path = value.docs[0]?.id;
FirebaseFirestore.instance.collection("users/$sec_path/countries").get().then(
  (querySnapshot) {
    
  
    for (var docSnapshot in querySnapshot.docs) {
 
      contryList.add(docSnapshot.data()['country']);
      print(docSnapshot.data()['country']);
   
  }
  }
);
});

}


Widget _userUidEmail() {
  return Text(user?.email ?? 'User email');
}



/////////////////////



Widget _userUid(){
  return Text(user?.uid ?? "false");
}
Widget _singOutButton() {
  return ElevatedButton(onPressed: singOut, child: const Text("Sing Out"),);
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

Widget _submitButton() {
  return ElevatedButton(
    onPressed: () async {
      await addCountry(_controllerCountry.text.trim(),_controllerPost.text);
      getCountrys(user);
        },
    child: Text('Add counrty'),);
}




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: (AppBar(title: const Text("Welcome to the Travel Diary"))),

      body: Container(
        height: double.infinity,
        width: double.infinity,
        padding: const EdgeInsets.all(5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // _userUid(),
            Image.network( // <-- SEE HERE
      'https://firebasestorage.googleapis.com/v0/b/test-flutter-663cd.appspot.com/o/dog.jpeg?alt=media&token=9780aee6-14d8-43ad-9c93-c198b2ef36fd',
    ),
            _userUidEmail(),
            _enrtyField('country' , _controllerCountry),
            _enrtyField('write about your emoutions' , _controllerPost),
            _submitButton(),
            // _list(contryList),
            _singOutButton()
          ],
        ),
      )

    );
  }
}
