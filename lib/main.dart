import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:age/age.dart';
import 'package:intl/intl.dart';

//test
void main() {
  runApp(AgeCalculatorApp());
}

class AgeCalculatorApp extends StatelessWidget {
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
                body: HomeScreen())));
  }
}

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  DateTime dateOfBirth = DateTime.now();
  DateTime dateOfToday = DateTime.now();

  TextEditingController _dateOfBirthController = TextEditingController();
  TextEditingController _dateOfTodayController = TextEditingController();

  AgeDuration age;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        buildDateOfBirth(),
        buildDateOfToday(),
        _buildClearCalc(),
        _buildAgeRow(),
        _buildNextBDRow(),
      ],
    );
  }

  Widget buildDateOfBirth() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("Date of birth"),
          Container(
            margin: EdgeInsets.only(top: 8),
            height: 50,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.deepOrangeAccent)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: _dateOfBirthController,
                    enabled: false,
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: IconButton(
                      icon: Icon(
                        Icons.calendar_today,
                        color: Colors.deepOrangeAccent,
                      ),
                      onPressed: () {
                        setState(() {
                          _selectDate(context).then((value) {
                            dateOfBirth = value;
                            _dateOfBirthController.text =
                                _getFormattedDate(dateOfBirth);
                          });
                        });
                      },
                    ))
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildDateOfToday() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("Date of today"),
          Container(
            margin: EdgeInsets.only(top: 8),
            height: 50,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.deepOrangeAccent)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: _dateOfTodayController,
                    enabled: false,
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: IconButton(
                      icon: Icon(
                        Icons.calendar_today,
                        color: Colors.deepOrangeAccent,
                      ),
                      onPressed: () {
                        setState(() {
                          _selectDate(context).then((value) {
                            dateOfToday = value;
                            _dateOfTodayController.text =
                                _getFormattedDate(dateOfToday);
                          });
                        });
                      },
                    ))
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<DateTime> _selectDate(BuildContext context) async {
    DateTime picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1950),
        lastDate: DateTime(2025));

    return picked;
  }

  String _getFormattedDate(DateTime date) {
    return DateFormat('dd-MM-yyyy').format(date);
  }

  Widget _buildClearCalc() {
    Widget _clearButton = _buildButton("Clear", () {
      _clear();
    });
    Widget _calcButton = _buildButton("calculate", () {
      _calcAge();
    });

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          _clearButton,
          _calcButton,
        ],
      ),
    );
  }

  Widget _buildButton(String title, Function _onPressed) {
    return Container(
      height: 50,
      width: 170,
      child: RaisedButton(
          color: Colors.deepOrangeAccent,
          onPressed: _onPressed,
          child: Text(title.toUpperCase(),
              style: TextStyle(color: Colors.white, fontSize: 15))),
    );
  }

  void _calcAge() {
    setState(() {
      age = Age.dateDifference(fromDate: dateOfBirth, toDate: dateOfToday);
    });
    print(age);
  }

  void _clear() {
    setState(() {
      age=Age.dateDifference(fromDate: DateTime.now(), toDate: DateTime.now());

      dateOfToday=DateTime.now();
      _dateOfTodayController.text =
          _getFormattedDate(dateOfToday);

      dateOfBirth=DateTime.now();
      _dateOfBirthController.text =
          _getFormattedDate(dateOfBirth);

    });
    print(age);
  }

  Widget _buildOutputBox(String title) {
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
              title,
              style: TextStyle(color: Colors.white, fontSize: 20),
            )),
            color: Colors.deepOrangeAccent,
          ),
          Container(
            height: 30,
            width: 110,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.deepOrangeAccent)),
          ),
        ],
      ),
    );
  }

  Widget _buildAgeRow() {
    Widget Years = _buildOutputBox("Years");
    Widget Months = _buildOutputBox("Months");
    Widget Days = _buildOutputBox("Days");
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Your age is ",
            style: TextStyle(fontSize: 20),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Years,
              Months,
              Days,
            ],
          )
        ],
      ),
    );
  }

  Widget _buildNextBDRow() {
    Widget years = _buildOutputBox("Years");
    Widget months = _buildOutputBox("Months");
    Widget days = _buildOutputBox("Days");
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Your age is ",
            style: TextStyle(fontSize: 20),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              years,
              months,
              days,
            ],
          )
        ],
      ),
    );
  }

}
