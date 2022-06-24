import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import '../widget/navigation_drawer_widget.dart';




class LessonsNoBooking extends StatefulWidget {
  String loginName;
  int courseId;
  int idProfessor;
  String hour;
  LessonsNoBooking(this.loginName, this.courseId, this.idProfessor, this.hour);

  @override
  _IndexPageState createState() => _IndexPageState();
}
class _IndexPageState extends State<LessonsNoBooking> {
  get loginName => this.widget.loginName;
  get courseId => this.widget.courseId;
  get idProfessor => this.widget.idProfessor;
  get hour => this.widget.hour;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyStatelessWidget(loginName: loginName, courseId: courseId, idProfessor: idProfessor,hour: hour),
    );
  }
}

class MyStatelessWidget extends StatelessWidget {
  final String loginName;
  final int courseId;
  final int idProfessor;
  final String hour;
  const MyStatelessWidget({Key? key, required this.loginName, required this.courseId, required this.idProfessor, required this.hour}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 1,
      length: 5,
      child: Scaffold(
        drawer: NavigationDrawerWidget(),
        appBar: AppBar(
          title: const Text('Per prenotare effettua il login!'),
          bottom: const TabBar(
            tabs: <Widget>[
              Tab(
                  child: Text('Lunedì', style: TextStyle(color: Colors.white, fontSize: 10),)
              ),
              Tab(
                  child: Text('Martedì', style: TextStyle(color: Colors.white, fontSize: 10),)
              ),
              Tab(
                  child: Text('Mercoledì', style: TextStyle(color: Colors.white, fontSize: 10),)
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
            HomePageL(loginName, courseId, idProfessor, hour),
            HomePageM(loginName, courseId, idProfessor, hour),
            HomePageME(loginName, courseId, idProfessor, hour),
            HomePageG(loginName, courseId, idProfessor, hour),
            HomePageV(loginName, courseId, idProfessor, hour),
          ],
        ),
      ),
    );
  }
}


class HomePageL extends StatefulWidget {

  final String loginName;
  final int courseId;
  final int idProfessor;
  final String hour;
  HomePageL(this.loginName, this.courseId, this.idProfessor, this.hour);

  @override
  _IndexPage3State createState() => _IndexPage3State(courseId, idProfessor, loginName, hour);
}
class _IndexPage3State extends State<HomePageL> {
  int courseId;
  String loginName;
  int idProfessor;
  String hour;
  List repetitionsLessons = [];
  bool isLoading = false;
  List repetitionsByHour = [];

  _IndexPage3State(this.courseId, this.idProfessor, this.loginName, this.hour);


  fetchRepetitionsByDayAndCourseId(courseId) async {
    setState(() {
      isLoading = true;
    });


    var url = "http://10.0.2.2:8080/backend-unito-extraprof/professors-course-mobile?";

    Map<String, String> qParams = {
      'id': courseId.toString(),
      'day': 'L'
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
        repetitionsLessons = items;
      });
    }else{
      repetitionsLessons = [];
    }
  }

  @override
  void initState() {
    super.initState();
    this.fetchRepetitionsByDayAndCourseId(this.widget.courseId);

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
        itemCount: repetitionsLessons.length,
        itemBuilder: (context,index){
          return getCard(repetitionsLessons[index]);
        });
  }
  Widget getCard(item){
    final ButtonStyle style =
    ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 15));
    var nameProfessor = item['nameProfessor'];
    var hour = item['hour'];
    var idProfessor = item['id'];
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
                  new Text(nameProfessor + " - Orario: " +hour),
                  const SizedBox(height: 25),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class HomePageM extends StatefulWidget {

  final String loginName;
  final int courseId;
  final int idProfessor;
  final String hour;
  HomePageM(this.loginName, this.courseId, this.idProfessor, this.hour);

  @override
  _IndexPage4State createState() => _IndexPage4State(courseId, idProfessor, loginName, hour);
}
class _IndexPage4State extends State<HomePageM> {
  int courseId;
  String loginName;
  int idProfessor;
  String hour;
  List repetitionsLessons = [];
  bool isLoading = false;
  List repetitionsByHour = [];

  _IndexPage4State(this.courseId, this.idProfessor, this.loginName, this.hour);


  fetchRepetitionsByDayAndCourseId(courseId) async {
    setState(() {
      isLoading = true;
    });


    var url = "http://10.0.2.2:8080/backend-unito-extraprof/professors-course-mobile?";

    Map<String, String> qParams = {
      'id': courseId.toString(),
      'day': 'M'
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
        repetitionsLessons = items;
      });
    }else{
      repetitionsLessons = [];
    }
  }

  @override
  void initState() {
    super.initState();
    this.fetchRepetitionsByDayAndCourseId(this.widget.courseId);

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
        itemCount: repetitionsLessons.length,
        itemBuilder: (context,index){
          return getCard(repetitionsLessons[index]);
        });
  }
  Widget getCard(item){
    final ButtonStyle style =
    ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 15));
    var nameProfessor = item['nameProfessor'];
    var hour = item['hour'];
    var idProfessor = item['id'];
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
                  new Text(nameProfessor + " - Orario: " +hour),
                  const SizedBox(height: 25),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class HomePageME extends StatefulWidget {

  final String loginName;
  final int courseId;
  final int idProfessor;
  final String hour;
  HomePageME(this.loginName, this.courseId, this.idProfessor, this.hour);

  @override
  _IndexPage5State createState() => _IndexPage5State(courseId, idProfessor, loginName, hour);
}
class _IndexPage5State extends State<HomePageME> {
  int courseId;
  String loginName;
  int idProfessor;
  String hour;
  List repetitionsLessons = [];
  bool isLoading = false;
  List repetitionsByHour = [];

