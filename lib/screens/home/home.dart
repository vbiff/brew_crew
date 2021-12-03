import 'package:brew_crew/models/brew.dart';
import 'package:brew_crew/screens/home/settings_form.dart';
import 'package:brew_crew/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:brew_crew/services/database.dart';
import 'package:provider/provider.dart';
import 'brew_list.dart';


class Home extends StatelessWidget {


  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {

  void _showSettingsPanel()  {
    showModalBottomSheet(context: context, builder: (context) {
      return Container(
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 60),
        child: const SettingsForm(),
      );
    });
  }

    return StreamProvider<List<Brew>?>.value(
      initialData: null, 
      value: DatabaseService(uid:'').brews,
      child: Scaffold(
        backgroundColor: Colors.brown[50],
        appBar: AppBar(
          centerTitle: false,
          backgroundColor: Colors.brown[400],
          elevation: 0.0,
          title: const Text('BrewCrew'),
          actions: [
            TextButton.icon(
              onPressed: () async {
                await _auth.signOut();
              },
              icon: const Icon(Icons.person, size: 15),
              label: const Text('logout'),           
              style: ButtonStyle(foregroundColor: MaterialStateProperty.all<Color?>(Colors.brown[800]),
              ),
            ),
            TextButton.icon(
              icon: const Icon(Icons.settings, size: 15),
              label: const Text('Settings'),
              
              style: ButtonStyle(foregroundColor: MaterialStateProperty.all<Color?>(Colors.brown[800])),
              onPressed: () => _showSettingsPanel()
            ),
          ],
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/coffee_bg.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: const BrewList()
          ),
      ),
    );
  }
}