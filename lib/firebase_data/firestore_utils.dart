import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/firebase_data/user.dart';

Future<void> addUserToFirestore(User user){
  return User.withConverter().doc(user.id).set(user);
}

Future<User?> getUserById(String id)async{
 DocumentSnapshot<User> result  = await User.withConverter().doc(id).get();
 return result.data();
}