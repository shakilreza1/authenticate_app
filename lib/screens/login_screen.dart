import 'package:authenticate_app/screens/home.dart';
import 'package:authenticate_app/screens/registration_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';


class LoginScreen extends StatefulWidget {

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {


  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _email, _password;

  TextEditingController _controller = TextEditingController();
  TextEditingController _passcontroller = TextEditingController();

  //Password Visible
  bool _isHidden = true;
  bool _passVisible = true;

  void _toggleVisibility(){
    setState(() {
      _isHidden =! _isHidden;
    });
  }


  login()async
  {
    if(_formKey.currentState.validate())
    {
      _formKey.currentState.save();
      try{
        final user = await _auth.signInWithEmailAndPassword(email: _email, password: _password);
        Fluttertoast.showToast(msg: "SignIn Successful");
        _controller.clear();
        _passcontroller.clear();

        Navigator.push(context, MaterialPageRoute(builder: (context)=> HomeScreen()));
      }
      catch(e)
      {
        Fluttertoast.showToast(msg: "Opps!! Account Not Valid");
      }
    }
  }


  navigateToSignUp()async
  {
    Navigator.push(context, MaterialPageRoute(builder: (context)=> RegisterScreen()));
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(

        body: SingleChildScrollView(
          child: Container(

            child: Column(

              children: <Widget>[

                Container(

                  height: 400,
                  child: Image(image: AssetImage("images/login.jpg",),
                    fit: BoxFit.contain,
                  ),
                ),

                Container(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        Container(
                          child: TextFormField(
                              decoration: InputDecoration(
                                  labelText: 'Email',
                                  prefixIcon:Icon(Icons.email)
                              ),
                            controller: _controller,
                            validator: (String value){
                              if(value.isEmpty)
                              {
                                return 'Email Is Required';
                              }
                              if(!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]+.com").hasMatch(value)){
                                return 'Invalid Email Address';
                              }
                              return null;
                            },
                            onChanged: (val){
                              _email = val;
                            },
                          ),
                          margin: EdgeInsets.only(left: 20.0,right: 20.0),
                        ),
                        Container(
                          child: TextFormField(
                            obscureText: _passVisible,
                              decoration: InputDecoration(
                                labelText: 'Password',
                                prefixIcon:Icon(Icons.lock),
                                suffixIcon:IconButton(
                                  icon: _passVisible
                                      ?Icon(Icons.visibility_off)
                                      :Icon(Icons.visibility),
                                  onPressed: ()
                                  {
                                    setState(() {
                                      _passVisible =! _passVisible;
                                    });
                                  }
                                ),
                              ),

                            controller: _passcontroller,
                            validator: MultiValidator([
                              RequiredValidator(
                                  errorText: "Password Is Required"),
                              MinLengthValidator(6,
                                  errorText: "Minimum 6 Characters Required"),
                            ]),

                              onChanged: (val){
                              _password = val;
                              },

                          ),
                          margin: EdgeInsets.only(left: 20.0,right: 20.0),
                        ),
                        SizedBox(height:20),

                        //Extra Button Design
                        /*Container(
                          height: 40,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [Colors.blueAccent, Colors.pinkAccent],
                            ),
                            borderRadius: BorderRadius.circular(45),
                            boxShadow:[
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 5.0, // soften the shadow
                                spreadRadius: 1.0, //extend the shadow
                                offset: Offset(
                                  0.0, // Move to right 10  horizontally
                                  0.0, // Move to bottom 10 Vertically
                                ),
                              ),
                            ]

                          ),
                          child: RaisedButton(
                            padding: EdgeInsets.fromLTRB(70,10,70,10),
                            onPressed: login,

                            child: Text('LOGIN',style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold

                            )),

                            color: Colors.transparent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),

                          ),
                        ),*/
                        RaisedButton(
                          padding: EdgeInsets.fromLTRB(70,10,70,10),
                          onPressed: login,
                          child: Text('Login',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          color: Colors.orange,
                          shape: RoundedRectangleBorder(

                            borderRadius: BorderRadius.circular(20.0),
                          ),

                        )
                      ],
                    ),

                  ),
                ),

                SizedBox(height: 10.0,),
                GestureDetector(
                  child: Text('Do Not Have Account? Create Account',style: TextStyle(letterSpacing:0.5,color: Colors.red,fontWeight: FontWeight.w400),),
                  onTap: navigateToSignUp,
                )
              ],
            ),
          ),
        )

    );
  }
}