
// import 'package:cloud_firestore/cloud_firestore.dart';

// class UserModel {
//   String? userID;
//   String? email;
 


//   UserModel({
//     this.userID,
//     this.email,
//   });

//   Map<String, Object> toJson() {
//     return {
//       'userID': userID == null ? '' : userID,
//       'email': email == null ? '' : email,
//     };
//   }

//   factory UserModel.fromJson(Map<String, Object> doc) {
//     UserModel user = new UserModel(
//       userID: 'userID',
//       email: 'email',
//     );
//     return user;
//   }

//   factory UserModel.fromDocument(DocumentSnapshot doc) {
//     return UserModel.fromJson(doc.data);
//   }
// }