  _IndexPage5State(this.courseId, this.idProfessor, this.loginName, this.hour);


  fetchRepetitionsByDayAndCourseId(courseId) async {
    setState(() {
      isLoading = true;
    });


    var url = "http://10.0.2.2:8080/backend-unito-extraprof/professors-course-mobile?";

    Map<String, String> qParams = {
      'id': courseId.toString(),
      'day': 'ME'
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
        repetitionsLessons = items;
      });
    }else{
      repetitionsLessons = [];
    }
  }

  @override
  void initState() {
    super.initState();
    this.fetchRepetitionsByDayAndCourseId(this.widget.courseId);

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
        itemCount: repetitionsLessons.length,
        itemBuilder: (context,index){
          return getCard(repetitionsLessons[index]);
        });
  }
  Widget getCard(item){
    final ButtonStyle style =
    ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 15));
    var nameProfessor = item['nameProfessor'];
    var hour = item['hour'];
    var idProfessor = item['id'];
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
                  new Text(nameProfessor + " - Orario: " +hour),
                  const SizedBox(height: 25),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class HomePageG extends StatefulWidget {

  final String loginName;
  final int courseId;
  final int idProfessor;
  final String hour;
  HomePageG(this.loginName, this.courseId, this.idProfessor, this.hour);

  @override
  _IndexPage6State createState() => _IndexPage6State(courseId, idProfessor, loginName, hour);
}
class _IndexPage6State extends State<HomePageG> {
  int courseId;
  String loginName;
  int idProfessor;
  String hour;
  List repetitionsLessons = [];
  bool isLoading = false;
  List repetitionsByHour = [];

  _IndexPage6State(this.courseId, this.idProfessor, this.loginName, this.hour);


  fetchRepetitionsByDayAndCourseId(courseId) async {
    setState(() {
      isLoading = true;
    });


    var url = "http://10.0.2.2:8080/backend-unito-extraprof/professors-course-mobile?";

    Map<String, String> qParams = {
      'id': courseId.toString(),
      'day': 'G'
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
        repetitionsLessons = items;
      });
    }else{
      repetitionsLessons = [];
    }
  }

  @override
  void initState() {
    super.initState();
    this.fetchRepetitionsByDayAndCourseId(this.widget.courseId);

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
        itemCount: repetitionsLessons.length,
        itemBuilder: (context,index){
          return getCard(repetitionsLessons[index]);
        });
  }
  Widget getCard(item){
    final ButtonStyle style =
    ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 15));
    var nameProfessor = item['nameProfessor'];
    var hour = item['hour'];
    var idProfessor = item['id'];
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
                  new Text(nameProfessor + " - Orario: " +hour),
                  const SizedBox(height: 25),

                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class HomePageV extends StatefulWidget {

  final String loginName;
  final int courseId;
  final int idProfessor;
  final String hour;
  HomePageV(this.loginName, this.courseId, this.idProfessor, this.hour);

  @override
  _IndexPage7State createState() => _IndexPage7State(courseId, idProfessor, loginName, hour);
}
class _IndexPage7State extends State<HomePageV> {
  int courseId;
  String loginName;
  int idProfessor;
  String hour;
  List repetitionsLessons = [];
  bool isLoading = false;
  List repetitionsByHour = [];

  _IndexPage7State(this.courseId, this.idProfessor, this.loginName, this.hour);


  fetchRepetitionsByDayAndCourseId(courseId) async {
    setState(() {
      isLoading = true;
    });


    var url = "http://10.0.2.2:8080/backend-unito-extraprof/professors-course-mobile?";

    Map<String, String> qParams = {
      'id': courseId.toString(),
      'day': 'V'
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
        repetitionsLessons = items;
      });
    }else{
      repetitionsLessons = [];
    }
  }

  @override
  void initState() {
    super.initState();
    this.fetchRepetitionsByDayAndCourseId(this.widget.courseId);

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
        itemCount: repetitionsLessons.length,
        itemBuilder: (context,index){
          return getCard(repetitionsLessons[index]);
        });
  }
  Widget getCard(item){
    final ButtonStyle style =
    ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 15));
    var nameProfessor = item['nameProfessor'];
    var hour = item['hour'];
    var idProfessor = item['id'];
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
                  new Text(nameProfessor + " - Orario: " +hour),
                  const SizedBox(height: 25),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

