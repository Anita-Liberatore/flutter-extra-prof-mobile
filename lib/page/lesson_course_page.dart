import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../model/Course.dart';
import '../widget/navigation_drawer_widget.dart';


class LessonCoursePage extends StatelessWidget {

  const LessonCoursePage({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      home: Scaffold(
        drawer: NavigationDrawerWidget(),
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(50, 75, 205, 1),
          centerTitle: true,
          title: Text("Prenota lezione"),
        ),
        body: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            // Step 4 <-- SEE HERE
            Text(
              'course.title',
              style: TextStyle(fontSize: 25),
            ),

          ],
        ),
      ),
    );
  }
}