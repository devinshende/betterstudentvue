import 'package:flutter/material.dart';

class ReportCardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
          // child: Text('report card: A+'),
          child: Stack(
        children: [
          Image.network(
              'https://images.unsplash.com/photo-1592553329023-7126c7e43c32?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1234&q=80'),
          Positioned(
            top: 70,
            child: Text(
              'Bouldering',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                  backgroundColor: Colors.deepPurpleAccent),
            ),
          ),
          Positioned(
            top: 50,
            child: Text(
              'Fontainebleau',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                  backgroundColor: Colors.yellow),
            ),
          ),
        ],
      )),
    );
  }
}
