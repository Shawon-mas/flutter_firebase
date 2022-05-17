import 'dart:async';
import 'dart:convert';

import 'package:ct_helpline/Login/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import '../HomePage/homepage.dart';

class LoginScreen extends StatefulWidget {


  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late StreamSubscription<User?> user;
  bool _isObscure = true;
  final _auth = FirebaseAuth.instance;

  //bool _validate = false;
  TextEditingController email=TextEditingController();
  TextEditingController password=TextEditingController();
  final formKey=GlobalKey<FormState>();
  void login(String email,String password) async{
    try{
     final user= await _auth.signInWithEmailAndPassword(
          email: email, password: password);


      Fluttertoast.showToast(
          msg: "Login Successful",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0
      );
      Navigator.push(context, MaterialPageRoute(builder: (context) => Hompage(email: email,),),);
    }on FirebaseAuthException catch(e){
      Fluttertoast.showToast(
          msg: '${e.message}',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0
      );
    }


  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child:Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height,
          margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
          child: Column(
            children:<Widget> [
              Container(
                height: MediaQuery.of(context).size.height / 4,
                decoration: BoxDecoration(),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: AnimatedImage()
                ),
              ),
              SizedBox(height: 10,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children:<Widget> [
                  Text('Sign In',textAlign: TextAlign.center,style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30.0
                  ),),
                  SizedBox(height: 10,),
                  Text('Please login your account',style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.grey[700],
                  ),),
                ],
              ),
              SizedBox(height: 40,),
              Padding(
                padding:EdgeInsets.symmetric(horizontal: 20),
                child: Column(

                  children:<Widget> [
                    makeInput(),
                    SizedBox(height: 10,),

                  ],
                ),
              ),

              SizedBox(height: 20,),
              Padding(padding:EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  padding: EdgeInsets.only(top: 3, left: 3),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      border: Border(
                        bottom: BorderSide(color: Colors.black),
                        top: BorderSide(color: Colors.black),
                        left: BorderSide(color: Colors.black),
                        right: BorderSide(color: Colors.black),
                      )
                  ),
                  child: MaterialButton(
                    minWidth: double.infinity,
                    height: 50,
                    onPressed: () {
                      setState(() {
                        if (formKey.currentState!.validate()) {
                          print("Okkkkkkkkkkkkkkkkkkkkkkkkkk");

                        } else {
                          print("Something wrong");
                        }
                        login(email.text,password.text);
                       /* number.text.isEmpty ? _validate = true : _validate = false;
                        password.text.isEmpty ? _validate = true : _validate = false;*/
                      });


                    },
                    color: Colors.yellow,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50)
                    ),
                    child: Text("Sign In", style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18
                    ),),
                  ),
                ),
              ),
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,

                children: [
                  Text("Don't Have account?",style: TextStyle(

                  ),),
                  SizedBox(width: 10,),
                  GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> SignUP(),),);
                      /*Navigator.push(context, MaterialPageRoute(builder: (context) => Hompage(


                      );*/
                    },
                    child: Text(
                      "Sign Up",style: TextStyle(

                color: Colors.deepOrange,
                fontWeight: FontWeight.bold,
                      fontSize: 16

              ),),
                  ),
                ],
              ),
              SizedBox(height: 10,),

            ],
          ),
        ),
      ),
    );
  }
  Widget makeInput(){
    return Form(
      key: formKey,
      child: Column(

      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget> [
        SizedBox(height: 5,),
        TextFormField(
          validator: (value){
            if(!value!.contains("@"))
            {
              return "Enter a valid email Address";
            }
          },
          keyboardType: TextInputType.emailAddress,
          controller: email,
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.email),
               labelText: "Enter Email",
               hintText: "Enter your Email",
            /*  errorText: _validate ? 'Number Can\'t Be Empty' : null,*/
              contentPadding: EdgeInsets.symmetric(vertical: 0,horizontal: 10),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(color: Colors.grey)
              ),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(color: Colors.grey)
              )
          ),
        ),
        SizedBox(height: 20,),
        TextFormField(
          validator: (value) {
            if (value!.isEmpty) {
              return "Enter your password";
            }
            if (value.length > 10) {
              return " Password length does not exist";
            }
            if (value.length < 6) {
              return "Minimum password length is 6";
            }
          },
          controller: password,
          obscureText:_isObscure,
          decoration: InputDecoration(
              prefixIcon: Icon(Icons.lock),
              suffixIcon: IconButton(onPressed: ()
              {
                setState(() {
                  _isObscure = !_isObscure;
                });

                }, icon: Icon(_isObscure?Icons.visibility : Icons.visibility_off,)),
                hoverColor: Colors.red,
                labelText: "Enter Password",
                hintText: "Enter your Password",
                /*errorText: _validate ? 'Password Can\'t Be Empty' : null,*/

                contentPadding: EdgeInsets.symmetric(vertical: 0,horizontal: 10),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color: Colors.grey)
                ),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color: Colors.grey)
                )
            ),
          ),
        SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(

                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Forgot Password?",
                  style: TextStyle(
                    shadows: [
                      Shadow(
                          color: Colors.black,
                          offset: Offset(0, -5))
                    ],
                    color: Colors.transparent,
                    decoration:
                    TextDecoration.underline,
                    decorationColor: Colors.black,
                    decorationThickness: 2,

                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  /*void login(String mail, String pass) {
    *//*mail="abc@gmail.com";
    pass="123456";*//*

   *//* if(mail=="abc@gmail.com" && pass=="123456" )
    {
      Fluttertoast.showToast(
          msg: "Login Success",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0
      );

      Navigator.push(context, MaterialPageRoute(builder: (context) => Hompage(
        number:email.text,
        password:password.text,
      ),),);
    }else{
      Fluttertoast.showToast(
          msg: "Wrong Credentials",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
    }*//*



  }*/
  
}
class AnimatedImage extends StatefulWidget {
  const AnimatedImage({Key? key}) : super(key: key);

  @override
  State<AnimatedImage> createState() => _AnimatedImageState();
}

class _AnimatedImageState extends State<AnimatedImage> with SingleTickerProviderStateMixin {
  late final AnimationController _controller =AnimationController(vsync: this,
  duration: const Duration(
    seconds: 1),
  )..repeat(reverse: true);
  late Animation<Offset> _animation=Tween(
    begin: Offset.zero,
    end: Offset(0,0.08),
  ).animate(_controller);
  

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(position: _animation,
    child:SvgPicture.asset("images/login.svg",
    ),
    );
  }
}

/*

 */

//LoginScreen