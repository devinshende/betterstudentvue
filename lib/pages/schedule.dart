import 'package:flutter/material.dart';
import 'package:betterstudentvue/pages/grades.dart';

class SchedulePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: NewGradesPage(),
    );
  }
}

const myGray = Color(0xaaaaaaa);
const double assignmentHeight = 40;

class NewGradesPage extends StatelessWidget {
  Widget buildClassWidget(BuildContext context, int index) {
    return Class(index, classesList[index]);
  }

  List<Widget> get_classes() {
    List<Widget> classes = [];
    for (var i = 0; i < classesList.length; i += 1) {
      classes.add(Class(i, classesList[i]));
    }
    return classes;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          children: get_classes(),
        ),
      ),
    );

    //   child: ListView.builder(
    //     shrinkWrap: true,
    //     itemCount: classesList.length,
    //     itemBuilder: buildClassWidget,
    //   ),
    // );
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

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Widget errorDialog = ClassesPopup(
      data: widget.classData,
      windowSize: size,
    );
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(15),
      margin: EdgeInsets.only(left: 30, right: 30, bottom: 10),
      decoration: BoxDecoration(
        color: Colors.black12,
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${widget.number + 1}. ${widget.classData['name']}',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 5),
          Text(widget.classData['teacher'], style: TextStyle(fontSize: 16)),
          SizedBox(height: 5),
        ],
        // contentPadding: EdgeInsets.all(30),,
      ),
    );
    // return Center(
    //   child: Column(
    //     children: [
    //       GestureDetector(
    //         onDoubleTap: () {
    //           showDialog(
    //               context: context,
    //               builder: (BuildContext context) => errorDialog);
    //         },
    //         child: Container(
    //           width: size.width * 0.8,
    //           padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
    //           margin: EdgeInsets.only(top: 5),
    //           decoration: ShapeDecoration(
    //             color: Color(0xd0d0d0).withAlpha(255),
    //             shape: StadiumBorder(), // rounds the edges all the way
    //           ),
    //           child: Row(
    //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //             children: [
    //               Text(widget.number.toString()),
    //               Text(
    //                 widget.classData['name'],
    //                 style: TextStyle(
    //                     fontFamily: 'Roboto',
    //                     fontWeight: FontWeight.w400,
    //                     fontSize: 17),
    //               ),
    //               SizedBox()
    //             ],
    //           ),
    //         ),
    //       ),
    //     ],
    //   ),
    // );
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
