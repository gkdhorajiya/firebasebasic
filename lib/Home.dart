import 'package:firebasebasic/main.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseUser user;
  bool isloggedin= false;

  checkAuthentification() async{
    _auth.onAuthStateChanged.listen((user) { 
      if(user ==null)
      {
        Navigator.push(context, MaterialPageRoute(builder: (context)=> MyApp()));
      }
    });
  }

  getUser() async{
    FirebaseUser firebaseUser = await _auth.currentUser();
    await firebaseUser?.reload();
    firebaseUser = await _auth.currentUser();
    if(firebaseUser !=null)
    {
      setState(() {
        this.user =firebaseUser;
        this.isloggedin=true;
      });
    }
  }

  signOut()async{
    _auth.signOut();
  }

  @override
  void initState() { 
    super.initState();
    this.checkAuthentification();
    this.getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
        centerTitle: true,
      ),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _bodyText(bodytext: 'Welcome'),
              _bodyText(bodytext: '${user.email}'),
              _bodyText(bodytext: 'to Home Screen'),
              SizedBox(height:20.0),
              RaisedButton(
                onPressed: signOut,
                color: Colors.blue,
                padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
                child: Text(
                  'Log Out',
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _bodyText({String bodytext}) {
    return Text(
      '$bodytext',
      style: TextStyle(
        fontSize: 40.0
      ),
    );
  }
}