import 'package:flutter/material.dart';
import 'package:profile_app_task/screens/signUpScreen.dart';
import 'package:toast/toast.dart';
import 'screens/homeScreen.dart';
import 'widgets/splashScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async{

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Login Page',
      routes: {
        SignUpScreen.routeName: (context)=> SignUpScreen(),
        HomeScreen.routeName: (context)=> HomeScreen(),
      },
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MySplashScreen(),
    );
  }
}

class LoginScreen extends StatefulWidget {

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool hidePassword = true;
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();

  goToHomePage(context) async {
    var sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool('login', true);
    Navigator.of(context).pushNamed(HomeScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    double mainScreenWidth = MediaQuery.of(context).size.width;
    double mainScreenHeight = MediaQuery.of(context).size.height;

    double _currentWidth() {
      setState(() {
        mainScreenWidth = MediaQuery.of(context).size.width;
      });
      return mainScreenWidth;
    }

    double _currentHeight() {
      setState(() {
        mainScreenWidth = MediaQuery.of(context).size.height;
      });
      return mainScreenHeight;
    }

    return Scaffold(

      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.white,
        //padding: EdgeInsets.all(40),
        child: Stack(
          children: [
            Image.network(
              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTJsdh6pcZKlGgBJPGEzeuVbv7uDgddY5TVLA&usqp=CAU',
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover,
            ),
            Center(
              child: Container(
                width: 400,
                height: 340,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(35),
                ),
                child: Card(
                  elevation: 30,
                  color: Colors.deepPurple.withOpacity(0.3),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(35),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Column(
                      children: [
                        // username text Field
                        Padding(
                          padding: const EdgeInsets.all(15),
                          child: Container(
                            height: _currentHeight()*0.08,
                            width: _currentWidth()*0.6,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(35),
                            ),
                            child: TextField(
                              controller: username,
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.person,size: _currentHeight()*0.03),
                                hintText: 'Username',
                                hintStyle: TextStyle(fontSize: _currentHeight()*0.025),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(35),
                                ),
                              ),
                            ),
                          ),
                        ),

                        // password text Field
                        Padding(
                          padding: const EdgeInsets.all(15),
                          child: Container(
                            height: _currentHeight()*0.08,
                            width: _currentWidth()*0.6,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(35),
                            ),
                            child: TextField(
                              controller: password,
                              obscureText: hidePassword,
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.lock,size: _currentHeight()*0.035),
                                suffixIcon: IconButton(
                                  iconSize: _currentHeight()*0.035,
                                  onPressed: () {
                                    setState(() {
                                      hidePassword = !hidePassword;
                                    });
                                  },
                                  icon: hidePassword?Icon(Icons.remove_red_eye,color: Colors.deepPurple,):Icon(Icons.visibility_off,color: Colors.grey,),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(35),
                                ),
                                hintText: 'Password',
                                hintStyle: TextStyle(fontSize: _currentHeight()*0.025),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 15),
                          child: TextButton(
                            child: Text(
                              'Sign Up!',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: _currentHeight()*0.024
                              ),
                            ),
                            onPressed: () {
                              Navigator.of(context).pushNamed(SignUpScreen.routeName);
                            },
                          ),
                        ),
                        Container(
                          width: _currentWidth()*0.6,
                          height: _currentHeight()*0.08,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(35),
                          ),
                          child: ElevatedButton(
                            onPressed: () async{
                              password.text != ''&& username.text !=''
                                  ?goToHomePage(context)
                                  : Toast.show(
                                'Please enter correct username & password in fields',
                                context,
                                duration: 3,
                              );
                            },
                            child: Text('Login',style: TextStyle(color: Colors.deepPurple),),
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(Colors.white),
                            ),

                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }


}
