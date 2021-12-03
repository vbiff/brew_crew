import 'package:brew_crew/models/user.dart';
import 'package:brew_crew/screens/authenticete/authenticate.dart';
import 'package:brew_crew/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:brew_crew/screens/home/home.dart';
import 'package:provider/provider.dart';


class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<AppUser?>(context);

    //either return home or auth widget
    if (user == null)  {
      return const Authenticate();
    } else {
      return Home();
    }
  }
}