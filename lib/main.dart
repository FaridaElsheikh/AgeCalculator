import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(HomeScreen());
}

Widget _buildCalender(String text) {
  return Padding(
    padding: const EdgeInsets.all(20.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          text,
          style: TextStyle(fontSize: 20),
        ),
        Container(
          margin: EdgeInsets.only(top: 8),
          height: 50,
          decoration:
          BoxDecoration(border: Border.all(color: Colors.deepOrangeAccent)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "10-4-2017",
                  style: TextStyle(fontSize: 20),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  Icons.calendar_today,
                  color: Colors.deepOrangeAccent,
                ),
              )
            ],
          ),
        )
      ],
    ),
  );
}

Widget _buildButton(String text) {
  return Container(
    height: 50,
    width: 170,
    color: Colors.deepOrangeAccent,
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
          child: Text(text.toUpperCase(),
              style: TextStyle(color: Colors.white, fontSize: 15))),
    ),
  );
}

Widget _buildButtons(String text1, String text2) {
  return Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[_buildButton(text1), _buildButton(text2)],
    ),
  );
}

Widget _buildDates(String text) {
  return Container(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: 10),
          height: 30,
          width: 110,
          child: Center(
              child: Text(
                text,
                style: TextStyle(color: Colors.white, fontSize: 20),
              )),
          color: Colors.deepOrangeAccent,
        ),
        Container(
          height: 30,
          width: 110,
          decoration:
          BoxDecoration(border: Border.all(color: Colors.deepOrangeAccent)),
        ),
      ],
    ),
  );
}

Widget _buildAge(String text) {
  return Padding(
    padding: const EdgeInsets.all(20.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          text,
          style: TextStyle(fontSize: 20),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            _buildDates("Years"),
            _buildDates("Months"),
            _buildDates("Days")
          ],
        )
      ],
    ),
  );
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SafeArea(
            child: Scaffold(
                appBar: AppBar(
                  backgroundColor: Colors.deepOrangeAccent,
                  title: const Text(
                    " Age Calculator ",
                  ),
                  actions: <Widget>[Icon(Icons.more_vert)],
                ),
                body: SingleChildScrollView (
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: _buildCalender("Date Of Birth"),
                      ),
                      _buildCalender("Today's Date "),
                      _buildButtons("clear", "calculate"),
                      _buildAge("Age is"),
                      _buildAge("Next Birthday in "),
                    ],
                  ),
                ))));
  }
}
