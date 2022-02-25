import 'package:cloud_firestore/cloud_firestore.dart';

class User{
  static String collectionName='user';
  String id;
  String firstName;
  String email;
  String password;

  User({required this.id,required this.firstName,required this.password,required this.email});
  User.fromJson(Map<String,dynamic> json):
      this(
        id:json['id'] as String,
        firstName:json['firstName'] as String,
        email:json['email'] as String,
        password:json['password'] as String
      );
  Map<String,dynamic> toJson() {
    return {
      'id': id,
      'firstName': firstName,
      'email': email,
      'password': password
    };
  }

 static CollectionReference<User> withConverter(){
   final usersRef = FirebaseFirestore.instance.collection(collectionName).
   withConverter<User>(
     fromFirestore: (snapshot, _) => User.fromJson(snapshot.data()!),
     toFirestore: (User, _) => User.toJson(),
   );
   return usersRef;
  }


}