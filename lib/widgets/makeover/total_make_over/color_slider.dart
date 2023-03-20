// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:sofiqe/provider/total_make_over_provider.dart';
// import 'package:auto_size_text/auto_size_text.dart';
// import 'package:sofiqe/utils/states/function.dart';

// class ColorSlider extends StatelessWidget {
//   ColorSlider({Key? key}) : super(key: key) {
//     tmo.fetchNonRecommendedColours();
//   }
//   final TotalMakeOverProvider tmo = Get.find();

//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     // print(size.width * 0.05 + (AppBar().preferredSize.height));
//     return Container(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.start,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Obx(
//             () {
//               bool reset = true;
//               tmo.applicationAreaList.forEach(
//                 (ApplicationArea a) async {
//                   if (a.code == tmo.currentSelectedArea.value) {
//                     Map currentColor = tmo.centralColorMap[a.code];

//                     a.recommendedColors.forEach(
//                       (color) {
//                         if (currentColor['ColourAltHEX'] ==
//                             color['ColourAltHEX']) {
//                           reset = false;
//                         }
//                         // if (color[0].toLowerCase() == hexString.toLowerCase()) {
//                         // if (Map(color, currentColor)) {
//                         //   reset = false;
//                         // }
//                       },
//                     );
//                   }
//                 },
//               );
//               if (reset) {
//                 return GestureDetector(
//                   onTap: () {
//                     tmo.applicationAreaList.forEach(
//                       (aa) {
//                         if (aa.code == tmo.currentSelectedArea.value) {
//                           tmo.changeCentralColorFor(
//                               aa.code, aa.recommendedColors[0]);
//                         }
//                       },
//                     );
//                   },
//                   child: Container(
//                     margin: EdgeInsets.only(
//                       top: size.height * 0.05,
//                       left: size.width * 0.05 +
//                           (AppBar().preferredSize.height * 0.9),
//                     ),
//                     height: AppBar().preferredSize.height * 0.7,
//                     width: AppBar().preferredSize.height * 0.7,
//                     decoration: BoxDecoration(
//                       color: Color(0xFFF2CA8A),
//                       // color: Colors.red,
//                       borderRadius: BorderRadius.all(
//                           Radius.circular(AppBar().preferredSize.height * 0.7)),
//                     ),
//                     child: Icon(Icons.restore_outlined),
//                   ),
//                 );
//               } else {
//                 return Container(
//                   margin: EdgeInsets.only(
//                     top: size.height * 0.05,
//                     left: size.width * 0.05 +
//                         (AppBar().preferredSize.height * 0.9),
//                   ),
//                   height: AppBar().preferredSize.height * 0.7,
//                   width: AppBar().preferredSize.height * 0.7,
//                   decoration: BoxDecoration(
//                     color: Colors.transparent,
//                     borderRadius: BorderRadius.all(
//                         Radius.circular(AppBar().preferredSize.height * 0.7)),
//                   ),
//                 );
//               }
//             },
//           ),

