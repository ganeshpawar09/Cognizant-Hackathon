import 'package:flutter/material.dart';
import 'package:tracker/widgets/date_widget.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_database/firebase_database.dart';

class CaloriesMeterScreen extends StatefulWidget {
  const CaloriesMeterScreen({Key? key}) : super(key: key);

  @override
  _CaloriesMeterScreenState createState() => _CaloriesMeterScreenState();
}

class _CaloriesMeterScreenState extends State<CaloriesMeterScreen> {
  late SharedPreferences _prefs;
  int targetCalories = 0;
  int currentCalories = 0;

  final TextEditingController _controller1 = TextEditingController();
  final TextEditingController _controller2 = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    _prefs = await SharedPreferences.getInstance();
    setState(() {
      targetCalories = _prefs.getInt('targetCalories') ?? 0;
      currentCalories = _prefs.getInt('currentCalories') ?? 0;
      _controller1.text = targetCalories.toString();
      _controller2.text = "0";
    });
  }

  Future<void> _saveData() async {
    await _prefs.setInt('targetCalories', int.parse(_controller1.text));
    await _prefs.setInt('currentCalories', currentCalories);
  }

  void _addCalories(int calories) async {
    setState(() {
      currentCalories += calories;
      _saveData();
    });

    // Add data to Firebase Realtime Database
    DatabaseReference reference = FirebaseDatabase.instance.ref();
    reference.child('calories').push().set({
      'targetCalories': int.parse(_controller1.text),
      'currentCalories': currentCalories,
      'caloriesAdded': calories,
      'date': DateTime.now().toUtc().toString(),
    });
  }

  @override
  Widget build(BuildContext context) {
    double progress =
        (targetCalories == 0) ? 0 : currentCalories / targetCalories;

    return Scaffold(
      appBar: AppBar(title: Text("Calorie Count")),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            DateWidget(),
            SizedBox(
              height: 50,
            ),
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: 250,
                  height: 250,
                  child: CircularProgressIndicator(
                    value: progress,
                    strokeWidth: 50,
                    backgroundColor: Colors.amber,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                  ),
                ),
                SizedBox(
                  width: 100,
                  child: Text(
                    '$currentCalories/$targetCalories Calories',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
            SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: TextField(
                    textAlign: TextAlign.center,
                    controller: _controller1,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(10),
                      label: Text("Daily limit"),
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                ElevatedButton(
                  onPressed: () => setState(() {
                    targetCalories = int.parse(_controller1.text);
                    _saveData();
                  }),
                  child: Text("Set Limit"),
                ),
                SizedBox(
                  width: 20,
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: TextField(
                    textAlign: TextAlign.center,
                    controller: _controller2,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      label: Text("Calories"),
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.all(10),
                    ),
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                ElevatedButton(
                  onPressed: () => _addCalories(int.parse(_controller2.text)),
                  child: Text("Add Calories"),
                ),
                SizedBox(
                  width: 20,
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
