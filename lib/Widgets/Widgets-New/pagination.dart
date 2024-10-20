// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
// class Pagination extends StatefulWidget {
//   const Pagination({super.key});
//
//   @override
//   State<Pagination> createState() => _PaginationState();
// }
//
// class _PaginationState extends State<Pagination> {
//
//   int selectedPage = 1;
//
//   setSelectedPage(int index) {
//     setState(() {
//       selectedPage = index;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Flutter Pagination"),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Pagination(
//               numOfPages: 10,
//               selectedPage: selectedPage,
//               pagesVisible: 3,
//               onPageChanged: (page) {
//                 setState(() {
//                   selectedPage = page;
//                 });
//               },
//               nextIcon: const Icon(
//                 Icons.arrow_forward_ios,
//                 color: Colors.blue,
//                 size: 14,
//               ),
//               previousIcon: const Icon(
//                 Icons.arrow_back_ios,
//                 color: Colors.blue,
//                 size: 14,
//               ),
//               activeTextStyle: const TextStyle(
//                 color: Colors.white,
//                 fontSize: 14,
//                 fontWeight: FontWeight.w700,
//               ),
//               activeBtnStyle: ButtonStyle(
//                 backgroundColor: MaterialStateProperty.all(Colors.blue),
//                 shape: MaterialStateProperty.all(
//                   RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(38),
//                   ),
//                 ),
//               ),
//               inactiveBtnStyle: ButtonStyle(
//                 shape: MaterialStateProperty.all(RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(38),
//                 )),
//               ),
//               inactiveTextStyle: const TextStyle(
//                 fontSize: 14,
//                 fontWeight: FontWeight.w700,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
