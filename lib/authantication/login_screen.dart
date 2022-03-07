import 'package:ecommerce_app/authantication/register_screen.dart';
import 'package:ecommerce_app/firebase_data/firestore_utils.dart';
import 'package:ecommerce_app/provider/auth_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import '../home/home_screen.dart';
import '../utils.dart';

class LoginScreen extends StatefulWidget {
  static final routeName = 'login_screen';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  String email = '';
  String password = '';
  var formKey = GlobalKey<FormState>();
  late AuthProvider provider;
  Widget build(BuildContext context) {
    provider=Provider.of<AuthProvider>(context);
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
                      'Welcome',
                      style: Theme.of(context).textTheme.headline1,
                    ),
                    InkWell(
                        onTap: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RegisterScreen()));
                        },
                        child: Text(
                          'Sign',
                          style: Theme.of(context).textTheme.headline2,
                        )),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Sign in to Continue',
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        color: Color.fromRGBO(146, 146, 146, 1.0),
                      ),
                ),
                SizedBox(
                  height: 52,
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
                  height: 52,
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
                  height: 20,
                ),
                Container(
                  alignment: Alignment.topRight,
                  child: Text(
                    'Forget Password?',
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          color: Color.fromRGBO(0, 0, 0, 1.0),
                        ),
                  ),
                ),
                SizedBox(
                  height: 22,
                ),
                Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.05,
                  child: FlatButton(
                    textColor: Colors.white,
                    child: Text('Login'),
                    color: Colors.green,
                    onPressed: () {
                      if (formKey.currentState?.validate() == true) {
                        signInFirebaseAuth();
                      }
                    },
                  ),
                ),
                Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.symmetric(
                        vertical: MediaQuery.of(context).size.height * .05),
                    child: Text(
                      '- OR -',
                      style: TextStyle(fontSize: 20),
                    )),
                InkWell(
                    onTap: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RegisterScreen()));
                    },
                    child: signInButton(
                        "Sign up with Facebook", Buttons.Facebook)),
                signInButton("Sign up with Google", Buttons.Google),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<String?> signInwithGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount!.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
      await _auth.signInWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      print(e.message);
      throw e;
    }
  }

  Widget signInButton(String text, Buttons buttons) {
    return Container(
        height: MediaQuery.of(context).size.height * 0.07,
        width: double.infinity,
        margin: EdgeInsets.all(8),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
        ),
        child: SignInButton(
          buttons,
          text: text,
          onPressed: () {
            signInwithGoogle();
          },
        ));
  }

  void signInFirebaseAuth() async {
    try {
      var result = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      if (result.user != null) {
        showMessage(context, 'Login is successful');
       var firestoreUser=  await getUserById(result.user!.uid);
       if(firestoreUser!=null){
         provider.updateUser(firestoreUser);
         Navigator.pushReplacementNamed(context, HomeScreen.routeName);
       }
      }
    } catch (error) {
      showMessage(context, 'This account do not exist');
    }
  }
}
