import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';import '../model/Course.dart';
import '../service/CourseServiceApi.dart';

import '../widget/course_list_card_widget.dart';
import '../widget/navigation_drawer_widget.dart';
import 'lesson_course_page.dart';

final CourseServiceApi api = CourseServiceApi();

class LessonsPage extends StatelessWidget {

  List<Course> courses = api.getCourses();


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        drawer: NavigationDrawerWidget(),
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(50, 75, 205, 1),
          centerTitle: true,
          title: Text("Scegli un corso"),
        ),
        body: Container(
          child: Column(
         children: [
          Padding(
          padding: const EdgeInsets.only(top: 10, bottom: 10),
          child: Text('Seleziona un corso:',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black, fontSize: 25)
          ),
        ),
          Expanded(
            child: ListView.builder(
              itemCount: courses.length,
              itemBuilder: (BuildContext ctx, int index) {
                return CourseListCardWidget(
                    course: courses[index],
                    onCardClick: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const LessonCoursePage(),
                      ));
                    }
                );
              },
        ),
      ),
    ])
    )));

  }
}



