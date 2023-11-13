import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:goggles_of_revealing/controller/scan_controller.dart';
import 'package:goggles_of_revealing/ui/constants.dart';
import 'package:goggles_of_revealing/ui/screens/home_screen.dart';

class CameraView extends StatelessWidget {
  const CameraView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder(
          init: ScanController(),
          builder: (controller) {
            return controller.isCameraInitalize.value
                ? Stack(children: [
                    CameraPreview(controller.cameraController),
                    Positioned(
                      // top: (controller.y * 700),
                      top: 50,
                      // right: (controller.x * 500),
                      right: 10,
                      child: Container(
                        width: 385,
                        height: 660,
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Colors.purple.shade900, width: 4.0)),
                        child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                  color: Colors.white,
                                  child: Text(controller.label))
                            ]),
                      ),
                    ),
                  ])
                : const Center(child: Text("Loading preview ..."));
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (_) => const Home()));
        },
        backgroundColor: Constants.primaryColor,
        child: const Icon(Icons.arrow_back_ios),
      ),
    );
  }
}
