import 'package:extraprof/model/Course.dart';
import 'package:http/http.dart' as http;

class CourseServiceApi {
  final String apiUrl = "http://192.168.0.7:3000/api";



  List<Course> getCourses() {
    //Response res = await get(apiUrl);

    /* if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body); */
    Course courseOne = Course(title: 'Prova Uno');
    Course courseTwo = Course(title: 'Prova Due');
    List<Course> cases = [];
    cases.add(courseOne);
    cases.add(courseTwo);
    return cases;

  }
}
