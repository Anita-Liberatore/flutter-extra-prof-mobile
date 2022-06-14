import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../model/Course.dart';

class CourseListCardWidget extends StatelessWidget {
  Course? course;
  Function? onCardClick;

  CourseListCardWidget({ this.course, this.onCardClick });

  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        this.onCardClick!();
      },
      child: Container(
        child: Card(
          child: SizedBox(
            width: 300,
            height: 100,
            child: Center(child: Text(this.course!.title!, style: TextStyle(color: Colors.black, fontSize: 20))),
          ),
        ),
      ),
    );
  }
}