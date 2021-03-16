import 'package:flutter/material.dart';
import 'package:betterstudentvue/readjson.dart';

int limit(number, max) {
  if (number > max)
    return max;
  else
    return number;
}

const myGray = Color(0xaaaaaaa);
const double assignmentHeight = 40;
// Future data => parseJson('grades.json');
// String gradesData = await readJson('grades.json');

List classesList = [
  {
    'name': 'AP Chemistry',
    'grade': 'A+',
    'percentage': 100,
    'assignments': [
      {'name': 'Stoichiometry practice', 'grade': 100},
      {'name': 'Molar mass conversions', 'grade': 98},
      {'name': 'Quest 3', 'grade': 98.7},
      {'name': 'Quest 2', 'grade': 97.0},
      {'name': 'Quest 1', 'grade': 96.7},
      {'name': 'Molar mass conversions', 'grade': 98},
      {'name': 'Molar mass conversions', 'grade': 98},
      {'name': 'Molar mass conversions', 'grade': 98},
    ]
  },
  {
    'name': 'Physics',
    'grade': 'A-',
    'percentage': 90,
    'assignments': [
      {'name': 'Coulombs law practice', 'grade': 40},
      {'name': 'Coulombs law practice', 'grade': 40},
      {'name': 'Coulombs law practice', 'grade': 40},
    ]
  },
  {
    'name': 'World',
    'grade': 'A',
    'percentage': 95,
    'assignments': [
      {'name': 'Stoich practice', 'grade': 100},
      {'name': 'Quest 3', 'grade': 98.7},
      {'name': 'Quest 3', 'grade': 98.7},
    ]
  },
  {
    'name': 'Psychology',
    'grade': 'B',
    'percentage': 86,
    'assignments': [
      {'name': 'Vsauce quiz', 'grade': 100},
      {'name': 'Trolley problem reading', 'grade': 80},
      {'name': 'Conformity documentary', 'grade': 95},
      {'name': 'Conformity documentary', 'grade': 95},
    ]
  },
  {
    'name': 'Spanish',
    'grade': 'A',
    'percentage': 96,
    'assignments': [
      {'name': 'Stoich practice', 'grade': 100},
      {'name': 'Conformity documentary', 'grade': 95},
      {'name': 'Conformity documentary', 'grade': 95},
      {'name': 'Conformity documentary', 'grade': 95},
    ]
  }
];

class GradesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: NewGradesPage(),
    );
  }
}

// const myGray = Color(0xaaaaaaa);
// const double assignmentHeight = 40;

class NewGradesPage extends StatelessWidget {
  Widget buildClassWidget(BuildContext context, int index) {
    if (index == 0) {
      return SizedBox();
    }
    // if (index == 0) {
    //   return Center(
    //     child: Text(
    //       'Classes',
    //       style: TextStyle(
    //           fontSize: 30, fontWeight: FontWeight.bold, color: Colors.black),
    //     ),
    //   );
    // }
    return Class(index, classesList[index - 1]);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: classesList.length + 1,
        itemBuilder: buildClassWidget,
      ),
    );
  }
}

class Class extends StatefulWidget {
  Class(this.number, this.classData);
  Map classData;
  int number;

  @override
  _ClassState createState() => _ClassState();
}

class _ClassState extends State<Class> {
  bool isOpen = false;

  Widget dropdown = SizedBox();
  Widget dropdownCover = SizedBox();

