import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final _auth = FirebaseAuth.instance;
  FirebaseUser loggedInUser;

  void initState(){
    super.initState();
    getCurrentUser();

  }

  void getCurrentUser()async{
    try{
      final user = await _auth.currentUser;
      if(user != null){
        loggedInUser = user;
      }
    }catch(e){
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        centerTitle: true,
      ),

      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              child: Center(
                child: FlatButton(
                  color: Colors.redAccent,
                  splashColor: Colors.blue,
                  padding: EdgeInsets.all(25.0),
                  child: Text(
                      "Logout",
                    style: TextStyle(fontSize: 40.0,color: Colors.white,fontWeight: FontWeight.w400),
                  ),
                  onPressed: (){
                    _auth.signOut();
                    Navigator.pop(context);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
