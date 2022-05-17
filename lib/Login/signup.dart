import 'package:ct_helpline/Login/signin.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
class SignUP extends StatefulWidget {

  const SignUP({Key? key}) : super(key: key);

  @override
  State<SignUP> createState() => _SignUPState();
}

class _SignUPState extends State<SignUP> {
  final _auth = FirebaseAuth.instance;
  final formKey=GlobalKey<FormState>();
  bool _isObscure = true;
  //bool _validate = false;
  TextEditingController name=TextEditingController();
  TextEditingController email=TextEditingController();
  TextEditingController password=TextEditingController();
  void login(String name,String email,String password) async{
          try{
           await _auth.createUserWithEmailAndPassword(email: email, password: password);
           Fluttertoast.showToast(
               msg: "Registration Successful",
               toastLength: Toast.LENGTH_SHORT,
               gravity: ToastGravity.BOTTOM,
               timeInSecForIosWeb: 1,
               backgroundColor: Colors.green,
               textColor: Colors.white,
               fontSize: 16.0
           );
          await Navigator.push(context, MaterialPageRoute(builder: (context)=> LoginScreen(),),);

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
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        title: Text('Sign Up'),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset("images/login.svg",
                  width: double.maxFinite,
                  height: 150,
                ),
              ],
            ),
            SizedBox(height: 10,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children:<Widget> [
                Text('Sign Up',textAlign: TextAlign.center,style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30.0
                ),),
                SizedBox(height: 10,),
                Text('Please signup your account',style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.grey[700],
                ),),
              ],
            ),
            Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(


                  children:
                  [
                    SizedBox(height: 5,),
                    TextFormField(
                      validator: (value){
                        if(value!.isEmpty)
                        {
                          return "Please Enter Your Name";
                        }
                      },
                      keyboardType: TextInputType.name,
                      controller: name,
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.person),
                          hintText: "Enter your Name",
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
                    SizedBox(height: 15,),
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
                    SizedBox(height: 15,),
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
                  ],
                ),
              ),
            ),
            SizedBox(height: 50,),
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
                      login(name.text,email.text,password.text);
                      /* number.text.isEmpty ? _validate = true : _validate = false;
                          password.text.isEmpty ? _validate = true : _validate = false;*/
                    });


                  },
                  color: Colors.yellow,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50)
                  ),
                  child: Text("Sign Up", style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 18
                  ),),
                ),

              ),
            ),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,

              children: [
                Text("Already Have Account?",style: TextStyle(

                ),),
                SizedBox(width: 10,),
                GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> LoginScreen(),),);
                    /*Navigator.push(context, MaterialPageRoute(builder: (context) => Hompage(


                      );*/
                  },
                  child: Text(
                    "Sign In",style: TextStyle(

                      color: Colors.deepOrange,
                      fontWeight: FontWeight.bold,
                      fontSize: 16

                  ),),
                ),
              ],
            ),

          ],
        ),
      ),

    );
  }
}

