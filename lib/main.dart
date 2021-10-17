import 'package:flutter/material.dart';
import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart';
import 'package:vector_math/vector_math_64.dart' as vector;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  ArCoreController arCoreController;
  
  ArCoreNode node1 = ArCoreReferenceNode(
    name: 'GoodCard',
    obcject3DFileName: 'GoodCard.sfb',
    scale: vector.Vector3(.5, .5, .5),
    position: vector.Vector3(0, -1, -1.5),
    rotation: vector.Vector4(0, 0, 0, 0),
  );

  ArCoreNode node2 = ArCoreReferenceNode(
    name: 'BadCard',
    obcject3DFileName: 'BadCard.sfb',
    scale: vector.Vector3(.5, .5, .5),
    position: vector.Vector3(-1, -1, -1.5),
    rotation: vector.Vector4(0, 0, 0, 0),
  );
  
  ArCoreNode node3 = ArCoreReferenceNode(
    name: 'goodEnvCard',
    obcject3DFileName: 'goodEnvCard.sfb',
    scale: vector.Vector3(.5, .5, .5),
    position: vector.Vector3(0, -1, -1.5),
    rotation: vector.Vector4(0, 0, 0, 0),
  );
  
  ArCoreNode node4 = ArCoreReferenceNode(
    name: 'badEnvCard',
    obcject3DFileName: 'badEnvCard.sfb',
    scale: vector.Vector3(.5, .5, .5),
    position: vector.Vector3(-1, -1, -1.5),
    rotation: vector.Vector4(0, 0, 0, 0),
  );


  void dipsose() {
    super.dispose();
    arCoreController.dispose();
  }

  _onArCoreViewCreated(ArCoreController controller) {
    arCoreController = controller;
    //arCoreController.onNodeTap = (node1) => onTapHandler(node1);
    //arCoreController.onPlaneTap = _onPlaneTapHandler;
    _addNode(arCoreController, node1);
    _addNode(arCoreController, node2);
    _addNode(arCoreController, node3);
    _addNode(arCoreController, node4);
    //arCoreController.onPlaneDetected = _handleOnPlaneDetected;
  }

  // onTapHandler(String name) {
  //   showDialog<void>(
  //     context: context,
  //     builder: (BuildContext context) =>
  //       AlertDialog(content: Text('onNodeTap on $name')),
  //   );
  // }

/*_handleOnPlaneDetected(ArCorePlane plane){
  if(node!=null){
    arCoreController.removeNode(nodeName: node.name);
  }
  _addToon(arCoreController, plane);
}*/

  _addNode(ArCoreController controller, ArCoreNode node) {
    controller.addArCoreNode(node);
  }

  removeNodes() {
    arCoreController.removeNode(nodeName: node1.name);
    arCoreController.removeNode(nodeName: node2.name);
    arCoreController.removeNode(nodeName: node3.name);
    arCoreController.removeNode(nodeName: node4.name);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () => removeNodes,
        child: ArCoreView(
          onArCoreViewCreated: _onArCoreViewCreated,
          enableTapRecognizer: true,
          enableUpdateListener: true,
        ),
      ),
    );
  }
}
