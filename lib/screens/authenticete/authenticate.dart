import 'package:brew_crew/screens/authenticete/register.dart';
import 'package:brew_crew/screens/authenticete/sign_in.dart';
import 'package:brew_crew/screens/authenticete/authenticate.dart';
import 'package:flutter/material.dart';

class Authenticate extends StatefulWidget {
  const Authenticate({ Key? key }) : super(key: key);

  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {

  bool isSignIn = true;
  void toggleView() {
    setState(() => isSignIn = !isSignIn);
  }

  @override
  Widget build(BuildContext context) {
      if (isSignIn) {
        return SignIn(toggleView: toggleView);       
      } 
      else {
        return Register(toggleView: toggleView);
      }
  }
}