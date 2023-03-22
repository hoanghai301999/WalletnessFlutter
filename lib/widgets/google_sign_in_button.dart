import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:best_flutter_ui_templates/auth/user_info_screen.dart';
import 'package:best_flutter_ui_templates/utils/authentication.dart';
import 'package:best_flutter_ui_templates/model/register_request_model.dart';
import 'package:best_flutter_ui_templates/fitness_app/fitness_app_home_screen.dart';
import '../services/api_service.dart';
import '../config.dart';
import '../model/login_request_model.dart';

class GoogleSignInButton extends StatefulWidget {
  @override
  _GoogleSignInButtonState createState() => _GoogleSignInButtonState();
}

class _GoogleSignInButtonState extends State<GoogleSignInButton> {
  bool _isSigningIn = false;
  bool isApiCallProcess = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: _isSigningIn
          ? CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            )
          : OutlinedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.white),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40),
                  ),
                ),
              ),
              onPressed: () async {
                setState(() {
                  _isSigningIn = true;
                });
                User? user =
                    await Authentication.signInWithGoogle(context: context);

                setState(() {
                  _isSigningIn = false;
                });
                // Check if the user is signed in
                if (user != null) {
                  String uid = user.uid; // <-- User ID
                  String? email = user.email; // <-- Their email
                  debugPrint('Username: $email');
                  // check email exist

                  LoginRequestModel model = LoginRequestModel(
                    username: email,
                    password: "authcheck",
                  );
                  try {
                    APIService.login(model).then(
                      (response) {
                        debugPrint('login:$response');
                        if (response) {
                          //Navigator.pushNamedAndRemoveUntil(
                          //context,
                          //'/home',
                          //(route) => false,
                          //);
                        } else {
                          RegisterRequestModel model = RegisterRequestModel(
                            username: email,
                            password: "authcheck",
                          );
                          APIService.register(model).then(
                            (response) {
                              debugPrint('register : $response');
                              if (response.data != null) {
                              } else {}
                            },
                          );
                          //if user not exist then register
                        }
                      },
                    );
                  } on Exception catch (_) {
                    print("throwing new error123");
                    throw Exception("Error on server123");
                  }
                }

                if (user != null) {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                        builder: (context) => FitnessAppHomeScreen(user: user)),
                  );
                }
              },
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image(
                      image: AssetImage("assets/google_logo.png"),
                      height: 35.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(
                        'Sign in with Google',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black54,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
