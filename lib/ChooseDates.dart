import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StatefulCalendar extends StatefulWidget {
  StatefulCalendar(this.title);
  String title;
  @override
  CalendarState createState() {
    return new CalendarState();
  }
}

class CalendarState extends State<StatefulCalendar> {
  String _date = DateTime.now().toString();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1950),
        lastDate: DateTime(2025));
    if (picked != null)
      setState(() {
        _date = picked.toString();
      });
  }

  Widget _builder() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            widget.title,
            style: TextStyle(fontSize: 20),
          ),
          Container(
            margin: EdgeInsets.only(top: 8),
            height: 50,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.deepOrangeAccent)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    _date,
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: IconButton(
                      icon: Icon(
                        Icons.calendar_today,
                        color: Colors.deepOrangeAccent,
                      ),
                      onPressed: () => _selectDate(context),
                    ))
              ],
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _builder();
  }
}