import 'package:flutter/material.dart';
import 'pageskeleton.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Student Vue',
      theme: ThemeData.light(),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Log in', style: TextStyle(fontSize: 40, color: Colors.black)),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 80.0),
              child: TextField(
                cursorWidth: 2,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 80.0),
              child: TextField(
                cursorWidth: 2,
              ),
            ),
            SizedBox(height: 40),
            FlatButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PageWithNav(),
                  ),
                );
              },
              child: Text(
                'go',
                style: TextStyle(color: Colors.white),
              ),
              color: Colors.deepPurple,
            )
          ],
        ),
      ),
    );
  }
}
