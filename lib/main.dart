import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:age/age.dart';
import 'package:flutter_app/Calculator.dart';
import 'package:intl/intl.dart';

//test
void main() {
  runApp(AgeCalculatorApp());
}

class AgeCalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.deepOrange,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
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
  AgeDuration nextBirthday;

  TextEditingController _ageYearcontroller = TextEditingController();
  TextEditingController _ageMonthcontroller = TextEditingController();
  TextEditingController _ageDaycontroller = TextEditingController();

  TextEditingController _leftYearcontroller = TextEditingController();
  TextEditingController _leftMonthcontroller = TextEditingController();
  TextEditingController _leftDaycontroller = TextEditingController();

  Calculator calculator;

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
          Text("Date of birth", style: TextStyle(fontSize: 20)),
          Container(
            margin: EdgeInsets.only(top: 8),
            height: 50,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.deepOrangeAccent)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: TextField( style: TextStyle(fontSize: 18),
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
          Text("Date of today", style: TextStyle(fontSize: 18)),
          Container(
            margin: EdgeInsets.only(top: 8),
            height: 50,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.deepOrangeAccent)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: TextField( style: TextStyle(fontSize: 20),
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
      _calculate();
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
              style: TextStyle(color: Colors.white, fontSize: 18))),
    );
  }

  void _calculate(){
    _setAgeState();
    _setNextBDState();
  }

  void _setAgeState() {
  calculator=new Calculator(dateOfBirth, dateOfToday);
    setState(() {
      age=calculator.calcAge();
      _ageYearcontroller.text=age.years.toString();
      _ageMonthcontroller.text=age.months.toString();
      _ageDaycontroller.text=age.days.toString();
    });
    print(age);
  }

  void _setNextBDState(){
    setState(() {
      nextBirthday=calculator.calcNextBD();
      _leftYearcontroller.text=nextBirthday.years.toString();
      _leftMonthcontroller.text=nextBirthday.months.toString();
      _leftDaycontroller.text=nextBirthday.days.toString();
    });
  }

  void _clear() {
    setState(() {

      dateOfToday=DateTime.now();
      _dateOfTodayController.text =
          _getFormattedDate(dateOfToday);
      dateOfBirth=DateTime.now();
      _dateOfBirthController.text =
          _getFormattedDate(dateOfBirth);

      age=AgeDuration(years: 0,months: 0,days: 0);
      _ageYearcontroller.text=age.years.toString();
      _ageMonthcontroller.text=age.months.toString();
      _ageDaycontroller.text=age.days.toString();

      nextBirthday=AgeDuration(years: 0,months: 0,days: 0);
      _leftYearcontroller.text=nextBirthday.years.toString();
      _leftMonthcontroller.text=nextBirthday.months.toString();
      _leftDaycontroller.text=nextBirthday.days.toString();

    });
  }

  Widget _buildOutputBox(String title, TextEditingController control) {
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
              style: TextStyle(color: Colors.white, fontSize: 18),
            )),
            color: Colors.deepOrangeAccent,
          ),
          Container(
            height: 30,
            width: 110,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.deepOrangeAccent)),
            child: TextField(textAlign: TextAlign.center,
              controller: control,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAgeRow() {
    Widget Years = _buildOutputBox("Years",_ageYearcontroller);
    Widget Months = _buildOutputBox("Months",_ageMonthcontroller);
    Widget Days = _buildOutputBox("Days",_ageDaycontroller);
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Your age is ",
            style: TextStyle(fontSize: 18),
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
    Widget yearsleft = _buildOutputBox("Years",_leftYearcontroller);
    Widget monthsleft = _buildOutputBox("Months",_leftMonthcontroller);
    Widget daysleft = _buildOutputBox("Days",_leftDaycontroller);
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Next Birthday is in ",
            style: TextStyle(fontSize: 20),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              yearsleft,
              monthsleft,
              daysleft,
            ],
          )
        ],
      ),
    );
  }

}
