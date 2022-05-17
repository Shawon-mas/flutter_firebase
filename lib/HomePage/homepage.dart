
import 'package:ct_helpline/Login/signin.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Hompage extends StatefulWidget {
/*  String? number;
  String? password;

  Hompage(
      {this.number,
      this.password});*/ // const Hompage({Key? key}) : super(key: key);
  String? email;
  Hompage(
      {this.email,
        });


  @override
  _HompageState createState() => _HompageState();
}

class _HompageState extends State<Hompage> {
  final _auth = FirebaseAuth.instance;
  _signOut() async{
    await _auth.signOut();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "You have logged in successfully",
              style: TextStyle(fontSize: 20.0, color: Colors.redAccent),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              padding: EdgeInsets.only(top: 3, left: 3),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  border: Border(
                    bottom: BorderSide(color: Colors.black),
                    top: BorderSide(color: Colors.black),
                    left: BorderSide(color: Colors.black),
                    right: BorderSide(color: Colors.black),
                  )),
              child: MaterialButton(
                height: 50,
                onPressed: () async{
                  await _signOut();
                      if(_auth.currentUser==null)
                      {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> LoginScreen(),),);
                      }
                },
                color: Colors.yellow,
                elevation: 0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50)),
                child: Text(
                  "Sign Out",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

}
