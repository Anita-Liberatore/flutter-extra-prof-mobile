import 'package:flutter/material.dart';

import '../widget/navigation_drawer_after_login.dart';


class BookingLessons extends StatefulWidget {
  String loginName;
  int courseId;
  BookingLessons(this.loginName, this.courseId);

@override
    _IndexPageState createState() => _IndexPageState();
}
class _IndexPageState extends State<BookingLessons> {
  get loginName => this.widget.loginName;
  get courseId => this.widget.courseId;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyStatelessWidget(loginName: loginName, courseId: courseId),
    );
  }
}

class MyStatelessWidget extends StatelessWidget {
  final String loginName;
  final int courseId;
  const MyStatelessWidget({Key? key, required this.loginName, required this.courseId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 1,
      length: 5,
      child: Scaffold(
        drawer: NavigationDrawerAfterLoginWidget(this.loginName),
        appBar: AppBar(
          title: const Text('Prenota una lezione'),
          bottom: const TabBar(
            tabs: <Widget>[
              Tab(
                  child: Text('Lunedì', style: TextStyle(color: Colors.white, fontSize: 11),)
              ),
              Tab(
                  child: Text('Martedì', style: TextStyle(color: Colors.white, fontSize: 11),)
              ),
              Tab(
                  child: Text('Mercoledì', style: TextStyle(color: Colors.white, fontSize: 11),)
              ),
              Tab(
                  child: Text('Giovedì', style: TextStyle(color: Colors.white, fontSize: 11),)
              ),
              Tab(
                  child: Text('Venerdì', style: TextStyle(color: Colors.white, fontSize: 11),)
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            HomePageL(loginName, courseId),
            HomePage(loginName),
            HomePage(loginName),
            HomePage(loginName),
            HomePage(loginName),
          ],
        ),
      ),
    );
  }
}

class HomePage extends StatefulWidget {

  final String loginName;

  HomePage(this.loginName);

  @override
  _IndexPage2State createState() => _IndexPage2State();
}
class _IndexPage2State extends State<HomePage> {

  List courses = [
    {"courseName": "ok"}
  ];



  @override
  void initState() {
    super.initState();
    //this.fetchCourse();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Prenota una lezione"),
      ),
      body: getBody(),
    );
  }
  Widget getBody(){

    return ListView.builder(
        itemCount: 1,
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

class HomePageL extends StatefulWidget {

  final String loginName;
  final int courseId;
  HomePageL(this.loginName, this.courseId);

  @override
  _IndexPage3State createState() => _IndexPage3State();
}
class _IndexPage3State extends State<HomePageL> {

  List courses = [
    {"courseName": "L"}
  ];



  @override
  void initState() {
    super.initState();
    //this.fetchCourse();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Prenota una lezione"),
      ),
      body: getBody(),
    );
  }
  Widget getBody(){

    return ListView.builder(
        itemCount: 1,
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
