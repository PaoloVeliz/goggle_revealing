import 'package:camera/camera.dart';
import 'package:get/state_manager.dart';
import 'package:goggles_of_revealing/controller/store.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_tflite/flutter_tflite.dart';

class ScanController extends GetxController {
  @override
  void onInit() {
    initCamera();
    super.onInit();
    initTFlite();
  }

  @override
  void dispose() {
    super.dispose();
    cameraController.dispose();
  }

  late CameraController cameraController;
  late List<CameraDescription> cameras;

  late CameraImage image;
  var cameraCount = 0;
  var x = 0.0;
  var y = 0.0;
  var w = 0.0;
  var h = 0.0;
  var label = "";
  var isCameraInitalize = false.obs;

  initCamera() async {
    if (await Permission.camera.request().isGranted) {
      cameras = await availableCameras();
      cameraController = CameraController(cameras[0], ResolutionPreset.max);
      await cameraController.initialize().then((value) {
        cameraController.startImageStream((image) {
          cameraCount++;
          if (cameraCount % 10 == 0) {
            cameraCount = 0;
            objectDetector(image);
          }
          update();
        });
      });
      isCameraInitalize(true);
      update();
    } else {
      print("camera denied");
    }
  }

  initTFlite() async {
    await Tflite.loadModel(
        model: "assets/model.tflite",
        labels: "assets/labels.txt",
        isAsset: true,
        numThreads: 1,
        useGpuDelegate: false);
  }

  objectDetector(CameraImage image) async {
    var detector = await Tflite.runModelOnFrame(
        bytesList: image.planes.map((e) {
          return e.bytes;
        }).toList(),
        asynch: true,
        imageHeight: image.height,
        imageWidth: image.width,
        imageMean: 127.5,
        imageStd: 127.5,
        numResults: 1,
        rotation: 90,
        threshold: 0.4);

    if (detector != null) {
      var detectedObject = detector.first;
      var confidence = detector.first['confidence'];
      var detectedObjectName = detector.first['label'];
      // print("llega aqui $detectedObjectName");
      if (confidence * 100 > 40) {
        label = detectedObjectName.toString();
        Api().checkScannedItem(label);
        h = detectedObject['rect']['h'];
        x = detectedObject['rect']['x'];
        y = detectedObject['rect']['y'];
        w = detectedObject['rect']['w'];
        // print(detectedObject['rect']);
      }
      update();
    }
  }
}
