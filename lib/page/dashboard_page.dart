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
  var items = [];

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
       items = jsonDecode(response.body);
      setState(() {
        repetitions = items;
        bookedRepetions = repetitions.where((val) => val["status"] == "P").toList();
      });
    }else{
      repetitions = [];
    }
  }

  void _removeItem(int id) async {
      repetitions = items;
      //bookedRepetions.removeWhere((element) => element['id'] == id);
      var url = "http://10.0.2.2:8080/backend-unito-extraprof/repetitions-delete?";

      Map<String, String> qParams = {
        'id': id.toString()
      };

      Uri uri = Uri.parse(url);
      final finalUri = uri.replace(queryParameters: qParams);
      var response = await http.post(
        finalUri, headers: {'Content-Type': 'application/json; charset=UTF-8',
        'Accept': "*/*",
        'connection': 'keep-alive',
        'Accept-Encoding': 'gzip, deflate, br'},

        body: jsonEncode(<String, String>{
          'status': "D",
        }),
      );
      this.fetchRepetitionsByLoginName(loginName);
  }

  void _doneItem(int id) async {
    repetitions = items;
    //bookedRepetions.removeWhere((element) => element['id'] == id);
    var url = "http://10.0.2.2:8080/backend-unito-extraprof/repetitions-delete?";

    Map<String, String> qParams = {
      'id': id.toString()
    };

    Uri uri = Uri.parse(url);
    final finalUri = uri.replace(queryParameters: qParams);
    var response = await http.post(
      finalUri, headers: {'Content-Type': 'application/json; charset=UTF-8',
      'Accept': "*/*",
      'connection': 'keep-alive',
      'Accept-Encoding': 'gzip, deflate, br'},

      body: jsonEncode(<String, String>{
        'status': "E",
      }),
    );
    this.fetchRepetitionsByLoginName(loginName);
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
    var id = item['id'];
    var nameProfessor = item['nameProfessor'];
    var surnameProfessor = item['surnameProfessor'];
    var day = item['day'] == 'L' ? 'Lunedì' : item['day'] == 'M' ? 'Martedì' : item['day'] == 'ME' ? 'Mercoledì' : item['day'] == 'G' ? 'Giovedì' : item['day'] == 'V' ? 'Venerdì' : '' ;


    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15.0))),
      elevation: 2,
      margin: EdgeInsets.all(12.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
          child: ExpansionTile(
              controlAffinity: ListTileControlAffinity.leading,
              childrenPadding:
              const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              expandedCrossAxisAlignment: CrossAxisAlignment.start,
              maintainState: true,
              title: Text(courseName + " - " + "Orario lezione: "+hour),
              // contents
              children: [
              Text("Nome docente: " +nameProfessor + " " +surnameProfessor), Text("Giorno lezione: " +day),
              // This button is used to remove this item
              TextButton.icon(
              onPressed: () => _removeItem(id),
              icon: const Icon(Icons.delete),
              label: const Text(
              'Disdici',

              ),

              style: TextButton.styleFrom(primary: Colors.red),
              ),
                TextButton.icon(
                  onPressed: () => _doneItem(id),
                  icon: const Icon(Icons.done),
                  label: const Text(
                    'Effettuata',

                  ),

                  style: TextButton.styleFrom(primary: Colors.green),
                )
          ],
      )
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
    var nameProfessor = item['nameProfessor'];
    var surnameProfessor = item['surnameProfessor'];
    var day = item['day'] == 'L' ? 'Lunedì' : item['day'] == 'M' ? 'Martedì' : item['day'] == 'ME' ? 'Mercoledì' : item['day'] == 'G' ? 'Giovedì' : item['day'] == 'V' ? 'Venerdì' : '' ;

    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15.0))),
      elevation: 2,
      margin: EdgeInsets.all(12.0),
      child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ExpansionTile(
            controlAffinity: ListTileControlAffinity.leading,
            childrenPadding:
            const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            expandedCrossAxisAlignment: CrossAxisAlignment.start,
            maintainState: true,
            title: Text(courseName + " - " + "Orario lezione: "+hour),
            // contents
            children: [
              Text("Nome docente: " +nameProfessor + " " +surnameProfessor),
              Text("Orario lezione : " +day),
              // This button is used to remove this item

            ],
          )
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
    var nameProfessor = item['nameProfessor'];
    var surnameProfessor = item['surnameProfessor'];
    var day = item['day'] == 'L' ? 'Lunedì' : item['day'] == 'M' ? 'Martedì' : item['day'] == 'ME' ? 'Mercoledì' : item['day'] == 'G' ? 'Giovedì' : item['day'] == 'V' ? 'Venerdì' : '' ;

    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15.0))),
      elevation: 2,
      margin: EdgeInsets.all(12.0),
      child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ExpansionTile(
            controlAffinity: ListTileControlAffinity.leading,
            childrenPadding:
            const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            expandedCrossAxisAlignment: CrossAxisAlignment.start,
            maintainState: true,
            title: Text(courseName + " - " + "Orario lezione: "+hour),
            // contents
            children: [
              Text("Nome docente: " +nameProfessor + " " +surnameProfessor),
              Text("Orario lezione: " +day),
              // This button is used to remove this item

            ],
          )
      ),
    );
  }
}
