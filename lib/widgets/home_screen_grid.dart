import 'package:flutter/material.dart';
import 'package:tracker/screens/main/subscreens/bpm_screen.dart';
import 'package:tracker/screens/main/subscreens/calories_screen.dart';
import 'package:tracker/screens/main/subscreens/spo2_screen.dart';
import 'package:tracker/screens/main/subscreens/step_counter_screen.dart';
import 'package:tracker/screens/main/subscreens/water_screen.dart';

class HomePageGrid extends StatefulWidget {
  final int id;

  const HomePageGrid({super.key, required this.id});

  @override
  State<HomePageGrid> createState() => _HomePageGridState();
}

class _HomePageGridState extends State<HomePageGrid> {
  final name = ["Calories", "Water", "Steps", "BPM", "SpO2"];
  final page = [
    CaloriesMeterScreen(),
    WaterMeterScreen(),
    StepCounterScreen(),
    BPMScreen(),
    SPO2Screen()
  ];
  final icons = [
    "assets/icons/kcal.png",
    "assets/icons/drink-water.png",
    "assets/icons/walk.png",
    "assets/icons/heart-rate.png",
    "assets/icons/spo2.png"
  ];
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => page[widget.id]),
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name[widget.id],
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Image.asset(icons[widget.id])
                ]),
          ),
        ),
      ),
    );
  }
}
