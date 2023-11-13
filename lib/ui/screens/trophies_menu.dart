import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:goggles_of_revealing/controller/auth.dart';
import 'package:goggles_of_revealing/controller/store.dart';
import 'package:goggles_of_revealing/ui/constants.dart';
import 'package:goggles_of_revealing/ui/screens/home_screen.dart';
import 'package:goggles_of_revealing/ui/screens/scan_screen.dart';
import 'package:goggles_of_revealing/ui/screens/trophies_screen.dart';

class TrophyMenu extends StatefulWidget {
  const TrophyMenu({super.key});

  @override
  State<TrophyMenu> createState() => _TrophyMenuState();
}

class UserD {
  String id;
  String name;
  List<String> trophies;

  UserD({required this.id, required this.name, required this.trophies});
}

class TrophiesWidget extends StatelessWidget {
  List trophies;
  TrophiesWidget({required this.trophies});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: trophies.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(trophies[index][0]),
            onTap: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (_) => HelloWorld(
                            imageUrl: trophies[index][2],
                            titleObjet: trophies[index][1],
                          )));
            },
          );
        },
      ),
    );
  }
}

class _TrophyMenuState extends State<TrophyMenu> {
  var usert = Auth().currentUser!.uid;
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
                      Auth().currentUser?.email ?? "",
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
                leading: const Icon(Icons.account_tree_outlined),
                title: const Text("Treasure scanner"),
                onTap: () {},
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
        body: FutureBuilder(
          future: FirebaseFirestore.instance
              .collection('users')
              .doc(Auth().currentUser?.uid)
              .get(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              var userData = snapshot.data!.data();
              print("++++++++++++++++++++++++");
              print(userData!['trophies']);
              print(Api().getThropies(userData['trophies']));
              return TrophiesWidget(
                trophies: Api().getThropies(userData['trophies']),
              );
            }
          },
        ));
  }
}
