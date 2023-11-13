// import 'dart:html';

import 'dart:typed_data';

import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:goggles_of_revealing/ui/constants.dart';
import 'package:goggles_of_revealing/ui/screens/home_screen.dart';
import 'package:vector_math/vector_math_64.dart' as vector;

class HelloWorld extends StatefulWidget {
  final String imageUrl;
  final String titleObjet;
  const HelloWorld({Key? key, required this.imageUrl, required this.titleObjet})
      : super(key: key);
  @override
  _HelloWorldState createState() => _HelloWorldState();
}

class _HelloWorldState extends State<HelloWorld> {
  late ArCoreController arCoreController;
  String url = "";
  String title = "";

  @override
  void initState() {
    super.initState();

    url = widget.imageUrl;
    title = widget.titleObjet;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: ArCoreView(
          onArCoreViewCreated: _onArCoreViewCreated,
        ),
        bottomNavigationBar: FloatingActionButton(
            child: const Icon(Icons.home_max_outlined),
            onPressed: () {
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (_) => const Home()));
            }),
      ),
    );
  }

  void _onArCoreViewCreated(ArCoreController controller) {
    arCoreController = controller;

    // _addSphere(arCoreController);
    // _addCylindre(arCoreController);
    _addObject(arCoreController);
  }

  void _addSphere(ArCoreController controller) {
    final material = ArCoreMaterial(color: Constants.primaryColor);
    final sphere = ArCoreSphere(
      materials: [material],
      radius: 0.1,
    );
    final node = ArCoreNode(
      shape: sphere,
      position: vector.Vector3(0, 0, -1.5),
    );
    controller.addArCoreNode(node);
  }

  void _addObject(ArCoreController controller) {
    var node = ArCoreReferenceNode(
        position: vector.Vector3(0.0, -0.5, -2.0),
        objectUrl: url,
        scale: vector.Vector3(0.5, 0.5, 0.5));
    controller.addArCoreNode(node);
  }

  @override
  void dispose() {
    arCoreController.dispose();
    super.dispose();
  }
}
