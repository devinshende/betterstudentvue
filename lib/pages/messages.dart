import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:betterstudentvue/readjson.dart';

Map messageData = {
  "Inbox": [
    {
      "date": "3/12/21",
      "subject": "AP Test Info",
      "content":
          "AP tests this year will be in person or online. You can pick the online or in person version",
      "author": "Sarah Hocken"
    },
    {
      "date": "3/8/21",
      "subject": "AP test payment is due today!",
      "content":
          "Just a reminder that AP test payment is due today!\n(Unless you have made arrangements with Shantel Buss, our AP coordinator) Nulla nec diam nunc. Vivamus fringilla felis id placerat convallis. Nullam convallis malesuada turpis, a dictum quam hendrerit at. Nam aliquet, mauris sed mollis luctus, massa lorem ultricies elit, quis sagittis turpis purus sodales ipsum. Praesent blandit sapien lectus, non laoreet felis mattis a. Donec consectetur sem sagittis, porta nisl ut, placerat orci. Proin semper, odio sed ultrices sodales, felis augue interdum enim, ac scelerisque risus magna aliquam tellus. Suspendisse potenti. Aliquam sed rutrum augue, quis imperdiet nulla. Donec feugiat nisl eu magna posuere interdum. Fusce nec fermentum nisi. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere.",
      "author": "Sarah Hocken"
    },
    {
      "date": "3/14/21",
      "subject": "Final",
      "content":
          "There will be 4 parts to the final. Please do them by the end of the week.",
      "author": "Ryan Brockey"
    }
  ]
};

class MessagesPage extends StatelessWidget {
  Widget buildClassWidget(BuildContext context, int index) {
    return Message(messageData['Inbox'][index]);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FlatButton(
              onPressed: () {},
              hoverColor: Colors.white,
              splashColor: Colors.green,
              focusColor: Colors.white,
              child: Text(
                'All',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black54,
                ),
              ),
            ),
            SizedBox(width: 10),
            FlatButton(
              onPressed: () {},
              child: Text(
                'Unread',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Colors.black54,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 20),
        ListView.builder(
          shrinkWrap: true,
          itemCount: messageData["Inbox"].length, // +1 for "Messages" heading
          itemBuilder: buildClassWidget,
        )
      ],
    );
  }
}

class Message extends StatelessWidget {
  Message(this.data);
  Map data;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Widget messageDialog = MessagePopup(
      data: data,
      windowSize: size,
    );
    return GestureDetector(
      onTap: () {
        showDialog(
            context: context, builder: (BuildContext context) => messageDialog);
      },
      child: Container(
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
              data['author'],
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 5),
            Text(data['date'],
                style: TextStyle(color: Colors.black54, fontSize: 14)),
            SizedBox(height: 5),
            Text(data['subject'], style: TextStyle(fontSize: 16)),
            SizedBox(height: 5),
          ],
          // contentPadding: EdgeInsets.all(30),,
        ),
      ),
    );
  }
}

class MessagePopup extends StatefulWidget {
  MessagePopup({this.data, this.windowSize});
  Map data;
  Size windowSize;
  @override
  _MessagePopupState createState() => _MessagePopupState();
}

class _MessagePopupState extends State<MessagePopup> {
  double borderRad = 15;
  Widget content = Text('ha');
  @override
  Widget build(BuildContext context) {
    Size popup =
        Size(widget.windowSize.width * 0.8, widget.windowSize.height * 0.7);
    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRad)),
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(borderRad)),
        ),
        height: popup.height,
        width: popup.width,
        child: Column(
          mainAxisSize: MainAxisSize.min, // not sure what this means
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 0),
              child: Center(
                child: Text(
                  widget.data['subject'],
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Divider(thickness: 2),
            Row(
              children: [
                Icon(Icons.account_circle, size: 30, color: Colors.blueGrey),
                SizedBox(width: 10),
                Expanded(child: Text(widget.data['author'])),
                Text(widget.data["date"]),
              ],
            ),
            Divider(thickness: 2),
            SizedBox(height: 10),
            Expanded(
              child: SingleChildScrollView(
                child: Text(widget.data["content"],
                    style: TextStyle(fontSize: 20)),
              ),
            ),
            Center(
              child: FlatButton(
                child: Icon(
                  Icons.check_circle,
                  size: 50,
                  color: Colors.deepPurpleAccent,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
