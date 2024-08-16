import 'package:flutter/material.dart';
import 'package:import_lookup/Screens/cestat_page.dart';
import 'package:import_lookup/Screens/comm_page.dart';
import 'package:import_lookup/Screens/high_court_page.dart';
import 'package:import_lookup/Screens/oio-page.dart';
import 'package:import_lookup/Screens/show-oio-details.dart';
import 'package:import_lookup/Screens/supreme_court_page.dart';
import 'package:provider/provider.dart';

import '../provider/provider.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions =  <Widget>[
    ShowAsserDetails(),
    AddAsseserDetails(),
    Text('Appeal period is not over'),
    SupremeCourtCases(),
    HighCourtCases(),
    CestatCases(),
    CommApealCases(),
    Text("OL"),
    Text("DRT"),
    Text("BIFR"),
    Text("NCLT-Units"),
    Text("'Appeal period not over but appeal filed'"),
    Text("'Settelment commitsion cases'"),
    Text("'Arrear under section-11'"),
    Text('Arrear under section-142'),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
      ),
      drawer: Drawer(
        backgroundColor: Colors.white,
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text('Custom Import'),
            ),
            _buildDrawerItem(
              icon: Icons.home,
              text: 'Appeal period is not over',
              index: 0,
            ),
            _buildDrawerItem(
              icon: Icons.person,
              text: 'Add asserdetails',
              index: 1,
            ),
            _buildDropdown(
              hintText: 'Arrears Under Litigation',
              items: <String>[
                'Commr Appeal',
                'CESTAT',
                'High Court',
                'Supreme Court'
              ],
              indexMap: {
                'Commr Appeal': 6,
                'CESTAT': 5,
                'High Court': 4,
                'Supreme Court': 3,
              },
            ),
            _buildDropdown(
              hintText: 'Restrained Arrears',
              items: <String>[
                'OL',
                'DRT',
                'BIFR',
                'NCLT-Units'
              ],
              indexMap: {
                'OL': 7,
                'DRT': 8,
                'BIFR': 9,
                'NCLT-Units': 10,
              },
            ),
            _buildDropdown(
              hintText: 'Recoverable Arrear',
              items: <String>[
                'Appeal period not over but appeal filed',
                'Settelment commitsion cases',
                'Arrear under section-11',
                'Arrear under section-142',
              ],
              indexMap: {
                'Appeal period not over but appeal filed': 11,
                'Settelment commitsion cases': 12,
                'Arrear under section-11': 13,
                'Arrear under section-142': 14,
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
    );
  }

  Widget _buildDrawerItem({
    required IconData icon,
    required String text,
    required int index,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: _selectedIndex == index ? Colors.blue.withOpacity(0.1) : Colors.transparent,
        borderRadius: BorderRadius.circular(20),
      ),
      child: ListTile(
        leading: Icon(icon),
        title: Text(text),
        onTap: () {
          _onItemTapped(index);
          Navigator.pop(context);
        },
      ),
    );
  }

  Widget _buildDropdown({
    required String hintText,
    required List<String> items,
    required Map<String, int> indexMap,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
      ),
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: ListTile(
        title: DropdownButton<String>(
          elevation: 0,
          underline: Text(''),
          hint: Row(
            children: [
              Icon(Icons.report),
              Text(
                hintText,
                style: TextStyle(
                    fontSize: 18, fontWeight: FontWeight.w500, color: Colors.black),
              ),
            ],
          ),
          items: items.map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: (newValue) {
            if (newValue != null) {
              setState(() {
                _selectedIndex = indexMap[newValue]!;
              });
              Navigator.pop(context);
            }
          },
        ),
      ),
    );
  }
}
