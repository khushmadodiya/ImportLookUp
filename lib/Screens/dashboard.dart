import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:import_lookup/Backend-New/Golbal-Files/category-and-subcategory.dart';
import 'package:import_lookup/Backend-New/authentication.dart';
import 'package:import_lookup/Provider-New/get-user-deatils.dart';
import 'package:import_lookup/Screens-New/Auth-Screens/login-screen.dart';
import 'package:import_lookup/Screens-New/Dashboard/accept_request.dart';
import 'package:import_lookup/Screens-New/Dashboard/add-case-detail.dart';
import 'package:import_lookup/Screens/search_screen.dart';
import 'package:import_lookup/Widgets/Widgets-New/custom-table.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Provider-New/add-new-cases.dart';
import '../Screens-New/Dashboard/tar-report.dart';
import '../global.dart';

class DashboardScreen extends StatefulWidget {

  DashboardScreen({super.key,

  });

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  bool isadmin=false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getitem();

  }

  getitem()async{
    var pref = await SharedPreferences.getInstance();
    selecteditem = pref.get('value').toString();
    print(selecteditem);
  }
  int _selectedIndex = 0;



  void _onItemTapped(int index, String itemName) {
    setState(() {
      _selectedIndex = index;
    });
    _showSnackBar(itemName);
  }

  void _showSnackBar(String itemName) {
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Container(
          width: MediaQuery.of(context).size.width * 0.5,
          child: Row(
            children: [
              Icon(Icons.info_outline, color: Colors.white),
              SizedBox(width: 10),
              Expanded(
                child: Text(
                  'Selected: $itemName',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        backgroundColor: Colors.blue.shade700,
        duration: const Duration(seconds: 2),
        action: SnackBarAction(
          label: 'OK',
          textColor: Colors.white,
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          },
        ),
      ),
    );
  }
  // @override
  // void initState(){
  //   super.initState();
  //   // if(!widget.isadmin){
  //   //   // _widgetOptions.removeLast();
  //   // }
  // }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isNarrowScreen = screenWidth < 300;
    final List<Widget> _widgetOptions =  [
      RevenueTable(),
      CustomTable(title: "Show OIO Details", subcategory: SUBCATEGORY[CATEGORY[2]]![0],category: CATEGORY[2],),
      SearchScreenMain(),
      AddCaseDeatil(),
      CustomTable(title: "Supreme Court", subcategory: SUBCATEGORY[CATEGORY[0]]![0],category: CATEGORY[0],),
      CustomTable(title: "High Court", subcategory: SUBCATEGORY[CATEGORY[0]]![1],category: CATEGORY[0],),
      CustomTable(title: "CESTAT", subcategory: SUBCATEGORY[CATEGORY[0]]![2],category: CATEGORY[0],),
      CustomTable(title: "Comm Apeal", subcategory: SUBCATEGORY[CATEGORY[0]]![3],category: CATEGORY[0],),
      CustomTable(title: "Additional Secretary", subcategory: SUBCATEGORY[CATEGORY[0]]![3],category: CATEGORY[0],),
      //
      CustomTable(title: "OL", subcategory: SUBCATEGORY[CATEGORY[1]]![0],category: CATEGORY[1],),
      CustomTable(title: "DRT", subcategory: SUBCATEGORY[CATEGORY[1]]![1],category: CATEGORY[1]),
      CustomTable(title: "BIFR", subcategory: SUBCATEGORY[CATEGORY[1]]![2],category: CATEGORY[1]),
      CustomTable(title: "NCLT", subcategory: SUBCATEGORY[CATEGORY[1]]![3],category: CATEGORY[1]),
      //
      CustomTable(title: "Recoverable where apeal period not over", subcategory: SUBCATEGORY[CATEGORY[3]]![0],category: CATEGORY[3]),
      CustomTable(title: "Recoverable sattelmentcases", subcategory: SUBCATEGORY[CATEGORY[3]]![1],category: CATEGORY[3]),
      CustomTable(title: "Unit colosed", subcategory: SUBCATEGORY[CATEGORY[3]]![2],category: CATEGORY[3]),
      CustomTable(title: "Recoverable Under section 11", subcategory: SUBCATEGORY[CATEGORY[3]]![2],category: CATEGORY[3]),
      CustomTable(title: "Recoverable Under 142", subcategory: SUBCATEGORY[CATEGORY[3]]![3],category: CATEGORY[3]),

      CustomTable(title: "Recoverable Write off", subcategory: SUBCATEGORY[CATEGORY[4]]![0],category:CATEGORY[4]),
      // if(widget.isAdmin)
      AcceptRequestCase(title: 'Reqests',)


    ];
    return PopScope(
      canPop: false,
      child: Consumer<AddNewCase>(
          builder: (context,pro,child) {
            return Scaffold(
              // appBar: AppBar(
              //   actions: [
              //     IconButton(onPressed: ()async{
              //       var res = await Authentication().logOut();
              //       if(res=='success'){
              //         Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>LoginPage()), (route) => false);
              //       }
              //     }, icon: Icon(Icons.logout))
              //   ],
              // ),
              // drawer: isNarrowScreen ? _buildDrawer() : null,
              body: _widgetOptions.elementAt(_selectedIndex),
                // isNarrowScreen ? null :
              bottomNavigationBar: _buildBottomBar(),
            );


          }
      ),
    );
  }

  Widget _buildDrawer() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
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
            text: 'TAR Report',
            index: 0,
          ),
          _buildDrawerItem(
            icon: Icons.home,
            text: 'Show OIO Details',
            index: 1,
          ),
          _buildDrawerItem(
            icon: Icons.search,
            text: 'Search',
            index: 2,
          ),
          _buildDrawerItem(
            icon: Icons.person,
            text: 'Add Asser Details',
            index: 3,
          ),
          _buildExpandableListItem(
            title: 'Arrears Under Litigation',
            children: [
              "Addtional secratary"
                  'Commr Appeal',
              'CESTAT',
              'High Court',
              'Supreme Court'
            ],
            indexMap: {
              'Additional secratary':8,
              'Commr Appeal': 7,
              'CESTAT': 6,
              'High Court': 5,
              'Supreme Court': 4,
            },
          ),
          _buildExpandableListItem(
            title: 'Restrained Arrears',
            children: ['OL', 'DRT', 'BIFR', 'NCLT-Units'],
            indexMap: {
              'OL': 9,
              'DRT': 10,
              'BIFR': 11,
              'NCLT-Units': 12,
            },
          ),
          _buildExpandableListItem(
            title: 'Recoverable Arrear',
            children: [
              'Appeal period not over but appeal filed',
              'Settlement commission cases',
              'Unit closed'
                  'Arrear under section-11',
              'Arrear under section-142',
            ],
            indexMap: {
              'Appeal period not over but appeal filed': 13,
              'Settlement commission cases': 14,
              'Unit closed':15,
              'Arrear under section-142(1)(C)(II)': 16,
              'Arrear under section-142(1)(C)(I)': 17,
            },
          ),
          _buildDrawerItem(
            icon: Icons.delete_outline,
            text: 'Write-off',
            index: 18,
          ),
        ],
      ),
    );
  }

  Widget _buildBottomBar() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      iconSize: 20,
      unselectedItemColor: Colors.black,
      items:  const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.newspaper),
          label: 'APNO',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search),
          label: 'Search',
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
        BottomNavigationBarItem(
          icon: Icon(Icons.delete_outline),
          label: 'Write-off',
        ),
        // if(widget.isAdmin)
        BottomNavigationBarItem(
          icon: Icon(Icons.request_quote),
          label: 'Requests',
        ),
      ],
      currentIndex: _getBottomNavIndex(),
      selectedItemColor: Colors.amber[800],
      onTap: (index) {
        if (index <= 3) {
          _onItemTapped(index, index == 0 ? 'Home' : index == 1 ? 'OIO' : index==2?'Search': 'Add');
        } else if (index == 7) {
          _onItemTapped(18, 'Write-off');
        }else if(index == 8){
          _onItemTapped(19, 'Update Req');
        } else {
          _showBottomSheet(index);
        }
      },
    );
  }


  int _getBottomNavIndex() {
    if (_selectedIndex <= 3) return _selectedIndex;
    if (_selectedIndex >= 4 && _selectedIndex <= 8) return 4;  // Updated this line for Litigation options
    if (_selectedIndex >= 9 && _selectedIndex <= 12) return 5; // Restrained Arrears
    if (_selectedIndex >= 13 && _selectedIndex <= 17) return 6; // Recoverable Arrear
    if (_selectedIndex == 18) return 7; // Write-off
    if(
    // widget.isAdmin&&
    _selectedIndex == 19) return 8; // Requests (for Admin)
    return 0;
  }

  void _showBottomSheet(int parentIndex) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          width: 350,
          height: 250,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Center(
            child: ListView(
              children: _getOptionsForParentIndex(parentIndex)
                  .entries
                  .map((entry) => ListTile(
                title: Text(entry.key,style: TextStyle(fontWeight: FontWeight.w500),),
                onTap: () {
                  _onItemTapped(entry.value, entry.key);
                  Navigator.pop(context);
                },
              ))
                  .toList(),
            ),
          ),
        );
      },
    );
  }

  Map<String, int> _getOptionsForParentIndex(int parentIndex) {
    switch (parentIndex) {
      case 4:
        return {
          'Additional secratory':8,
          'Commr Appeal': 7,
          'CESTAT': 6,
          'High Court': 5,
          'Supreme Court': 4,
        };
      case 5:
        return {
          'OL': 9,
          'DRT': 10,
          'BIFR': 11,
          'NCLT-Units': 12,
        };
      case 6:
        return {
          'Appeal period over but no appeal filed': 13,
          'Settlement commission cases': 14,
          'Unit closed':15,
          'Arrear under section-142(1)(C)(II)': 16,
          'Arrear under section-142(1)(C)(I)': 17,
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
        _onItemTapped(index, text);
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
            _onItemTapped(indexMap[child]!, child);
            Navigator.pop(context);
          },
        );
      }).toList(),
    );
  }

}


