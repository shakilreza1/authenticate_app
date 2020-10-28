import 'package:authenticate_app/screens/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';


class RegisterScreen extends StatefulWidget {

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {


  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _email,_password;
  TextEditingController password = TextEditingController();
  TextEditingController confirmpassword = TextEditingController();

  //Password Visible
  bool _isHidden = true;
  bool _passVisible = true;
  bool _cpassVisible = true;

  void _toggleVisibility(){
    setState(() {
      _isHidden =! _isHidden;
    });
  }
  //Password Visible


  register()async
  {
    if(_formKey.currentState.validate())
    {

      _formKey.currentState.save();

      try{
        final user = await _auth.createUserWithEmailAndPassword(email: _email, password: _password);
        Fluttertoast.showToast(msg: "Congrats, Account Created Successful");
        Navigator.push(context, MaterialPageRoute(builder: (context)=> LoginScreen()));
      }

      catch(e)
      {
        Fluttertoast.showToast(msg: "Opps!! This Account Is Already Exits");
      }

    }
  }
  navigateToSignIn()async
  {
    Navigator.push(context, MaterialPageRoute(builder: (context)=> LoginScreen()));
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
                            //Another System to validate email
                            /*validator: MultiValidator([
                              RequiredValidator(
                                  errorText: "Email Is Required"),
                              EmailValidator(errorText: "Invalid Email Address"),
                            ]),*/
                            //Another System to validate email
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
                            keyboardType: TextInputType.number,
                            controller: password,
                              decoration: InputDecoration(
                                labelText: 'Password',
                                prefixIcon:Icon(Icons.lock),
                                suffixIcon: IconButton(
                                  icon: _passVisible
                                      ?Icon(Icons.visibility_off)
                                      :Icon(Icons.visibility),
                                  onPressed: (){
                                    setState(() {
                                      _passVisible =! _passVisible;
                                    });
                                  },
                                ),
                              ),
                              obscureText: _passVisible,

                            validator: (String value){
                              if(value.isEmpty)
                              {
                                return 'Password Is Required';
                              }
                              if(value.length < 6){
                                return 'Minimum 6 Characters Required';
                              }
                              return null;
                            },

                            onChanged: (val){
                              _password = val;
                            },
                          ),
                          margin: EdgeInsets.only(left: 20.0,right: 20.0),
                        ),

                        Container(
                          child: TextFormField(
                            controller: confirmpassword,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: 'Confirm Password',
                              prefixIcon:Icon(Icons.lock),
                              suffixIcon: IconButton(
                                icon: _cpassVisible
                                    ?Icon(Icons.visibility_off)
                                    :Icon(Icons.visibility),
                                onPressed: (){
                                  setState(() {
                                    _cpassVisible =! _cpassVisible;
                                  });
                                },
                              ),
                            ),
                            obscureText: _cpassVisible,

                            validator: (String value){
                              if(value.isEmpty)
                              {
                                return 'Confirm Password Is Required';
                              }
                              if(value.length < 6){
                                return 'Minimum 6 Characters Required';
                              }
                              if(password.text != confirmpassword.text){
                                return 'Password Does Not Match!!';
                              }
                              return null;
                            },
                          ),
                          margin: EdgeInsets.only(left: 20.0,right: 20.0),
                        ),
                        SizedBox(height:20),

                        RaisedButton(
                          padding: EdgeInsets.fromLTRB(70,10,70,10),
                          onPressed: register,
                          child: Text('Register',
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
                  child: Text('Already have an account? SignIn Here',style: TextStyle(letterSpacing:0.5,color: Colors.red,fontWeight: FontWeight.w400),),
                  onTap: navigateToSignIn,
                )
              ],
            ),
          ),
        )

    );
  }

}