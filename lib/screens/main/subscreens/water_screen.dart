import 'package:flutter/material.dart';
import 'package:tracker/widgets/date_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_database/firebase_database.dart';

class WaterMeterScreen extends StatefulWidget {
  const WaterMeterScreen({Key? key}) : super(key: key);

  @override
  State<WaterMeterScreen> createState() => _WaterMeterScreenState();
}

class _WaterMeterScreenState extends State<WaterMeterScreen> {
  late SharedPreferences _prefs;
  int targetWaterIntake = 0;
  int currentWaterIntake = 0;

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
      targetWaterIntake = _prefs.getInt('targetWaterIntake') ?? 0;
      currentWaterIntake = _prefs.getInt('currentWaterIntake') ?? 0;
      _controller1.text = targetWaterIntake.toString();
      _controller2.text = "0";
    });
  }

  Future<void> _saveData() async {
    await _prefs.setInt('targetWaterIntake', int.parse(_controller1.text));
    await _prefs.setInt('currentWaterIntake', currentWaterIntake);
  }

  void _addWater(int waterML) async {
    setState(() {
      currentWaterIntake += waterML;
      _saveData();
    });

    DatabaseReference reference = FirebaseDatabase.instance.ref();
    reference.child('waterIntake').push().set({
      'targetWaterIntake': int.parse(_controller1.text),
      'currentWaterIntake': currentWaterIntake,
      'waterAdded': waterML,
      'date': DateTime.now().toUtc().toString(),
    });
  }

  @override
  Widget build(BuildContext context) {
    double progress =
        (targetWaterIntake == 0) ? 0 : currentWaterIntake / targetWaterIntake;

    return Scaffold(
      appBar: AppBar(title: Text("Water Intake")),
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
                    '$currentWaterIntake/$targetWaterIntake ML',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20 , fontWeight: FontWeight.w600),
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
                      label: Text("Daily limit (in ml)"),
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                ElevatedButton(
                  onPressed: () => setState(() {
                    targetWaterIntake = int.parse(_controller1.text);
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
                      label: Text("Water Intake (in ml)"),
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.all(10),
                    ),
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                ElevatedButton(
                  onPressed: () => _addWater(int.parse(_controller2.text)),
                  child: Text("Add Water"),
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
