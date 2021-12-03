import 'package:brew_crew/models/user.dart';
import 'package:brew_crew/services/database.dart';
import 'package:brew_crew/shared/loading.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:brew_crew/shared/constants.dart';
import 'package:provider/provider.dart';

class SettingsForm extends StatefulWidget {
  const SettingsForm({ Key? key }) : super(key: key);

  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {

  final _formkey = GlobalKey<FormState>();
  final List<String> sugars = ['0', '1', '2', '3', '4'];


  String? _currentName;
  String? _currentSugars;
  int? _currentStrength;

  @override
  Widget build(BuildContext context) {

  final user = Provider.of<AppUser?>(context);

    return StreamBuilder<UserData>(
      stream: DatabaseService(uid: user!.uid.toString()).userData,
      builder: (context, snapshot) { 

        if(snapshot.hasData){

          UserData? userData = snapshot.data;

          return Form(
          key: _formkey,
          child: Column(
            children: [
              Text(
                'Update your brew settings',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),
              TextFormField(
                initialValue: userData?.name,
                decoration: textInputDecoration,
                validator: (val) => val!.isEmpty ? 'Please, enter a name' : null,
                onChanged: (val) => setState(() => _currentName = val),
              ),
              SizedBox(height: 20),
              // drop down
              DropdownButtonFormField(
                decoration: textInputDecoration,
                value: _currentSugars ?? userData?.sugars,
                items: sugars.map((sugar) {
                  return DropdownMenuItem(
                    value: sugar,
                    child: Text('$sugar sugars'),
                    );
                }).toList(),
                onChanged: (val) => setState(() => _currentSugars = val.toString()),
                ),
                Slider(
                  min: 100.0,
                  max: 900.0,
                  activeColor: Colors.brown[_currentStrength ?? userData!.strength!.toInt()],
                  inactiveColor: Colors.brown[_currentStrength ?? userData!.strength!.toInt()],
                  divisions: 8,
                  value: (_currentStrength ?? userData!.strength!.toInt()).toDouble(),
                  onChanged: (val) => setState(() => _currentStrength = val.toInt()),
                  ),
              // slider
              ElevatedButton(
                style: ElevatedButton.styleFrom(primary: Colors.pink[400]),
                onPressed: () async {
                if(_formkey.currentState!.validate()) {
                  await DatabaseService(uid: user.uid.toString()).updateUserData(
                    _currentSugars ?? userData!.sugars.toString(),
                    _currentName ?? userData!.name.toString(),
                    _currentStrength ?? userData!.strength!.toInt(),
                    );
                    Navigator.pop(context);
                  }
                },
                child: const Text('Update', style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        );

        } else {
          return Loading();
        }
        
      }
    );
  }
}
