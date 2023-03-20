// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:sofiqe/model/product_model.dart';
// import 'package:sofiqe/provider/total_make_over_provider.dart';
// import 'package:sofiqe/utils/states/function.dart';

// class TotalMakeOverColorSelector extends StatelessWidget {
//   TotalMakeOverColorSelector({Key? key}) : super(key: key);

//   final TotalMakeOverProvider tmo = Get.find();

//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     List colorList = [];
//     tmo.applicationAreaList.forEach((aa) {
//       if (aa.code == tmo.colorMenuVisible.value) {
//         List<Product> productList =
//             aa.products[tmo.centralColorMap[aa.code]['ColourAltHEX']];
//         List<Product> filteredProductList = <Product>[];
//         productList.forEach(
//           (p) {
//             if (aa.selectedBrand.compareTo(p.brand) == 0 ||
//                 aa.selectedBrand.compareTo('ALL') == 0) {
//               filteredProductList.add(p);
//             }
//           },
//         );

//         colorList = filteredProductList;
//       }
//     });
//     return SizedBox(
//       child: Container(
//         constraints: BoxConstraints(
//           minHeight:
//               size.height * 0.05 - 8 + size.height * 0.006 + size.width * 0.01,
//           maxHeight: size.height,
//         ),
//         width: size.width * 0.6 - 10,
//         margin: EdgeInsets.symmetric(
//             vertical: size.height * 0.01, horizontal: size.width * 0.01),
//         padding:
//             EdgeInsets.symmetric(horizontal: 4, vertical: size.width * 0.01),
//         color: Color(0xFFF4F2F0),
//         child: SingleChildScrollView(
//           child: Wrap(
//             // alignment: WrapAlignment.center,
//             // spacing: size.width * 0.01,
//             spacing: 2,
//             runSpacing: size.height * 0.006,
//             children: [
//               ...colorList.map((p) {
//                 double height = size.height * 0.05 - 8;
//                 double width = size.width * 0.6 / 5 - 10 - 8;
//                 double border = 0;
//                 tmo.applicationAreaList.forEach((aa) {
//                   if (aa.code == tmo.colorMenuVisible.value) {
//                     if (aa.selectedShade == p.color) {
//                       border = 2;
//                     }
//                   }
//                 });
//                 return GestureDetector(
//                   onTap: () {
//                     tmo.applicationAreaList.forEach((aa) {
//                       if (aa.code == tmo.colorMenuVisible.value) {
//                         aa.selectedShade = p.color;
//                       }
//                     });
//                     tmo.centralColorMap.refresh();
//                     tmo.colorMenuVisible.refresh();
//                   },
//                   child: Container(
//                     height: height,
//                     width: width,
//                     decoration: BoxDecoration(
//                       border: Border.all(color: Colors.black, width: border),
//                       color: (p.color as String).toColor(),
//                     ),
//                   ),
//                 );
//               }).toList()
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sofiqe/provider/total_make_over_provider.dart';

class TotalMakeOverColorSelector extends StatelessWidget {
  TotalMakeOverColorSelector({Key? key}) : super(key: key);

  final TotalMakeOverProvider tmo = Get.find();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    ApplicationArea aa = ApplicationArea(name: '', id: 0, subOf: FaceArea.LIPS, priority: 0, code: 0);
    List colorList = [];
    tmo.applicationAreaList.forEach((ApplicationArea item) {
      if (item.code == tmo.colorMenuVisible.value) {
        aa = item;
        aa.colors.forEach((k, v) {
          if (listEquals(k, tmo.centralColorMap[aa.code])) {
            colorList = v;
          }
        });
      }
    });
    return SizedBox(
      child: Container(
        constraints: BoxConstraints(
          minHeight: size.height * 0.05 - 8 + size.height * 0.006 + size.width * 0.01,
        ),
        width: size.width * 0.6 - 10,
        margin: EdgeInsets.symmetric(vertical: size.height * 0.01, horizontal: size.width * 0.01),
        padding: EdgeInsets.symmetric(horizontal: 4, vertical: size.width * 0.01),
        color: Color.fromARGB(255, 183, 104, 25),
        child: Wrap(
          // alignment: WrapAlignment.center,
          // spacing: size.width * 0.01,
          spacing: 2,
          runSpacing: size.height * 0.006,
          children: [
            // ...List.generate(10, (index) => null).map(
            //   (index) {
            //     return Container(
            //       height: size.height * 0.05 - 8,
            //       width: size.width * 0.6 / 5 - 10 - 8,
            //       color: Colors.red,
            //     );
            //   },
            // ).toList(),

            // ignore: todo
            // TODO fix this
            ...colorList.map((c) {
              return Container(
                height: size.height * 0.05 - 8,
                width: size.width * 0.6 / 5 - 10 - 8,
                color: c,
              );
            }).toList()
          ],
        ),
      ),
    );
  }
}
