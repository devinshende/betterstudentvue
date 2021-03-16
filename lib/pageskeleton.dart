import 'dart:ui';
import 'package:flutter/material.dart';

import 'pages/attendance.dart';
import 'pages/grades.dart';
import 'pages/messages.dart';
import 'pages/reportcard.dart';
import 'pages/schedule.dart';

Map pages = {
  'Messages': [Icons.message, MessagesPage()],
  'Grades': [Icons.grade, GradesPage()],
  'Schedule': [Icons.calendar_view_day, SchedulePage()],
  'Attendance': [Icons.person, AttendancePage()],
  'Report Card': [Icons.report, ReportCardPage()],
};

class PageWithNav extends StatefulWidget {
  PageWithNav();
  Widget body = MessagesPage();
  String currentPage = 'Messages';
  static const navbarColor = Colors.deepPurple;

  @override
  _PageWithNavState createState() => _PageWithNavState();
}

class _PageWithNavState extends State<PageWithNav> {
  void changeBodyWidget(replacementWidget, cP) {
    setState(() {
      widget.body = replacementWidget;
      widget.currentPage = cP;
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Padding(
          padding: const EdgeInsets.only(bottom: 18.0),
          child: Text(
            widget.currentPage,
            style: TextStyle(
              fontSize: 26,
              // fontWeight: FontWeight.bold,
              // color: Colors.black,
            ),
          ),
        ),
        backgroundColor: Colors.deepPurpleAccent,
      ),
      drawerEnableOpenDragGesture: true,
      drawer: Container(
        width: size.width * 0.25,
        child: Drawer(
          elevation: 5,
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                end: Alignment.topCenter,
                colors: [Colors.deepPurple, Colors.deepPurpleAccent],
              ),
            ),
            child: NavItems(changeBodyWidget, widget.currentPage),
          ),
        ),
      ),
      body: widget.body,
    );
  }
}

class NavItems extends StatefulWidget {
  NavItems(this.changeBodyWidgetCallback, this.currentPage);
  Function changeBodyWidgetCallback;
  String currentPage;
  @override
  _NavItemsState createState() => _NavItemsState();
}

class _NavItemsState extends State<NavItems> {
  List<Widget> generateNavOptions(Map pages) {
    List<Widget> result = [];
    for (var name in pages.keys) {
      result.add(
        NavOption(
          pages[name][0],
          name,
          selected: widget.currentPage == name ? true : false,
          onTap: () {
            setState(() {
              widget.currentPage = name;
            });
            widget.changeBodyWidgetCallback(pages[name][1], widget.currentPage);
          },
        ),
      );
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: generateNavOptions(pages));
  }
}

class NavOption extends StatelessWidget {
  NavOption(this.icon, this.text, {this.selected = false, this.onTap});
  IconData icon;
  String text;
  bool selected;
  Function onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Icon(
            icon,
            size: selected ? 50 : 40,
            color: selected ? Colors.white : Colors.white30,
          ),
          SizedBox(height: 2),
          Text(
            text,
            style: TextStyle(
              fontSize: 14,
              fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
              color: selected ? Colors.white : Colors.white54,
            ),
          )
        ],
      ),
    );
  }
}
