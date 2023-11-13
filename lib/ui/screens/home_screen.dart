import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:goggles_of_revealing/controller/auth.dart';
import 'package:goggles_of_revealing/controller/store.dart';
import 'package:goggles_of_revealing/ui/constants.dart';
import 'package:goggles_of_revealing/ui/screens/scan_screen.dart';
import 'package:goggles_of_revealing/ui/screens/trophies_menu.dart';
import 'package:goggles_of_revealing/ui/screens/trophies_screen.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final User? user = Auth().currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Menu principal",
        ),
        backgroundColor: Constants.primaryColor,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
                decoration: BoxDecoration(
                  color: Constants.primaryColor,
                ),
                child: Container(
                  height: double.infinity,
                  width: double.infinity,
                  alignment: Alignment.center,
                  child: Text(
                    user?.email ?? "",
                    style: const TextStyle(color: Colors.white, fontSize: 20),
                  ),
                )),
            ListTile(
              leading: const Icon(Icons.home_max_outlined),
              title: const Text("Menu"),
              onTap: () {
                // Api().checkScannedItem();
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (_) => const Home()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.workspaces_outline),
              title: const Text("Assets discovered"),
              onTap: () {
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (_) => TrophyMenu()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.ad_units_outlined),
              title: const Text("Thaunomicon"),
              onTap: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (_) => const CameraView()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.door_back_door),
              title: const Text("Sign out"),
              onTap: () {
                Auth().signOut();
              },
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.camera_outlined),
          onPressed: () {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (_) => const CameraView()));
          }),
    );
  }
}