// CustomTable(title: "Supreme Court", subcategory: SUBCATEGORY[CATEGORY[0]]![0],),
// CustomTable(title: "High Court", subcategory: SUBCATEGORY[CATEGORY[0]]![1],),
// CustomTable(title: "CESTAT", subcategory: SUBCATEGORY[CATEGORY[0]]![2],),
// CustomTable(title: "Comm Apeal", subcategory: SUBCATEGORY[CATEGORY[0]]![3],),
//
// CustomTable(title: "OL", subcategory: SUBCATEGORY[CATEGORY[1]]![0],),
// CustomTable(title: "DRT", subcategory: SUBCATEGORY[CATEGORY[1]]![1],),
// CustomTable(title: "BIFR", subcategory: SUBCATEGORY[CATEGORY[1]]![2],),
// CustomTable(title: "NCLT", subcategory: SUBCATEGORY[CATEGORY[1]]![3],),
//
// CustomTable(title: "Recoverable where apeal period not over", subcategory: SUBCATEGORY[CATEGORY[3]]![0],),
// CustomTable(title: "Recoverable sattelmentcases", subcategory: SUBCATEGORY[CATEGORY[3]]![1],),
// CustomTable(title: "Recoverable unit close", subcategory: SUBCATEGORY[CATEGORY[3]]![2],),
// CustomTable(title: "Recoverable Under section 11", subcategory: SUBCATEGORY[CATEGORY[3]]![4],),
// CustomTable(title: "Recoverable Under 142", subcategory: SUBCATEGORY[CATEGORY[3]]![4],),
// CustomTable(title: "Recoverable Write off", subcategory: SUBCATEGORY[CATEGORY[4]]![0],),