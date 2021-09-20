import 'package:flutter/material.dart';
import 'package:profile_app_task/screens/homeScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../main.dart';

bool isLogged = false;

anyScreen()async{
  var shared = await SharedPreferences.getInstance();
   isLogged = shared.getBool('login')!;
}

class MySplashScreen extends StatefulWidget {
  @override
  _MySplashScreenState createState() => _MySplashScreenState();
}

class _MySplashScreenState extends State<MySplashScreen> {
  Widget goToScreen = isLogged?HomeScreen():LoginScreen();

  @override
  void initState() {
    super.initState();
    navigateToSecondPage();
  }

  navigateToSecondPage() async{
    await Future.delayed(Duration(seconds: 3));
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>goToScreen));
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.deepPurple,
                Colors.deepPurple.withOpacity(0.65),
              ],
            ),
          ),
          child: Stack(
            children: [
              Align(
                alignment: Alignment.center,
                child: Text('ITG Registration App',style: TextStyle(color: Colors.white,
                fontWeight: FontWeight.bold,fontSize: 30),),
              ),
              Positioned(
                bottom: size.height*0.1,
                left: size.width*0.355,
                child: Text('By Ammar Abu Srour',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
              )
            ],
          )
      ),
    );
  }

}
