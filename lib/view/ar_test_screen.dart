import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vector_math/vector_math_64.dart' as vector;

class ARCoreTestView extends StatefulWidget {
  const ARCoreTestView({super.key});

  @override
  State<ARCoreTestView> createState() => _ARCoreTestViewState();
}

class _ARCoreTestViewState extends State<ARCoreTestView> {

  ArCoreController? arCoreController;

  _onArCoreViewCreated(ArCoreController controller) {
    arCoreController = controller;
    displayEarthMapSphere(arCoreController!);
  }

  displayEarthMapSphere(ArCoreController controller) async {
    final ByteData texture = await rootBundle.load("assets/cahid.jpg");

    final materials = ArCoreMaterial(
      color: Colors.blue,
      textureBytes: texture.buffer.asUint8List(),
      reflectance: 0.1
    );

    final sphere = ArCoreSphere(
      materials: [materials],
    );

    final node = ArCoreNode(
      shape: sphere,
      position: vector.Vector3(0, 0, -1.5),
    );

    controller.addArCoreNode(node);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ArCoreView(
        onArCoreViewCreated: _onArCoreViewCreated,
        enableTapRecognizer: true,
      ),
    );
  }
}

    // final earthMapSphere = ArCoreSphere(
    //   materials: [
    //     ArCoreMaterial(
    //       color: Colors.blue,
    //       textureBytes: File('assets/earth_map.jpg').readAsBytesSync(),
    //       metallic: 1.0,
    //     ),
    //   ],
    //   radius: 0.1,
    // );
    // final node = ArCoreNode(
    //   shape: earthMapSphere,
    //   position: const Vector3(0, 0, -1.5),
    // );
    // controller.addArCoreNode(node);
