import 'package:goggles_of_revealing/controller/auth.dart';
import 'package:goggles_of_revealing/ui/screens/home_screen.dart';
import 'package:goggles_of_revealing/ui/screens/login_screen.dart';
import 'package:flutter/material.dart';
// import 'package:goggles_of_revealing/ui/screens/scan_screen.dart';

class WidgetTree extends StatefulWidget {
  const WidgetTree({super.key});

  @override
  State<WidgetTree> createState() => _WidgetTreeState();
}

class _WidgetTreeState extends State<WidgetTree> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Auth().authStateChange,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Home();
        } else {
          return LoginPage();
        }
      },
    );
  }
}
