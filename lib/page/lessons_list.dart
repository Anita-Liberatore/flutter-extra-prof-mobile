import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../widget/navigation_drawer_widget.dart';

class LessonsList extends StatefulWidget {
  @override
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<LessonsList> {
  List courses = [];
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    this.fetchCourse();
  }
  fetchCourse() async {
    setState(() {
      isLoading = true;
    });
    var url = "http://10.0.2.2:8080/backend-unito-extraprof/courses";
    var response = await http.get(Uri.parse(url),  headers: {'Content-Type': 'application/json; charset=UTF-8',
      'Accept': "*/*",
      'connection': 'keep-alive',
      'Accept-Encoding' : 'gzip, deflate, br'});
    if(response.statusCode == 200){
      var items = jsonDecode(response.body);
      setState(() {
        courses = items;
      });
    }else{
      courses = [];
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigationDrawerWidget(),
      appBar: AppBar(
        title: Text("Lista dei nostri corsi disponibili"),
      ),
      body: getBody(),
    );
  }
  Widget getBody(){

    return ListView.builder(
        itemCount: courses.length,
        itemBuilder: (context,index){
          return getCard(courses[index]);
        });
  }
  Widget getCard(item){
    var courseName = item['courseName'];
    return Card(
      elevation: 1.5,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListTile(
          title: Row(
            children: <Widget>[
              SizedBox(width: 20,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  new GestureDetector(
                    onTap: () {

                    },
                    child: new Text(courseName),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}