//           SizedBox(height: size.height * 0.01),
//           // Slider
//           Container(
//             margin: EdgeInsets.only(
//               left: size.width * 0.05 + (AppBar().preferredSize.height * 0.0),
//             ),
//             decoration: BoxDecoration(
//                 // color: Color(0xFFF4F2F0),
//                 ),
//             child: Obx(
//               () {
//                 List colorList = tmo.nonRecommendedColours['color'];
//                 if (colorList.isEmpty) {
//                   return Container(
//                     height: AppBar().preferredSize.height * 0.7,
//                     width: AppBar().preferredSize.height * 0.7,
//                     margin: EdgeInsets.only(bottom: 15),
//                     decoration: BoxDecoration(
//                       color: Color(0xFFF2CA8A),
//                       shape: BoxShape.circle,
//                     ),
//                   );
//                 }
//                 int length = tmo.nonRecommendedColours['total'];
//                 return Row(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     ColorPicker(
//                         height: size.height * 0.35,
//                         list: colorList,
//                         length: length),
//                     SizedBox(width: size.width * 0.01),
//                     Container(
//                       // width: size.width * 0.18,
//                       height: size.height * 0.04,
//                       padding: EdgeInsets.symmetric(horizontal: 2),
//                       margin:
//                           EdgeInsets.symmetric(vertical: size.height * 0.005),
//                       decoration: BoxDecoration(
//                         color: Color(0xFFF2CA8A),
//                       ),
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                         children: [
//                           AutoSizeText(
//                             'Click to change',
//                             style:
//                                 Theme.of(context).textTheme.headline2!.copyWith(
//                                       color: Colors.black,
//                                       fontSize: size.height * 0.01,
//                                       letterSpacing: 0,
//                                     ),
//                             maxLines: 1,
//                           ),
//                           AutoSizeText(
//                             'colour in square',
//                             style:
//                                 Theme.of(context).textTheme.headline2!.copyWith(
//                                       color: Colors.black,
//                                       fontSize: size.height * 0.01,
//                                       letterSpacing: 0,
//                                     ),
//                             maxLines: 1,
//                           ),
//                         ],
//                       ),
//                       // child: AutoSizeText(
//                       //   'Click to change color in square',
//                       //   textAlign: TextAlign.center,
//                       //   style: Theme.of(context).textTheme.headline2!.copyWith(
//                       //         color: Colors.black,
//                       //         height: 1,
//                       //         // fontSize: size.height * 0.013,
//                       //       ),
//                       //   // maxLines: 2,
//                       // ),
//                     ),
//                   ],
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class _SliderIndicatorPainter extends CustomPainter {
//   final double position;
//   _SliderIndicatorPainter(this.position);
//   @override
//   void paint(Canvas canvas, Size size) {
//     canvas.drawRRect(
//       RRect.fromRectAndCorners(
//         Rect.fromCenter(
//             center: Offset(size.width / 2, position), width: 24, height: 12),
//         topLeft: Radius.circular(12),
//         topRight: Radius.circular(12),
//         bottomLeft: Radius.circular(12),
//         bottomRight: Radius.circular(12),
//       ),
//       Paint()..color = Color(0xFFF2CA8A),
//     );
//   }

//   @override
//   bool shouldRepaint(_SliderIndicatorPainter old) {
//     return true;
//   }
// }

// class ColorPicker extends StatefulWidget {
//   final double height;
//   final List list;
//   final int length;
//   ColorPicker({required this.height, required this.list, required this.length});
//   @override
//   _ColorPickerState createState() => _ColorPickerState();
// }

// class _ColorPickerState extends State<ColorPicker> {
//   // late final List _colors = widget.tmo.nonRecommendedColours['color'];
//   double _colorSliderPosition = 0;
//   late Map _currentColor = widget.list[0];
//   @override
//   initState() {
//     super.initState();
//     _currentColor = _calculateSelectedColor(_colorSliderPosition);
//   }

//   _colorChangeHandler(double position) {
//     //handle out of bounds positions
//     if (position > widget.height) {
//       position = widget.height;
//     }
//     if (position < 0) {
//       position = 0;
//     }
//     // print("New pos: $position");
//     double tempPosition = _colorSliderPosition;
//     Map tempColor = _currentColor;

//     _currentColor = _calculateSelectedColor(position);
//     if (_currentColor == tempColor) {
//       _colorSliderPosition = tempPosition;
//     } else {
//       _colorSliderPosition = position.truncateToDouble();
//     }
//     setState(() {});
//   }

//   Map _calculateSelectedColor(double position) {
//     //determine color
//     double positionInColorArray =
//         (position / widget.height * (widget.length - 1)); // Max number of items
//     // print(positionInColorArray);
//     int index = positionInColorArray.truncate();
//     // print(index);
//     Map tempColor = _currentColor;

//     if (index >= widget.list.length) {
//       return tempColor;
//     }
//     _currentColor = widget.list[index];
//     return _currentColor;
//   }

//   final TotalMakeOverProvider tmo = Get.find();

//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     // print(_colors);
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//       children: <Widget>[
//         GestureDetector(
//           onTap: () {
//             tmo.changeToNonRecommendedColor(
//                 tmo.currentSelectedArea.value, _currentColor);
//           },
//           child: Container(
//             height: AppBar().preferredSize.height * 0.7,
//             width: AppBar().preferredSize.height * 0.7,
//             margin: EdgeInsets.only(bottom: 15),
//             decoration: BoxDecoration(
//               color: (_currentColor['hex'] as String).toColor(),
//               shape: BoxShape.circle,
//             ),
//           ),
//         ),
//         GestureDetector(
//           behavior: HitTestBehavior.opaque,
//           onVerticalDragStart: (DragStartDetails details) {
//             // print("_-------------------------STARTED DRAG");
//             _colorChangeHandler(details.localPosition.dy);
//           },
//           onVerticalDragUpdate: (DragUpdateDetails details) {
//             _colorChangeHandler(details.localPosition.dy);
//           },
//           onTapDown: (TapDownDetails details) {
//             _colorChangeHandler(details.localPosition.dy);
//           },
//           //This outside padding makes it much easier to grab the   slider because the gesture detector has
//           // the extra padding to recognize gestures inside of
//           child: Padding(
//             padding: EdgeInsets.symmetric(
//                 vertical: size.height * 0.0, horizontal: size.width * 0.02),
//             child: Container(
//               height: widget.height,
//               width: 5,
//               decoration: BoxDecoration(
//                 // border: Border.all(width: 1, color: Colors.grey[800] as Color),
//                 borderRadius: BorderRadius.circular(15),
//                 // gradient: LinearGradient(colors: _colors, begin: Alignment.topCenter, end: Alignment.bottomCenter),
//                 color: Color(0xFFF2CA8A),
//               ),
//               child: CustomPaint(
//                 painter: _SliderIndicatorPainter(_colorSliderPosition),
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sofiqe/provider/total_make_over_provider.dart';

class ColorSlider extends StatelessWidget {
  ColorSlider({Key? key}) : super(key: key) {
    tmo.fetchNonRecommendedColours();
  }
  final TotalMakeOverProvider tmo = Get.find();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // print(size.width * 0.05 + (AppBar().preferredSize.height));
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Obx(
            () {
              bool reset = true;
              tmo.applicationAreaList.forEach(
                (ApplicationArea a) async {
                  if (a.code == tmo.currentSelectedArea.value) {
                    List currentColor = tmo.centralColorMap[a.code];

                    a.recommendedColors.forEach(
                      (color) {
                        // if (color[0].toLowerCase() == hexString.toLowerCase()) {
                        if (listEquals(color, currentColor)) {
                          reset = false;
                        }
                      },
                    );
                  }
                },
              );
              if (reset) {
                return GestureDetector(
                  onTap: () {
                    tmo.applicationAreaList.forEach(
                      (aa) {
                        if (aa.code == tmo.currentSelectedArea.value) {
                          tmo.changeCentralColorFor(aa.code, aa.recommendedColors[0]);
                        }
                      },
                    );
                  },
                  child: Container(
                    margin: EdgeInsets.only(
                      top: size.height * 0.05,
                      left: size.width * 0.05 + (AppBar().preferredSize.height * 0.9),
                    ),
                    height: AppBar().preferredSize.height * 0.7,
                    width: AppBar().preferredSize.height * 0.7,
                    decoration: BoxDecoration(
                      color: Color(0xFFF2CA8A),
                      // color: Colors.red,
                      borderRadius: BorderRadius.all(Radius.circular(AppBar().preferredSize.height * 0.7)),
                    ),
                    child: Icon(Icons.restore_outlined),
                  ),
                );
              } else {
                return Container(
                  margin: EdgeInsets.only(
                    top: size.height * 0.05,
                    left: size.width * 0.05 + (AppBar().preferredSize.height * 0.9),
                  ),
                  height: AppBar().preferredSize.height * 0.7,
                  width: AppBar().preferredSize.height * 0.7,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.all(Radius.circular(AppBar().preferredSize.height * 0.7)),
                  ),
                );
              }
            },
          ),

          SizedBox(height: size.height * 0.01),
          // Slider
          Container(
            margin: EdgeInsets.only(
              left: size.width * 0.05 + (AppBar().preferredSize.height * 0.0),
            ),
            decoration: BoxDecoration(
                // color: Color(0xFFF4F2F0),
                ),
            child: Obx(
              () {
                List<Color> colorList = tmo.nonRecommendedColours['color'];
                int length = tmo.nonRecommendedColours['total'];
                return ColorPicker(height: size.height * 0.35, list: colorList, length: length);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _SliderIndicatorPainter extends CustomPainter {
  final double position;
  _SliderIndicatorPainter(this.position);
  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawRRect(
      RRect.fromRectAndCorners(
        Rect.fromCenter(center: Offset(size.width / 2, position), width: 24, height: 12),
        topLeft: Radius.circular(12),
        topRight: Radius.circular(12),
        bottomLeft: Radius.circular(12),
        bottomRight: Radius.circular(12),
      ),
      Paint()..color = Color(0xFFF2CA8A),
    );
  }

  @override
  bool shouldRepaint(_SliderIndicatorPainter old) {
    return true;
  }
}

class ColorPicker extends StatefulWidget {
  final double height;
  final List<Color> list;
  final int length;
  ColorPicker({required this.height, required this.list, required this.length});
  @override
  _ColorPickerState createState() => _ColorPickerState();
}

class _ColorPickerState extends State<ColorPicker> {
  // late final List _colors = widget.tmo.nonRecommendedColours['color'];
  double _colorSliderPosition = 0;
  Color _currentColor = Colors.white;
  @override
  initState() {
    super.initState();
    _currentColor = _calculateSelectedColor(_colorSliderPosition);
  }

  _colorChangeHandler(double position) {
    //handle out of bounds positions
    if (position > widget.height) {
      position = widget.height;
    }
    if (position < 0) {
      position = 0;
    }
    // print("New pos: $position");
    double tempPosition = _colorSliderPosition;
    Color tempColor = _currentColor;

    _currentColor = _calculateSelectedColor(position);
    if (_currentColor == tempColor) {
      _colorSliderPosition = tempPosition;
    } else {
      _colorSliderPosition = position.truncateToDouble();
    }
    setState(() {});
  }

  Color _calculateSelectedColor(double position) {
    //determine color
    double positionInColorArray = (position / widget.height * (widget.length - 1)); // Max number of items
    // print(positionInColorArray);
    int index = positionInColorArray.truncate();
    // print(index);
    Color tempColor = _currentColor;

    if (index >= widget.list.length) {
      return tempColor;
    }
    _currentColor = widget.list[index];
    return _currentColor;
  }

  final TotalMakeOverProvider tmo = Get.find();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // print(_colors);
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        GestureDetector(
          onTap: () {
            String rawColorString = _currentColor.toString();
            rawColorString = rawColorString.replaceAll('Color(0xff', '');
            rawColorString = rawColorString.replaceAll(')', '');
            // tmo.fetchNewColor(rawColorString);
            tmo.changeCentralColorFor(tmo.currentSelectedArea.value, [rawColorString, '']);
          },
          child: Container(
            height: AppBar().preferredSize.height * 0.7,
            width: AppBar().preferredSize.height * 0.7,
            margin: EdgeInsets.only(bottom: 15),
            decoration: BoxDecoration(
              color: _currentColor,
              shape: BoxShape.circle,
            ),
          ),
        ),
        GestureDetector(
          behavior: HitTestBehavior.opaque,
          onVerticalDragStart: (DragStartDetails details) {
            // print("_-------------------------STARTED DRAG");
            _colorChangeHandler(details.localPosition.dy);
          },
          onVerticalDragUpdate: (DragUpdateDetails details) {
            _colorChangeHandler(details.localPosition.dy);
          },
          onTapDown: (TapDownDetails details) {
            _colorChangeHandler(details.localPosition.dy);
          },
          //This outside padding makes it much easier to grab the   slider because the gesture detector has
          // the extra padding to recognize gestures inside of
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: size.height * 0.0, horizontal: size.width * 0.02),
            child: Container(
              height: widget.height,
              width: 5,
              decoration: BoxDecoration(
                // border: Border.all(width: 1, color: Colors.grey[800] as Color),
                borderRadius: BorderRadius.circular(15),
                // gradient: LinearGradient(colors: _colors, begin: Alignment.topCenter, end: Alignment.bottomCenter),
                color: Color(0xFFF2CA8A),
              ),
              child: CustomPaint(
                painter: _SliderIndicatorPainter(_colorSliderPosition),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
