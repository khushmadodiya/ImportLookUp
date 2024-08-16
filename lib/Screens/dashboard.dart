import 'package:flutter/material.dart';
import 'package:import_lookup/Screens/RecoverableArrear/Sattlement_commission_cases.dart';
import 'package:import_lookup/Screens/RecoverableArrear/apeal_period_over_but_no_apeal_filed.dart';
import 'package:import_lookup/Screens/RecoverableArrear/arrear_under_section11.dart';
import 'package:import_lookup/Screens/RecoverableArrear/arrear_under_section142.dart';
import 'package:import_lookup/Screens/RecoverableArrear/unit_closed_not_traceable.dart';
import 'package:import_lookup/Screens/ResrainedArriers/BIFR.dart';
import 'package:import_lookup/Screens/ResrainedArriers/DRT.dart';
import 'package:import_lookup/Screens/ResrainedArriers/NCLT.dart';
import 'package:import_lookup/Screens/ResrainedArriers/OL.dart';
import 'package:import_lookup/Screens/cestat_page.dart';
import 'package:import_lookup/Screens/comm_page.dart';
import 'package:import_lookup/Screens/high_court_page.dart';
import 'package:import_lookup/Screens/oio-page.dart';
import 'package:import_lookup/Screens/show-oio-details.dart';
import 'package:import_lookup/Screens/supreme_court_page.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;

  final List<Widget> _widgetOptions = [
    ShowAsserDetails(),
    AddAsseserDetails(),
    SupremeCourtCases(),
    HighCourtCases(),
    CestatCases(),
    CommApealCases(),
    OLPage(),
    DRTPage(),
    BIFRPage(),
    NCLTPage(),
    RecoverableNoApealFiled(),
    RecoverableSattelmentCases(),
    RecoverableUnitClose(),
    RecoverableArrearUnderSection11(),
    RecoverableArrearUnder142(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isWideScreen = screenWidth > 700;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
      ),
      drawer: isWideScreen ? null : _buildDrawer(),
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: isWideScreen ? _buildBottomBar() : null,
    );
  }

  Widget _buildDrawer() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const DrawerHeader(
            decoration: BoxDecoration(color: Colors.blue),
            child: Text(
              'Custom Import',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          _buildDrawerItem(
            icon: Icons.home,
            text: 'Appeal period is not over',
            index: 2,
          ),
          _buildDrawerItem(
            icon: Icons.person,
            text: 'Add asserdetails',
            index: 1,
          ),
          _buildExpandableListItem(
            title: 'Arrears Under Litigation',
            children: [
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
          _buildExpandableListItem(
            title: 'Restrained Arrears',
            children: ['OL', 'DRT', 'BIFR', 'NCLT-Units'],
            indexMap: {
              'OL': 7,
              'DRT': 8,
              'BIFR': 9,
              'NCLT-Units': 10,
            },
          ),
          _buildExpandableListItem(
            title: 'Recoverable Arrear',
            children: [
              'Appeal period not over but appeal filed',
              'Settlement commission cases',
              "Units closed/defaulters not traceable",
              'Arrear under section-11',
              'Arrear under section-142',
            ],
            indexMap: {
              'Appeal period not over but appeal filed': 11,
              'Settlement commission cases': 12,
              "Units closed/defaulters not traceable":13,
              'Arrear under section-11': 14,
              'Arrear under section-142': 15,
            },
          ),
        ],
      ),
    );
  }

  Widget _buildBottomBar() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Add',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.gavel),
          label: 'Litigation',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.block),
          label: 'Restrained',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.monetization_on),
          label: 'Recoverable',
        ),
      ],
      currentIndex: _getBottomNavIndex(),
      selectedItemColor: Colors.amber[800],
      onTap: (index) {
        if (index <= 1) {
          _onItemTapped(index);
        } else {
          _showBottomSheet(index);
        }
      },
    );
  }

  int _getBottomNavIndex() {
    if (_selectedIndex <= 1) return _selectedIndex;
    if (_selectedIndex >= 3 && _selectedIndex <= 6) return 2;
    if (_selectedIndex >= 7 && _selectedIndex <= 10) return 3;
    if (_selectedIndex >= 11 && _selectedIndex <= 15) return 4;
    return 0;
  }

  void _showBottomSheet(int parentIndex) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return ListView(
          children: _getOptionsForParentIndex(parentIndex)
              .entries
              .map((entry) => ListTile(
                    title: Text(entry.key),
                    onTap: () {
                      setState(() {
                        _selectedIndex = entry.value;
                      });
                      Navigator.pop(context);
                    },
                  ))
              .toList(),
        );
      },
    );
  }

  Map<String, int> _getOptionsForParentIndex(int parentIndex) {
    switch (parentIndex) {
      case 2:
        return {
          'Commr Appeal': 6,
          'CESTAT': 5,
          'High Court': 4,
          'Supreme Court': 3,
        };
      case 3:
        return {
          'OL': 7,
          'DRT': 8,
          'BIFR': 9,
          'NCLT-Units': 10,
        };
      case 4:
        return {
          'Appeal period not over but appeal filed': 11,
          'Settlement commission cases': 12,
          'Arrear under section-11': 13,
          'Arrear under section-142': 14,
        };
      default:
        return {};
    }
  }

  Widget _buildDrawerItem({
    required IconData icon,
    required String text,
    required int index,
  }) {
    return ListTile(
      leading: Icon(icon),
      title: Text(text),
      selected: _selectedIndex == index,
      onTap: () {
        _onItemTapped(index);
        Navigator.pop(context);
      },
    );
  }

  Widget _buildExpandableListItem({
    required String title,
    required List<String> children,
    required Map<String, int> indexMap,
  }) {
    return ExpansionTile(
      title: Text(title),
      children: children.map((child) {
        return ListTile(
          title: Text(child),
          selected: _selectedIndex == indexMap[child],
          onTap: () {
            _onItemTapped(indexMap[child]!);
            Navigator.pop(context);
          },
        );
      }).toList(),
    );
  }
}