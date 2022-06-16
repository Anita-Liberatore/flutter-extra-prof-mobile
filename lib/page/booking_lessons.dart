import 'package:flutter/material.dart';


class BookingLessons extends StatefulWidget {

@override
    _IndexPageState createState() => _IndexPageState();
}
class _IndexPageState extends State<BookingLessons> {



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
      length: 5,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Prenota una lezione'),
          bottom: const TabBar(
            tabs: <Widget>[
              Tab(
                  child: Text('Lunedì', style: TextStyle(color: Colors.white),)
              ),
              Tab(
                  child: Text('Martedì', style: TextStyle(color: Colors.white),)
              ),
              Tab(
                  child: Text('Mercoledì', style: TextStyle(color: Colors.white),)
              ),
              Tab(
                  child: Text('Giovedì', style: TextStyle(color: Colors.white),)
              ),
              Tab(
                  child: Text('Venerdì', style: TextStyle(color: Colors.white),)
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            HomePage(),
            HomePage(),
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
