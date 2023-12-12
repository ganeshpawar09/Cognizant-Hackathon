import 'package:flutter/material.dart';
import 'package:tracker/models/healthgoup.dart';

class CommunityScreen extends StatefulWidget {
  const CommunityScreen({Key? key}) : super(key: key);

  @override
  _CommunityScreenState createState() => _CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityScreen> {
  List<HealthGroup> dummyData = [
    HealthGroup(
      name: 'Fitness Fanatics',
      description: 'A community for fitness enthusiasts',
    ),
    HealthGroup(
      name: 'Healthy Eating Crew',
      description: 'Discussing nutritious meals and recipes',
    ),
    HealthGroup(
      name: 'Mental Wellness Support',
      description: 'Supportive community for mental health discussions',
    ),
    HealthGroup(
      name: 'Running Buddies',
      description: 'Connect with fellow runners and share tips',
    ),
  ];

  List<HealthGroup> filteredData = [];

  TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          _buildSearchBar(),
          Expanded(
            child: _buildHealthGroupsList(),
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
        onChanged: (value) {
          _filterHealthGroups(value);
        },
        decoration: InputDecoration(
          hintText: 'Search groups',
          prefixIcon: Icon(Icons.search),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          contentPadding: EdgeInsets.symmetric(vertical: 10.0),
        ),
      ),
    );
  }

  Widget _buildHealthGroupsList() {
    List<HealthGroup> displayData =
        filteredData.isNotEmpty ? filteredData : dummyData;

    return ListView.builder(
      itemCount: displayData.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: CircleAvatar(
            child: Text(
              displayData[index].name[0].toUpperCase(),
              style: TextStyle(fontSize: 20),
            ),
          ),
          title: Text(
            displayData[index].name,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text(displayData[index].description),
        );
      },
    );
  }

  void _filterHealthGroups(String searchTerm) {
    setState(() {
      filteredData = dummyData
          .where((group) =>
              group.name.toLowerCase().contains(searchTerm.toLowerCase()) ||
              group.description
                  .toLowerCase()
                  .contains(searchTerm.toLowerCase()))
          .toList();
    });
  }
}
