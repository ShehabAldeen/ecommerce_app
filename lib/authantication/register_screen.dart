import 'package:ecommerce_app/authantication/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../utils.dart';

class RegisterScreen extends StatefulWidget {
  static final routeName = 'register_screen';

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  var formKey = GlobalKey<FormState>();
  String name = '';

  String email = '';

  String password = '';

  Widget build(BuildContext context) {
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
                    name = text;
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
                customTextFormFieldEmail(email),
                SizedBox(
                  height: size.height * .05,
                ),
                customTextFormFieldPassword(password),
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
                        Navigator.pushNamed(context, LoginScreen.routeName);
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
      if (result.user != null) {
        showMessage(context, 'User registered successfully');
      }
    } catch (error) {
      showMessage(context, error.toString());
    }
  }
}
