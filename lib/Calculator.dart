import 'package:age/age.dart';


class Calculator {
  DateTime _dateOfBirth = DateTime.now();
  DateTime _dateOfToday = DateTime.now();

  AgeDuration _age;
  AgeDuration _nextBirthday;

  Calculator(this._dateOfBirth,this._dateOfToday);

  void setDateOfBirth(DateTime d){  _dateOfBirth=d;  }
  void setDateOfToday(DateTime d){  _dateOfToday=d;  }


  AgeDuration calcAge() {
    _age = Age.dateDifference(fromDate: _dateOfBirth, toDate: _dateOfToday);
    return _age;
  }

  AgeDuration calcNextBD(){

    DateTime tempDate = DateTime(_dateOfToday.year, _dateOfBirth.month, _dateOfBirth.day);
    DateTime nextBirthdayDate = tempDate.isBefore(_dateOfToday)
        ? Age.add(date: tempDate, duration: AgeDuration(years: 1))
        : tempDate;
    _nextBirthday =
    Age.dateDifference(fromDate: _dateOfToday, toDate: nextBirthdayDate);

    return _nextBirthday;
  }
}