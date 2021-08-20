import 'package:flash_chat/constants.dart';
import 'package:flutter/material.dart';
import '../components/round_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'chat_screen.dart';

class LoginScreen extends StatefulWidget {
  static String id = 'login_screen';


  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final fieldEmail = TextEditingController();
  final fieldPassword = TextEditingController();
  final _auth = FirebaseAuth.instance;
  bool showSpinner = false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Hero(
                tag: 'logo',
                child: Container(
                  height: 200.0,
                  child: Image.asset('images/logo.png'),
                ),
              ),
              SizedBox(
                height: 48.0,
              ),
              TextField(
                controller: fieldEmail,
                keyboardType: TextInputType.emailAddress,
                textAlign: TextAlign.center,
                decoration: kTextFieldDecoration.copyWith(
                  hintText: 'Enter your email',
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                obscureText: true,
                textAlign: TextAlign.center,
                controller: fieldPassword,
                decoration: kTextFieldDecoration.copyWith(
                  hintText: 'Enter your password'
                ),
              ),
              SizedBox(
                height: 24.0,
              ),
              RoundButton(
                colour: Colors.lightBlueAccent,
                onPress: () async {
                  setState(() {
                    showSpinner = true;
                  });
                  try {
                    final newUser = await _auth.signInWithEmailAndPassword(
                        email: fieldEmail.text, password: fieldPassword.text);
                    if(newUser != null){
                      Navigator.pushNamed(context, ChatScreen.id);
                    }
                    fieldEmail.clear();
                    fieldPassword.clear();
                    setState(() {
                      showSpinner = false;
                    });
                  } catch (e) {
                    print(e);
                  }
                },
                buttonText: 'Log In',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
