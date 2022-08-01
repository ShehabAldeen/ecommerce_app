import 'package:ecommerce_app/authantication/login_screen.dart';
import 'package:ecommerce_app/firebase_data/user.dart' as AppUser;
import 'package:ecommerce_app/provider/auth_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../firebase_data/firestore_utils.dart';
import '../utils.dart';

class RegisterScreen extends StatefulWidget {
  static final routeName = 'register_screen';

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  var formKey = GlobalKey<FormState>();
  String firstName = '';

  String email = '';

  String password = '';
  late AuthProvider provider;
  Widget build(BuildContext context) {
   provider= Provider.of<AuthProvider>(context);
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 50, right: 20, left: 20),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Sign Up',
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(
                  height: size.height * .05,
                ),
                TextFormField(
                  decoration: InputDecoration(hintText: 'Name'),
                  onChanged: (text) {
                    firstName = text;
                  },
                  validator: (text) {
                    if (text == null || text.isEmpty) {
                      return 'Please enter a name';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: size.height * .05,
                ),
                TextFormField(
                  decoration: InputDecoration(hintText: 'Email'),
                  onChanged: (text) {
                    email = text;
                  },
                  validator: (text) {
                    if (text == null || text.trim().isEmpty) {
                      return 'Please enter an email';
                    }
                    if (!isValidEmail(email)) {
                      return 'invalid email';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: size.height * .05,
                ),
                TextFormField(
                  decoration: InputDecoration(hintText: 'password'),
                  onChanged: (text) {
                    password = text;
                  },
                  validator: (text) {
                    if (text == null || text.trim().isEmpty) {
                      return 'Please enter a password';
                    }
                    if (password.length < 6) {
                      return 'at least 6 character';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: size.height * .05,
                ),
                Container(
                  width: double.infinity,
                  height: size.height * 0.05,
                  child: FlatButton(
                    textColor: Colors.white,
                    child: Text('SIGN Up'),
                    color: Colors.green,
                    onPressed: () {
                      if (formKey.currentState?.validate() == true) {
                        addUserToFirebaseAuth();
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void addUserToFirebaseAuth() async {
    try {
      var result = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
    var user = AppUser.User (id: result.user!.uid, firstName:firstName ,
          password: password, email: email);
      if (result.user != null) {
        addUserToFirestore(user).then((value) {
          provider.updateUser(user);
          Navigator.pushReplacementNamed(context, LoginScreen.routeName);
        }).onError((error, stackTrace) {
          showMessage(context, error.toString());
        });
      }
    } catch (error) {
      showMessage(context, error.toString());
    }
  }
}
