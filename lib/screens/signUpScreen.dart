import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'homeScreen.dart';

class SignUpScreen extends StatefulWidget {
  static final String routeName = '/SignUpScreen';

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  String url = 'https://itg-registration-app-default-rtdb.firebaseio.com/data.json';
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController userName = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  bool hidePassword = true;

  XFile? imageFile;

  _uploadImage(BuildContext context ,ImageSource imageSource)async{
    var picture = await ImagePicker().pickImage(source: imageSource);
    setState(() {
      imageFile = picture!;
    });
    Navigator.of(context).pop();
  }

  Future<void> _showMyDialog(BuildContext context){
    return showDialog(context: context, builder: (BuildContext context){
      return AlertDialog(
        title: Text('Upload Image'),
        actions: [
          ListTile(
            title: Text('From Gallery'),
            onTap: (){
              _uploadImage(context,ImageSource.gallery);
            },
          ),
          ListTile(
            title: Text('From Camera'),
            onTap: (){
              _uploadImage(context ,ImageSource.camera);
            },
          ),
        ],
        scrollable: true,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    late double screenWidth;
    late double screenHeight;

    double currentWidth() {
      setState(() {
        screenWidth = MediaQuery.of(context).size.width;
      });
      return screenWidth;
    }

    double currentHeight() {
      setState(() {
        screenHeight = MediaQuery.of(context).size.height;
      });
      return screenHeight;
    }

    return Scaffold(
      body: Center(
        child: Container(
          width: currentWidth(),
          height: currentHeight(),
          child: Stack(
            children: [
              Image.network(
                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTJsdh6pcZKlGgBJPGEzeuVbv7uDgddY5TVLA&usqp=CAU',
                width: double.infinity,
                height: double.infinity,
                fit: BoxFit.cover,
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.deepPurple.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(35),
                  ),
                  child: ListView(
                    children: <Widget>[
                      SizedBox(height: 20,),
                      // first and last name
                      buildTextAndTextFieldInRow([
                        buildTextField(
                            widthSize: currentWidth() * 0.4,
                            maxLength: 8,
                            keyboardType: TextInputType.text,
                            title: 'First Name',
                            hint: 'First Name',
                            myController: firstName,
                            isSecure: false,
                            pressFunction: null),
                        buildTextField(
                            widthSize: currentWidth() * 0.4,
                            keyboardType: TextInputType.text,
                            maxLength: 8,
                            title: 'Last Name',
                            hint: 'Last Name',
                            myController: lastName,
                            isSecure: false,
                            pressFunction: null),
                      ]),
                      SizedBox(
                        height: currentHeight() * 0.025,
                      ),



                      // phone
                      buildTextAndTextFieldInRow([
                        buildTextField(
                            widthSize: currentWidth() * 0.6,
                            keyboardType: TextInputType.number,
                            maxLength: 20,
                            title: 'Phone',
                            hint: '07********',
                            myController: phone,
                            isSecure: false,
                            pressFunction: null)
                      ]),
                      SizedBox(
                        height: currentHeight() * 0.025,
                      ),


                      // email
                      buildTextAndTextFieldInRow([
                        buildTextField(
                            widthSize: currentWidth() * 0.6,
                            maxLength: 20,
                            title: 'Email',
                            hint: 'a********@gmail.com',
                            keyboardType: TextInputType.emailAddress,
                            myController: email,
                            isSecure: false,
                            pressFunction: null)
                      ]),
                      SizedBox(
                        height: currentHeight() * 0.025,
                      ),

                      // password
                      buildTextAndTextFieldInRow(
                        [
                          buildTextField(
                              widthSize: currentWidth() * 0.6,
                              maxLength: 12,
                              iconButton: IconButton(
                                iconSize: currentHeight() * 0.035,
                                onPressed: () {
                                  setState(() {
                                    hidePassword = !hidePassword;
                                  });
                                },
                                icon: hidePassword
                                    ? Icon(
                                  Icons.remove_red_eye,
                                  color: Colors.white,
                                )
                                    : Icon(
                                  Icons.visibility_off,
                                  color: Colors.grey,
                                ),
                              ),
                              title: 'Password',
                              hint: 'Password',
                              keyboardType: TextInputType.visiblePassword,
                              myController: password,
                              isSecure: hidePassword,
                              pressFunction: null)
                        ],
                      ),

                      SizedBox(
                        height: currentHeight() * 0.025,
                      ),

                      // confirm password
                      buildTextAndTextFieldInRow(
                        [
                          buildTextField(
                              widthSize: currentWidth() * 0.6,
                              maxLength: 12,
                              keyboardType: TextInputType.visiblePassword,
                              iconButton: IconButton(
                                iconSize: currentHeight() * 0.035,
                                onPressed: () {
                                  setState(() {
                                    hidePassword = !hidePassword;
                                  });
                                },
                                icon: hidePassword
                                    ? Icon(
                                  Icons.remove_red_eye,
                                  color: Colors.white,
                                )
                                    : Icon(
                                  Icons.visibility_off,
                                  color: Colors.grey,
                                ),
                              ),
                              title: 'Confirm',
                              hint: 'Confirm Password',
                              myController: confirmPassword,
                              isSecure: hidePassword,
                              pressFunction: null)
                        ],
                      ),
                      SizedBox(
                        height: currentHeight() * 0.025,
                      ),
                      // upload Image
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ElevatedButton(
                            onPressed: (){
                              _showMyDialog(context);
                            },
                            child: Text('Upload Image',style: TextStyle(color: Colors.white),),
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(Colors.deepPurple),
                            ),

                          ),
                          Container(
                            width: 200,
                            height: 200,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.white,
                              ),
                            ),
                            child: imageFile == null
                                ?Center(child: Text('No Image Selected!',style: TextStyle(color: Colors.white),))
                                :Image.file(
                              File(imageFile!.path),
                              width: 50, height: 80,
                              errorBuilder: (BuildContext context,Object error,StackTrace? stackTrace,){
                                return Icon(Icons.image,size: 45,);
                              },
                            ),
                          ),
                        ],
                      ),

                      SizedBox(
                        height: currentHeight() * 0.025,
                      ),
                      // sign in button
                      Container(
                        width: currentWidth()*0.8,
                        height: currentHeight()*0.08,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(35),
                        ),
                        child: ElevatedButton(
                          onPressed: (){
                            Dio dio = Dio();
                            dio.post(url,data: json.encode({
                              'username':userName.text,
                              'password':password.text,
                              'phone':phone.text,
                              'email':email.text,
                              'imageUrl':imageFile,
                            }));
                            Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
                          },
                          child: Text('Sign In',style: TextStyle(color: Colors.white),),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(Colors.deepPurple),
                          ),

                        ),
                      ),


                      //radio
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Row buildTextAndTextFieldInRow(List<Widget> myChildren) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: myChildren,
    );
  }

  Container buildTextField({
    required TextEditingController myController,
    required String hint,
    required String title,
    required double widthSize,
    required TextInputType keyboardType,
    IconButton? iconButton,
    int? maxLength,
    required bool isSecure,
    required VoidCallback? pressFunction,
  }) {
    return Container(
      width: widthSize,
      child: TextField(
        maxLength: maxLength,
        keyboardType: keyboardType,
        obscureText: isSecure,
        onTap: pressFunction,
        controller: myController,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
            labelStyle: TextStyle(color: Colors.white),
            hintStyle: TextStyle(color: Colors.white),
            suffixIcon: iconButton,
            labelText: title,
            hintText: hint,
            border: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.white,
                width: 3,
              ),
              borderRadius: BorderRadius.circular(15),
            )),
      ),
    );
  }
}
