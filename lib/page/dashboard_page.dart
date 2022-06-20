import 'dart:convert';

import 'package:flutter/material.dart';

import '../widget/navigation_drawer_after_login.dart';
import 'package:http/http.dart' as http;


class DashboardPage extends StatefulWidget {

  String loginName;
  DashboardPage(this.loginName);

  @override
  _IndexPageState createState() => _IndexPageState();
}
class _IndexPageState extends State<DashboardPage> {
  get loginName => this.widget.loginName;


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyStatelessWidget(loginName: loginName),
    );
  }
}

class MyStatelessWidget extends StatelessWidget {
  final String loginName;
  const MyStatelessWidget({Key? key, required this.loginName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 1,
      length: 3,
      child: Scaffold(
        drawer: NavigationDrawerAfterLoginWidget(loginName),
        appBar: AppBar(
          title: const Text('Dashboard'),
          bottom: const TabBar(
            tabs: <Widget>[
              Tab(
                  child: Text('Prenotate', style: TextStyle(color: Colors.white, fontSize: 13),)
              ),
              Tab(
                  child: Text('Disdette', style: TextStyle(color: Colors.white, fontSize: 13),)
              ),
              Tab(
                  child: Text('Effettuate', style: TextStyle(color: Colors.white, fontSize: 13),)
              ),

            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            HomePageBooked(loginName),
            HomePageDeleted(loginName),
            HomePageDone(loginName),
          ],
        ),
      ),
    );
  }
}

class HomePageBooked extends StatefulWidget {
  final String loginName;
  HomePageBooked(this.loginName);

  @override
  _IndexPage2State createState() => _IndexPage2State(loginName);
}
class _IndexPage2State extends State<HomePageBooked> {
  final String loginName;
  List repetitions = [];
  List bookedRepetions = [];
  bool isLoading = false;

  _IndexPage2State(this.loginName);


  @override
  void initState() {
    super.initState();
    this.fetchRepetitionsByLoginName(this.widget.loginName);
  }
  fetchRepetitionsByLoginName(loginName) async {
    setState(() {
      isLoading = true;
      loginName = this.widget.loginName;
    });


    var url = "http://10.0.2.2:8080/backend-unito-extraprof/repetitions?";

    Map<String, String> qParams = {
      'user': loginName
    };

    Uri uri = Uri.parse(url);
    final finalUri = uri.replace(queryParameters: qParams);
    var response = await http.get(finalUri,  headers: {'Content-Type': 'application/json; charset=UTF-8',
      'Accept': "*/*",
      'connection': 'keep-alive',
      'Accept-Encoding' : 'gzip, deflate, br'});
    if(response.statusCode == 200){
      var items = jsonDecode(response.body);
      setState(() {
        repetitions = items;
        bookedRepetions = repetitions.where((val) => val["status"] == "P").toList();
      });
    }else{
      repetitions = [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getBody(),
    );
  }
  Widget getBody(){

    return ListView.builder(
        itemCount: bookedRepetions.length,
        itemBuilder: (context,index){
          return getCard(bookedRepetions[index]);
        });
  }
  Widget getCard(item){
    var courseName = item['courseName'];
    var hour = item['hour'];
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
                    child: Text(courseName),
                  )
                ],
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text("Orario lezione: " +hour),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class HomePageDeleted extends StatefulWidget {
  String loginName;
  HomePageDeleted(this.loginName);


  @override
  _IndexPage3State createState() => _IndexPage3State();
}
class _IndexPage3State extends State<HomePageDeleted> {

  List repetitions = [];
  List deletedRepetions = [];
  bool isLoading = false;


  @override
  void initState() {
    super.initState();
    this.fetchRepetitionsByLoginName(this.widget.loginName);
  }
  fetchRepetitionsByLoginName(loginName) async {
    setState(() {
      isLoading = true;
    });


    var url = "http://10.0.2.2:8080/backend-unito-extraprof/repetitions?";

    Map<String, String> qParams = {
      'user': loginName
    };

    Uri uri = Uri.parse(url);
    final finalUri = uri.replace(queryParameters: qParams);
    var response = await http.get(finalUri,  headers: {'Content-Type': 'application/json; charset=UTF-8',
      'Accept': "*/*",
      'connection': 'keep-alive',
      'Accept-Encoding' : 'gzip, deflate, br'});
    if(response.statusCode == 200){
      var items = jsonDecode(response.body);
      setState(() {
        repetitions = items;
        deletedRepetions = repetitions.where((val) => val["status"] == "D").toList();
      });
    }else{
      repetitions = [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getBody(),
    );
  }
  Widget getBody(){

    return ListView.builder(
        itemCount: deletedRepetions.length,
        itemBuilder: (context,index){
          return getCard(deletedRepetions[index]);
        });
  }
  Widget getCard(item){
    var courseName = item['courseName'];
    var hour = item['hour'];
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
                    child: Text(courseName),
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

class HomePageDone extends StatefulWidget {
  String loginName;
  HomePageDone(this.loginName);


  @override
  _IndexPage4State createState() => _IndexPage4State();
}
class _IndexPage4State extends State<HomePageDone> {

  List repetitions = [];
  List doneRepetions = [];
  bool isLoading = false;


  @override
  void initState() {
    super.initState();
    this.fetchRepetitionsByLoginName(this.widget.loginName);
  }
  fetchRepetitionsByLoginName(loginName) async {
    setState(() {
      isLoading = true;
    });


    var url = "http://10.0.2.2:8080/backend-unito-extraprof/repetitions?";

    Map<String, String> qParams = {
      'user': loginName
    };

    Uri uri = Uri.parse(url);
    final finalUri = uri.replace(queryParameters: qParams);
    var response = await http.get(finalUri,  headers: {'Content-Type': 'application/json; charset=UTF-8',
      'Accept': "*/*",
      'connection': 'keep-alive',
      'Accept-Encoding' : 'gzip, deflate, br'});
    if(response.statusCode == 200){
      var items = jsonDecode(response.body);
      setState(() {
        repetitions = items;
        doneRepetions = repetitions.where((val) => val["status"] == "E").toList();
      });
    }else{
      repetitions = [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getBody(),
    );
  }
  Widget getBody(){

    return ListView.builder(
        itemCount: doneRepetions.length,
        itemBuilder: (context,index){
          return getCard(doneRepetions[index]);
        });
  }
  Widget getCard(item){
    var courseName = item['courseName'];
    var hour = item['hour'];
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
                    child: Text(courseName),
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
