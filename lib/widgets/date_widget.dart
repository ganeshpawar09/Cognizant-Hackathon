import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateWidget extends StatefulWidget {
  const DateWidget({super.key});

  @override
  State<DateWidget> createState() => _DateWidgetState();
}

class _DateWidgetState extends State<DateWidget> {
  DateTime selectedDate = DateTime.now();
  void _changeDate() async {
    await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2015),
      lastDate: DateTime(2030),
    ).then((value) {
      if (value != null) {
        setState(() {
          selectedDate = value;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          onPressed: () {
            setState(() {
              selectedDate = DateTime(
                  selectedDate.year, selectedDate.month, selectedDate.day - 1);
            });
          },
          icon: Icon(Icons.keyboard_arrow_left),
          iconSize: 40,
          color: Colors.grey,
        ),
        const SizedBox(
          width: 5,
        ),
        GestureDetector(
          onTap: _changeDate,
          child: Text(
            DateFormat.yMMMd().format(selectedDate),
            style: TextStyle(fontSize: 25),
          ),
        ),
        const SizedBox(
          width: 5,
        ),
        IconButton(
          onPressed: () {
            setState(() {
              selectedDate = DateTime(
                  selectedDate.year, selectedDate.month, selectedDate.day + 1);
            });
          },
          icon: Icon(Icons.keyboard_arrow_right),
          iconSize: 40,
          color: Colors.grey,
        )
      ],
    );
  }
}
