// import 'dart:js';

// import 'package:flutter/material.dart';
// import 'package:goggles_of_revealing/ui/constants.dart';
// import 'package:goggles_of_revealing/controller/auth.dart';
// import 'package:goggles_of_revealing/ui/screens/scan_screen.dart';

// Widget TharBar() {
//   return Scaffold(
//     appBar: AppBar(
//       title: const Text(
//         "Menu principal",
//       ),
//       backgroundColor: Constants.primaryColor,
//     ),
//     body: Container(
//       height: double.infinity,
//       width: double.infinity,
//       color: const Color(0xffffffb3),
//       child: Column(children: [
//         Stack(
//           alignment: Alignment.bottomRight,
//           children: [
//             IconButton(
//               iconSize: 72,
//               icon: const Icon(Icons.camera_outlined),
//               onPressed: () {
//                 Navigator.pushReplacement(context,
//                     MaterialPageRoute(builder: (_) => const CameraView()));
//               },
//             ),
//           ],
//         )
//       ]),
//     ),
//     drawer: Drawer(
//       child: ListView(
//         padding: EdgeInsets.zero,
//         children: [
//           DrawerHeader(
//               decoration: BoxDecoration(
//                 color: Constants.primaryColor,
//               ),
//               child: Container(
//                 height: double.infinity,
//                 width: double.infinity,
//                 alignment: Alignment.center,
//                 child: Text(
//                   user?.email ?? "",
//                   style: const TextStyle(color: Colors.white, fontSize: 20),
//                 ),
//               )),
//           ListTile(
//             leading: const Icon(Icons.home_max_outlined),
//             title: const Text("Menu"),
//             onTap: () {},
//           ),
//           ListTile(
//             leading: const Icon(Icons.workspaces_outline),
//             title: const Text("Assets discovered"),
//             onTap: () {
//               Navigator.pushReplacement(
//                   context, MaterialPageRoute(builder: (_) => const Home()));
//             },
//           ),
//           ListTile(
//             leading: const Icon(Icons.ad_units_outlined),
//             title: const Text("Thaunomicon"),
//             onTap: () {
//               Navigator.pushReplacement(context,
//                   MaterialPageRoute(builder: (_) => const CameraView()));
//             },
//           ),
//           ListTile(
//             leading: const Icon(Icons.account_tree_outlined),
//             title: const Text("Treasure scanner"),
//             onTap: () {},
//           ),
//           ListTile(
//             leading: const Icon(Icons.door_back_door),
//             title: const Text("Sign out"),
//             onTap: () {
//               Auth().signOut();
//             },
//           )
//         ],
//       ),
//     ),
//   );
// }
