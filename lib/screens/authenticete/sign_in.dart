import 'package:brew_crew/screens/authenticete/register.dart';
import 'package:brew_crew/services/auth.dart';
import 'package:brew_crew/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:brew_crew/shared/loading.dart';


class SignIn extends StatefulWidget {

  final Function toggleView;
  SignIn({required this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  
  final AuthService _auth = AuthService();
  final _formkey = GlobalKey<FormState>();
  bool loading = false;

  // add email and pass
  String email = '';
  String password = '';
  String error = '';


  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: const Text(
          'Sign in, Please!'
        ),
        actions: [
          TextButton.icon(
            style: TextButton.styleFrom(primary: Colors.brown[800]),
            onPressed: () { widget.toggleView();
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => Register()),
              // );
            }, 
            icon: const Icon(Icons.person), 
            label: const Text('Sign up')
            ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form (
          key: _formkey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 20.0),
                TextFormField(
                  decoration: textInputDecoration.copyWith(hintText: 'Email'),

                  validator: (val) => val!.isEmpty ? 'Enter an Email' : null,
                  onChanged: (val) {
                    setState(() => email = val); 
                  },
                ),
                const SizedBox(height: 20.0),
                TextFormField(
                  decoration: textInputDecoration.copyWith(hintText: 'Password'),               
                  validator: (val) => val!.length < 6 ? 'Enter password 6+ chars long' : null,
                  obscureText: true,
                  onChanged: (val) {
                    setState(() => password = val); 
                  },
                ),
                const SizedBox(height: 20.0),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Colors.pink[400]),
                  child: const Text('Sign in', style: TextStyle(color: Colors.white)              
                  ),
                  onPressed: () async {
                    if (_formkey.currentState!.validate()) {
                        setState(() {
                          loading = true;
                        });
                        dynamic result = await _auth.signInWithEmailAndPassword(email, password); 
                        if (result == null){
                            setState(() {
                              error = 'Please, check your password or sign up';
                              loading = false;
                            
                        });
                      }
                    }
                  },
                ),
                SizedBox(height: 12.0),
                  Text(error,
                  style: const TextStyle(color: Colors.red, fontSize: 14.0)),
              ],
            ),
          ),
            
            ),
          
        
        ),
    );
  }
}