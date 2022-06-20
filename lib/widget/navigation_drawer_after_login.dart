import 'package:extraprof/main.dart';
import 'package:flutter/material.dart';

import '../page/dashboard_page.dart';
import '../page/lessons_list.dart';
import '../page/lessons_page.dart';

import '../page/login_page.dart';

class NavigationDrawerAfterLoginWidget extends StatelessWidget {
  final padding = EdgeInsets.symmetric(horizontal: 20);

  String loginName;
  NavigationDrawerAfterLoginWidget(this.loginName);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Material(
        color: Color.fromRGBO(50, 75, 205, 1),
        child: ListView(
          children: <Widget>[
            Container(
              padding: padding,
              child: Column(
                children: [
                  const SizedBox(height: 24),
                  buildMenuItem(
                    text: 'Dashboard',
                    icon: Icons.dashboard,
                    onClicked: () => selectedItem(context, 0),
                  ),
                  const SizedBox(height: 24),
                  buildMenuItem(
                    text: 'Prenota Lezioni',
                    icon: Icons.date_range_rounded,
                    onClicked: () => selectedItem(context, 1),
                  ),
                  const SizedBox(height: 16),
                  buildMenuItem(
                    text: 'Logout',
                    icon: Icons.recent_actors_outlined ,
                    onClicked: () => selectedItem(context, 2),
                  ),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }


  Widget buildMenuItem({
    required String text,
    required IconData icon,
    VoidCallback? onClicked,
  }) {
    final color = Colors.white;
    final hoverColor = Colors.white70;

    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(text, style: TextStyle(color: color)),
      hoverColor: hoverColor,
      onTap: onClicked,
    );
  }


  void selectedItem(BuildContext context, int index) {
    Navigator.of(context).pop();

    switch (index) {
      case 0:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => DashboardPage(loginName),
        ));
        break;

      case 1:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => LessonsPage(loginName),
        ));
        break;

      case 2:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => MyHomePage(title: "Entra in app"),
        ));
        break;

       
    }
  }
}