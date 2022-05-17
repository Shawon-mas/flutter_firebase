import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'Login/signin.dart';

 Future <void> main() async{
   WidgetsFlutterBinding.ensureInitialized();
   await Firebase.initializeApp
     (


     );

   runApp(
       MaterialApp(home: LoginScreen(),
         debugShowCheckedModeBanner: false,
       ));
 }
class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
