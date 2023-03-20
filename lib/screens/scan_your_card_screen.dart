import 'package:flutter/material.dart';

// 3rd party packages
import 'package:camera/camera.dart';

// Custom packages
import 'package:sofiqe/widgets/png_icon.dart';

class ScanYourCardScreen extends StatelessWidget {
  const ScanYourCardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Color(0xFFF4F2F0),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(size.height * 0.08),
        child: AppBar(
          leading: IconButton(
            icon: Transform.rotate(
              angle: 3.14159,
              child: PngIcon(
                image: 'assets/icons/arrow-2-white.png',
              ),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          centerTitle: true,
          backgroundColor: Colors.black,
          title: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: size.height * 0.01,
              ),
              Text(
                'sofiqe',
                style: Theme.of(context).textTheme.headline1!.copyWith(
                    color: Colors.white,
                    fontSize: size.height * 0.035,
                    letterSpacing: 0.6),
              ),
              SizedBox(
                height: size.height * 0.005,
              ),
              Text(
                "SCAN CREDIT CARD",
                style: TextStyle(color: Colors.white, fontSize: 12, letterSpacing: 1, fontWeight: FontWeight.w300),
              ),
              SizedBox(
                height: size.height * 0.025,
              ),
            ],
          ),
        ),
      ),
      // appBar: AppBar(
      //   leading: IconButton(
      //     icon: Transform.rotate(
      //       angle: 3.14159,
      //       child: PngIcon(
      //         image: 'assets/icons/arrow-2-white.png',
      //       ),
      //     ),
      //     onPressed: () {
      //       Navigator.of(context).pop();
      //     },
      //   ),
      //   centerTitle: true,
      //   backgroundColor: Colors.black,
      //   title: Text(
      //     'SCAN CREDIT CARD',
      //     style: Theme.of(context).textTheme.headline2!.copyWith(color: Colors.white, fontSize: 12, letterSpacing: 0.6),
      //   ),
      // ),
      body: Container(
        child: FutureBuilder(
          future: availableCameras(),
          builder: (BuildContext _, AsyncSnapshot<List<CameraDescription>> snapshot) {
            if (snapshot.hasData) {
              return BackCamera(cameras: snapshot.data);
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}

class BackCamera extends StatefulWidget {
  final List<CameraDescription>? cameras;
  BackCamera({this.cameras});

  @override
  _BackCameraState createState() => _BackCameraState();
}

class _BackCameraState extends State<BackCamera> {
  late CameraController controller;
  late Map<String, dynamic> _cameraProperties = {
    'min-zoom-level': 1,
    'max-zoom-level': 10,
  };
  double _currentZoomLevel = 1;
  @override
  void initState() {
    super.initState();
    controller = CameraController(widget.cameras![0], ResolutionPreset.veryHigh, enableAudio: false);
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      _loadCameraProperties();
      controller.setZoomLevel(_currentZoomLevel);
      setState(() {});
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!controller.value.isInitialized) {
      return Container();
    }
    return Container(
      height: MediaQuery.of(context).size.height,
      child: AspectRatio(
        aspectRatio: controller.value.aspectRatio,
        child: CameraPreview(controller),
      ),
    );
  }

  void zoomIn() {
    if (_currentZoomLevel < _cameraProperties['max-zoom-level']) {
      _currentZoomLevel += 0.2;
      controller.setZoomLevel(_currentZoomLevel);
    }
  }

  void zoomOut() {
    if (_currentZoomLevel > _cameraProperties['min-zoom-level']) {
      _currentZoomLevel -= 0.2;

      controller.setZoomLevel(_currentZoomLevel);
    }
  }

  void _loadCameraProperties() async {
    _cameraProperties['max-zoom-level'] = await controller.getMaxZoomLevel();
    _cameraProperties['min-zoom-level'] = await controller.getMinZoomLevel();
  }
}