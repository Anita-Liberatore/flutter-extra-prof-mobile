import 'dart:convert';

import 'package:extraprof/page/booking_lessons.dart';
import 'package:extraprof/widget/navigation_drawer_after_login.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LessonsPage extends StatefulWidget {
  final String loginName;
  LessonsPage(this.loginName);

  @override
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<LessonsPage> {
  List courses = [];
  bool isLoading = false;

  get loginName => this.widget.loginName;
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
      drawer: NavigationDrawerAfterLoginWidget(loginName),
      appBar: AppBar(
        title: Text("Seleziona un corso"),
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
    var courseId = item['id'];
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
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => BookingLessons(loginName, courseId),
                      ));
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