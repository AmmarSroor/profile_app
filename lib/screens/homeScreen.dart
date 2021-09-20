import 'package:dio/dio.dart';
import 'dart:convert';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  static final String routeName = '/HomeScreen';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Dio dio = new Dio();
  int currentPageIndex = 0;

  List<Map<String ,dynamic>> bottomBarPages = [
    {'Profile':Container()},
    {'Edit Profile':Container()},
  ];

   Future getWeatherDataFromJson() async {
      var response = await dio.get('http://api.openweathermap.org/data/2.5/weather?q=London&appid=790990899abc52c30983c2e67600e9f9');
      if(response.statusCode == 200){
        var obj = json.decode(response.data);
        return obj;
      }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.deepPurple,
        accentColor: Colors.white,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text(bottomBarPages[currentPageIndex].keys.first),
        ),
        body:FutureBuilder(
          future: getWeatherDataFromJson(),
          builder: (context ,AsyncSnapshot snapshot){
            return snapshot.hasData
                ?ListView.builder(
                  itemCount: 1,
                  itemBuilder: (context ,index){
                    return ListTile(
                  title: Text('${snapshot.data['coord']['lat']}'),
                );
                  },
                )
                :Center(child: CircularProgressIndicator()
            );
          },
        ),
      ),
    );
  }
}
