import 'package:flutter/material.dart';
import 'package:tracker/models/doctor.dart';
import 'package:tracker/widgets/doctor_screen_list.dart';

class DoctorsScreen extends StatefulWidget {
  const DoctorsScreen({Key? key}) : super(key: key);

  @override
  _DoctorsScreenState createState() => _DoctorsScreenState();
}

class _DoctorsScreenState extends State<DoctorsScreen> {
  List<Doctor> allDoctors = [
    Doctor(
      doctorName: 'Dr. John Doe',
      specialist: 'Cardiologist',
      education: 'MD, Cardiology',
      hospitalName: 'City Hospital',
      location: 'City, Country',
    ),
    Doctor(
      doctorName: 'Dr. Jane Smith',
      specialist: 'Pediatrician',
      education: 'MD, Pediatrics',
      hospitalName: 'Children\'s Hospital',
      location: 'City, Country',
    ),
  ];

  List<Doctor> displayedDoctors = [];

  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    displayedDoctors = List.from(allDoctors);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          _buildSearchBar(),
          Expanded(
            child: _buildDoctorsList(),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: _searchController,
        onChanged: _filterDoctors,
        decoration: InputDecoration(
          hintText: 'Search doctors',
          prefixIcon: Icon(Icons.search),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          contentPadding: EdgeInsets.symmetric(
              vertical: 10.0), 
        ),
      ),
    );
  }

  Widget _buildDoctorsList() {
    return ListView.builder(
      itemCount: displayedDoctors.length,
      itemBuilder: (context, index) {
        return DoctorCard(
          doctor: displayedDoctors[index],
        );
      },
    );
  }

  void _filterDoctors(String searchTerm) {
    setState(() {
      displayedDoctors = allDoctors
          .where((doctor) =>
              doctor.doctorName
                  .toLowerCase()
                  .contains(searchTerm.toLowerCase()) ||
              doctor.specialist
                  .toLowerCase()
                  .contains(searchTerm.toLowerCase()) ||
              doctor.education
                  .toLowerCase()
                  .contains(searchTerm.toLowerCase()) ||
              doctor.hospitalName
                  .toLowerCase()
                  .contains(searchTerm.toLowerCase()) ||
              doctor.location.toLowerCase().contains(searchTerm.toLowerCase()))
          .toList();
    });
  }
}
