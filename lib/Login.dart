import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebasebasic/Home.dart';
import 'package:firebasebasic/Signup.dart';


class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String email,password;
  FirebaseAuth _auth = FirebaseAuth.instance;
  signin() async{
    try {
      final user = await _auth.signInWithEmailAndPassword(
        email: email, 
        password: password
      );
      if(user!=null){
        Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Screen'),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
        alignment: Alignment.center,
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                onChanged: (value){
                  setState(() {
                    this.email = value;
                  });
                },
                validator: (String value) {
                  if (value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  border:OutlineInputBorder(),
                  labelText: 'Email'
                ),
              ),
              SizedBox(height: 20.0),
              
              TextFormField(
                onChanged: (value){
                  setState(() {
                    this.password = value;
                  });
                },
                obscureText: true,
                decoration: InputDecoration(
                  border:OutlineInputBorder(),
                  labelText: 'Password',
                ),
                validator: (String value) {
                  if (value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  RaisedButton(
                    onPressed: signin,
                    child: Text(
                      'Login',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0
                      ),
                    ),
                    color: Colors.blue,
                    padding: EdgeInsets.fromLTRB(50.0, 0, 50.0, 0),
                  ),
                  SizedBox(width: 10.0),
                  RaisedButton(
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) =>Signup()));
                    },
                    child: Text(
                      'Signup',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0
                      ),
                    ),
                    color: Colors.blue,
                    padding: EdgeInsets.fromLTRB(50.0, 0, 50.0, 0),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}