  void toggleDropdown() {
    if (isOpen) {
      isOpen = false;
      setState(() {
        dropdown = SizedBox();
        dropdownCover = SizedBox();
      });
    } else {
      isOpen = true;
      setState(() {
        double mh =
            assignmentHeight * limit(widget.classData['assignments'].length, 3);
        dropdown = Container(
          width: MediaQuery.of(context).size.width * 0.8,
          // fit 3 assignments in the dropdown at a time
          constraints: BoxConstraints(
            maxHeight: mh,
          ),
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: widget.classData['assignments'].length,
            itemBuilder: (context, index) {
              return Assignment(
                widget.classData['assignments'][index],
              );
            },
          ),
        );
        dropdownCover = Positioned(
          top: 30,
          child: Container(
            constraints: BoxConstraints(maxHeight: mh + 25),
            width: MediaQuery.of(context).size.width * 0.8,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.vertical(
                  top: Radius.circular(0), bottom: Radius.circular(20)),
              color: Colors.deepPurpleAccent[100],
            ),
          ),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Widget errorDialog = ClassesPopup(
      data: widget.classData,
      windowSize: size,
    );
    return Center(
      child: Stack(
        children: [
          dropdownCover,
          Column(
            children: [
              GestureDetector(
                onTap: toggleDropdown,
                onDoubleTap: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) => errorDialog);
                },
                child: Container(
                  width: size.width * 0.8,
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  margin: EdgeInsets.only(top: 5),
                  decoration: ShapeDecoration(
                    color: Color(0xd0d0d0).withAlpha(255),
                    shape: StadiumBorder(), // rounds the edges all the way
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(widget.number.toString()),
                      Text(
                        widget.classData['name'],
                        style: TextStyle(
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w400,
                            fontSize: 17),
                      ),
                      Text(
                        '${widget.classData['grade']} (${widget.classData['percentage']}%)',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600),
                      )
                    ],
                  ),
                ),
              ),
              dropdown,
            ],
          ),
        ],
      ),
    );
  }
}

class ClassesPopup extends StatefulWidget {
  ClassesPopup({this.data, this.windowSize});
  Map data;
  Size windowSize;
  @override
  _ClassesPopupState createState() => _ClassesPopupState();
}

class _ClassesPopupState extends State<ClassesPopup> {
  double borderRad = 15;
  Widget content = Text('ha');
  // Widget str = PopupAssignmentsListView(data: widget.data);
  Widget str;
  @override
  Widget build(BuildContext context) {
    Widget str = PopupAssignmentsListView(data: widget.data);

    content = PopupAssignmentsListView(data: widget.data);
    Size popup =
        Size(widget.windowSize.width * 0.8, widget.windowSize.height * 0.7);
    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRad)),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(borderRad)),
        ),
        height: popup.height,
        width: popup.width,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              height: popup.height * 0.25,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 50, bottom: 10),
                    child: Text(
                      widget.data['name'],
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FlatButton(
                        color: Colors.white,
                        onPressed: () {
                          setState(() {
                            content =
                                PopupAssignmentsListView(data: widget.data);
                          });
                        },
                        child: Text(
                          'Assignments',
                          style: TextStyle(fontSize: 16, color: Colors.black87),
                        ),
                      ),
                      FlatButton(
                        onPressed: () {
                          print('afsdsf');
                          setState(() {
                            content = Text('haf');
                            str = FlutterLogo();
                            print(str);
                          });
                        },
                        color: Colors.white,
                        child: Text(
                          'Summary',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              width: popup.width * 0.8,
              height: popup.height * 0.75,
              child: str,
            ),
          ],
        ),
      ),
    );
  }
}

class PopupAssignmentsListView extends StatelessWidget {
  const PopupAssignmentsListView({Key key, @required this.data});

  final Map data;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: data['assignments'].length,
      itemBuilder: (context, index) {
        return Card(
          elevation: 3,
          child: ListTile(
            title: Text(data['assignments'][index]['name']),
            subtitle: Text(data['assignments'][index]['grade'].toString()),
          ),
        );
      },
    );
  }
}

class Assignment extends StatelessWidget {
  Assignment(this.assignmentData, {this.colored = false});
  Map assignmentData;
  bool colored;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: assignmentHeight,
      margin: EdgeInsets.only(bottom: 0),
      decoration: BoxDecoration(
        color: colored ? Colors.deepPurple[300] : null,
        borderRadius: BorderRadius.all(
          Radius.circular(5),
        ),
      ),
      padding: EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            assignmentData['name'],
            style: TextStyle(color: Colors.white),
          ),
          Text(
            '${assignmentData['grade']}%',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}
