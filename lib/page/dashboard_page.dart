import 'package:flutter/material.dart';

import '../widget/navigation_drawer_after_login.dart';


class DashboardPage extends StatefulWidget {

  @override
  _IndexPageState createState() => _IndexPageState();
}
class _IndexPageState extends State<DashboardPage> {



  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyStatelessWidget(),
    );
  }
}

class MyStatelessWidget extends StatelessWidget {
  const MyStatelessWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 1,
      length: 3,
      child: Scaffold(
        drawer: NavigationDrawerAfterLoginWidget(),
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
            HomePage(),
            HomePage(),
            HomePage(),
          ],
        ),
      ),
    );
  }
}

class HomePage extends StatefulWidget {

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
