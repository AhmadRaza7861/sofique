import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

class BackCamera extends StatefulWidget {
  final CameraController controller;

  BackCamera({required this.controller});

  @override
  _BackCameraState createState() => _BackCameraState();
}

class _BackCameraState extends State<BackCamera> {
  @override
  void initState() {
    super.initState();
    widget.controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    });
  }

  @override
  void dispose() {
    widget.controller.dispose();
    super.dispose();
  }

  late Size size;
  @override
  Widget build(BuildContext context) {
    print('Building back camera');
    size = MediaQuery.of(context).size;
    if (!widget.controller.value.isInitialized) {
      return Container(
        color: Colors.black,
        child: Center(
          child: GestureDetector(
            onTap: () {
              widget.controller.initialize().then(
                (_) {
                  if (!mounted) {
                    return;
                  }
                  setState(() {});
                },
              );
            },
            child: Container(),
          ),
        ),
      );
    }
    // widget.controller.value.
    // return Container(
    //   alignment: Alignment.topCenter,
    //   height: size.height,
    //   child: AspectRatio(
    //     aspectRatio: (1 / widget.controller.value.aspectRatio),
    //     child: CameraPreview(
    //       widget.controller,
    //     ),
    //   ),
    // );

    final scale = 1 / (widget.controller.value.aspectRatio * MediaQuery.of(context).size.aspectRatio);
    return Transform.scale(
      scale: scale,
      alignment: Alignment.topCenter,
      child: CameraPreview(widget.controller),
    );
  }
}
